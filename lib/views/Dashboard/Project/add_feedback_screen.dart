import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:localgovernment_project/views/widgets/snackbar_widget.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'dart:math';

import 'project_controller.dart';

class AddFeedbackComplaintScreen extends StatefulWidget {
  final ProjectVM selectproject;
  const AddFeedbackComplaintScreen({super.key, required this.selectproject});

  @override
  State<AddFeedbackComplaintScreen> createState() =>
      _AddFeedbackComplaintScreenState();
}

class _AddFeedbackComplaintScreenState extends State<AddFeedbackComplaintScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(ProjectController());

  final ImagePicker picker = ImagePicker();

  // #region Pick Image
  File? imageFile;
  Future<void> pickImage(String type) async {
    if (type == "Camera") {
      final picked = await picker.pickImage(source: ImageSource.camera);
      if (picked != null) {
        setState(() => imageFile = File(picked.path));
      }
    } else {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => imageFile = File(picked.path));
      }
    }
  }
  // #endregion

  // #region Video
  File? videoFile;
  Future<void> pickVideo(String type) async {
    if (type == "Camera") {
      final picked = await picker.pickVideo(source: ImageSource.camera);
      if (picked != null) {
        setState(() => videoFile = File(picked.path));
      }
    } else {
      final picked = await picker.pickVideo(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => videoFile = File(picked.path));
      }
    }
  }

  VideoPlayerController? videoController;
  Future<void> playVideo(File file) async {
    videoController?.dispose();
    videoController = VideoPlayerController.file(file);
    await videoController!.initialize();
    setState(() {}); // ✅ this is why await is needed
  }
  // #endregion

  // #region Recording
  bool isRecording = false;
  bool isDone = false;
  bool isPlaying = false;
  int recordSeconds = 0;
  Timer? _recordTimer;
  Timer? _playTimer;
  int playSeconds = 0;

  final recorder = AudioRecorder();
  final player = AudioPlayer();
  File? audioFile;

  late AnimationController _blinkController;
  late AnimationController _waveController;

  Future<void> startRecording() async {
    if (await recorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await recorder.start(
        const RecordConfig(),
        path: path,
      );

      setState(() => isRecording = true);
    }
  }

  Future<void> stopRecording() async {
    final path = await recorder.stop();
    setState(() {
      isRecording = false;
      if (path != null) {
        audioFile = File(path);
      }
    });
  }

  Future<void> playAudio() async {
    if (audioFile != null) {
      await player.setFilePath(audioFile!.path);
      player.play();
    }
  }

// Waveform bars heights (28 bars)
  final List<double> _barHeights = List.generate(28, (_) => 4.0);
  final Random _random = Random();

  void _startRecording() async {
    await startRecording(); // your existing function
    setState(() {
      isRecording = true;
      isDone = false;
      recordSeconds = 0;
    });

    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => recordSeconds++);
    });

    // Animate waveform
    Timer.periodic(const Duration(milliseconds: 80), (t) {
      if (!isRecording) {
        t.cancel();
        return;
      }
      setState(() {
        for (int i = 0; i < _barHeights.length - 1; i++) {
          _barHeights[i] = _barHeights[i + 1];
        }
        _barHeights[_barHeights.length - 1] = 4 + _random.nextDouble() * 24;
      });
    });
  }

  void _togglePlay() {
    if (!isDone) return;
    if (!isPlaying) {
      playAudio(); // your existing function
      setState(() {
        isPlaying = true;
        playSeconds = 0;
      });
      _playTimer?.cancel(); // ✅ cancel any existing timer first
      _playTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() {
          playSeconds++;
          if (playSeconds >= recordSeconds) {
            _playTimer?.cancel(); // ✅ cancel when done
            _playTimer = null;
            isPlaying = false;
            playSeconds = 0;
          }
        });
      });
    } else {
      _playTimer?.cancel(); // ✅ cancel on pause
      _playTimer = null;
      setState(() {
        isPlaying = false;
      });
    }
  }

  void _stopRecording() async {
    await stopRecording();
    _recordTimer?.cancel(); // ✅ cancel record timer
    _recordTimer = null;
    setState(() {
      isRecording = false;
      isDone = true;
    });
  }

  void _deleteAudio() {
    _playTimer?.cancel(); // ✅
    _recordTimer?.cancel(); // ✅
    _playTimer = null;
    _recordTimer = null;
    setState(() {
      audioFile = File('');
      isDone = false;
      isRecording = false;
      isPlaying = false;
      recordSeconds = 0;
      playSeconds = 0;
      for (int i = 0; i < _barHeights.length; i++) {
        _barHeights[i] = 4.0;
      }
    });
  }

  String _formatSeconds(int s) =>
      '${(s ~/ 60)}:${(s % 60).toString().padLeft(2, '0')}';

  // #endregion

  @override
  void initState() {
    super.initState();

    _blinkController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    _waveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = SessionController().getUser();

      setState(() {
        controller.nameController.text = SessionController().getLanguage() == 1
            ? (user.nameEn ?? "")
            : (user.nameUr ?? "");

        controller.emailController.text = user.email ?? "";
        controller.phoneController.text = user.phone ?? "";
        controller.complaintController.text = "";
      });
    });
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();
    videoController?.dispose();
    _blinkController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomAppBar2(title: AppMetaLabels().feedbackComplaint),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    children: [
                      buildTextField(
                          AppMetaLabels().name, controller.nameController),
                      buildTextField(
                          AppMetaLabels().email, controller.emailController),
                      buildTextField(AppMetaLabels().whatsappPhone,
                          controller.phoneController),
                      buildTextFieldComplaint(AppMetaLabels().writeComplaint,
                          controller.complaintController,
                          maxLines: 5),

                      SizedBox(height: 2.h),

                      // #region Image
                      ButtonWidgetPermBlueIcon(
                        buttonText: AppMetaLabels().uploadImage,
                        onPress: _showImageSourceDialog,
                        icon: Icons.image_outlined,
                      ),
                      if (imageFile != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => Dialog(
                                        backgroundColor: AppColors
                                            .chartlightBlueColorCharges,
                                        insetPadding: EdgeInsets.zero,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: InteractiveViewer(
                                                // ✅ allows pinch to zoom
                                                child: Image.file(
                                                  imageFile!,
                                                  fit: BoxFit.contain,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 40,
                                              right: 16,
                                              child: IconButton(
                                                icon: const Icon(Icons.close,
                                                    color: Colors.white,
                                                    size: 30),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.file(
                                    imageFile!,
                                    width: 20.0.w,
                                    height: 9.0.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      imageFile = File('');
                                    });
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    padding: const EdgeInsets.all(2),
                                    child: Icon(Icons.cancel_outlined,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      // #endregion

                      SizedBox(height: 0.2.h),

                      // #region Video
                      ButtonWidgetPermBlueIcon(
                        buttonText: AppMetaLabels().uploadVideo,
                        onPress: _showVideoSourceDialog,
                        icon: Icons.videocam_outlined,
                      ),
                      if (videoFile != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _showVideoDialog(videoFile!);
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 20.0.w,
                                    height: 9.0.h,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.chartlightBlueColorCharges,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _showVideoDialog(videoFile!);
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.play_circle,
                                      color: Colors.white, size: 40),
                                ),
                                Positioned(
                                  // ✅ top left
                                  top: 0,
                                  left: 0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        videoFile = File('');
                                      });
                                    },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: const EdgeInsets.all(0),
                                      child: const Icon(Icons.cancel_outlined,
                                          color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      // #endregion

                      SizedBox(height: 0.2.h),

                      // #region Audio
                      _buildAudioUI(),
                      // #endregion

                      SizedBox(height: 2.h),

                      /// SUBMIT
                      Obx(() {
                        return controller.loadingProjectsData.value
                            ? LoadingIndicatorBlue()
                            : ButtonWidgetPermBlue(
                                buttonText: AppMetaLabels().submit,
                                onPress: () {
                                  // Mandatory fields validation
                                  if (controller.nameController.text
                                      .trim()
                                      .isEmpty) {
                                    SnakBarWidget.getSnackBarError(
                                        AppMetaLabels().error,
                                        AppMetaLabels().nameRequired);
                                    return;
                                  }
                                  if (controller.emailController.text
                                      .trim()
                                      .isEmpty) {
                                    SnakBarWidget.getSnackBarError(
                                        AppMetaLabels().error,
                                        AppMetaLabels().emailRequired);
                                    return;
                                  }
                                  if (controller.phoneController.text
                                      .trim()
                                      .isEmpty) {
                                    SnakBarWidget.getSnackBarError(
                                        AppMetaLabels().error,
                                        AppMetaLabels().phoneRequired);
                                    return;
                                  }

                                  // At least one of these must be provided
                                  final bool hasText = controller
                                      .complaintController.text
                                      .trim()
                                      .isNotEmpty;
                                  final bool hasImage = imageFile != null;
                                  final bool hasVideo = videoFile != null;
                                  final bool hasAudio = audioFile != null;

                                  if (!hasText &&
                                      !hasImage &&
                                      !hasVideo &&
                                      !hasAudio) {
                                    SnakBarWidget.getSnackBarError(
                                        AppMetaLabels().error,
                                        AppMetaLabels().mediaRequiredMessage);
                                    return;
                                  }

                                  FeedBackRequestModel feedbackRequestModel =
                                      FeedBackRequestModel(
                                    name: controller.nameController.text,
                                    email: controller.emailController.text,
                                    phone: controller.phoneController.text,
                                    projectId:
                                        widget.selectproject.id.toString(),
                                    complaintFeedbackText:
                                        controller.complaintController.text,
                                    videoFile: videoFile,
                                    audioFile: audioFile,
                                    imageFile: imageFile,
                                  );
                                  controller.submitFeedBack(
                                      feedbackRequestModel,
                                      widget.selectproject);
                                },
                              );
                      }),
                      SizedBox(
                        height: 2.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2.h)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Image Source", // or hardcode "Select Image Source"
              style: AppTextStyle.semiBoldBlack12,
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading:
                  Icon(Icons.camera_alt_outlined, color: AppColors.blueColor),
              title: Text("Camera", style: AppTextStyle.normalBlack12),
              onTap: () {
                Navigator.pop(context);
                pickImage("Camera");
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined,
                  color: AppColors.blueColor),
              title: Text("Gallery", style: AppTextStyle.normalBlack12),
              onTap: () {
                Navigator.pop(context);
                pickImage("Gallery");
              },
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  void _showVideoSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2.h)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Image Source", // or hardcode "Select Image Source"
              style: AppTextStyle.semiBoldBlack12,
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading:
                  Icon(Icons.camera_alt_outlined, color: AppColors.blueColor),
              title: Text("Camera", style: AppTextStyle.normalBlack12),
              onTap: () {
                Navigator.pop(context);
                pickVideo("Camera");
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library_outlined,
                  color: AppColors.blueColor),
              title: Text("Gallery", style: AppTextStyle.normalBlack12),
              onTap: () {
                Navigator.pop(context);
                pickVideo("Gallery");
              },
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }

  Future<void> _showVideoDialog(File videoFile) async {
    await playVideo(videoFile); // ✅ wait for init + setState

    if (!mounted) return;

    // ✅ play BEFORE showing dialog
    videoController!.play();
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: AppColors.chartlightBlueColorCharges,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              Center(
                child: videoController != null &&
                        videoController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoController!.value.aspectRatio,
                        child: VideoPlayer(videoController!),
                      )
                    : const CircularProgressIndicator(color: Colors.white),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    videoController?.pause();
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        videoController?.value.isPlaying == true
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () {
                        setDialogState(() {
                          videoController?.value.isPlaying == true
                              ? videoController?.pause()
                              : videoController?.play();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    videoController!.play();
  }

// The UI Widget
  Widget _buildAudioUI() {
    return Column(
      children: [
        // Record / Stop button
        SizedBox(
          width: 90.0.w,
          child: ElevatedButton.icon(
            onPressed: isRecording ? _stopRecording : _startRecording,
            icon: Icon(
              isRecording ? Icons.stop_rounded : Icons.mic,
              size: 18,
              color: isRecording ? Colors.red.shade800 : Colors.white,
            ),
            label: Text(
              isRecording
                  ? AppMetaLabels().stopRecording
                  : isDone
                      ? AppMetaLabels().recordAgain
                      : AppMetaLabels().startRecording,
              style: TextStyle(
                color: isRecording ? Colors.red.shade800 : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isRecording ? Colors.red.shade50 : AppColors.blueColor,
              side: isRecording
                  ? BorderSide(color: Colors.red.shade200)
                  : BorderSide.none,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.3.h),
              ),
              elevation: 0,
            ),
          ),
        ),

        // Waveform row (shown while recording OR done)
        if (isRecording || isDone)
          Container(
            margin: EdgeInsets.only(top: 12, left: 3.w, right: 2.w),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Play/Pause or blinking record dot
                GestureDetector(
                  onTap: isDone ? _togglePlay : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isRecording ? Colors.red : AppColors.blueColor,
                      shape: BoxShape.circle,
                    ),
                    child: isRecording
                        ? _BlinkingIcon() // see below
                        : Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                ),
                SizedBox(width: 8),
                // Waveform bars
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _barHeights.map((h) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 80),
                        width: 3,
                        height: isDone ? 4 + (h / 28) * 24 : h,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(width: 8),

                // Timer
                Text(
                  isPlaying
                      ? _formatSeconds(playSeconds)
                      : _formatSeconds(recordSeconds),
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade600,
                  ),
                ),

                // Delete button (only when done)
                if (isDone)
                  GestureDetector(
                    onTap: _deleteAudio,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.red.shade200, width: 0.5),
                      ),
                      child: Icon(Icons.close,
                          color: Colors.red.shade700, size: 14),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildTextField(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        enabled: true,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.5.h),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldComplaint(String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.5.h),
          ),
        ),
      ),
    );
  }
}

class _BlinkingIcon extends StatefulWidget {
  @override
  State<_BlinkingIcon> createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<_BlinkingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _c,
      child: const Icon(Icons.stop_rounded, color: Colors.white, size: 18),
    );
  }
}
