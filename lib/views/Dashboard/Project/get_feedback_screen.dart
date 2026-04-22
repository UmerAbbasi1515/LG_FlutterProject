// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/views/Dashboard/Project/add_feedback_screen.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';

import 'project_controller.dart';

class GetFeedbackComplaintScreen extends StatefulWidget {
  final String projectId;
  final ProjectVM selectproject;
  const GetFeedbackComplaintScreen(
      {super.key, required this.projectId, required this.selectproject});

  @override
  State<GetFeedbackComplaintScreen> createState() =>
      _GetFeedbackComplaintScreenState();
}

class _GetFeedbackComplaintScreenState
    extends State<GetFeedbackComplaintScreen> {
  final controller = Get.put(ProjectController());

  final player = AudioPlayer();
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    getFeedbackData();
  }

  getFeedbackData() async {
    await controller.getProjectsFeedback(widget.projectId);
  }

  @override
  void dispose() {
    player.dispose();
    videoController?.dispose();
    _playerSubscription?.cancel();
    super.dispose();
  }

  // ---------------- VIDEO ----------------
  Future<void> _showVideoFromUrl(String url) async {
    videoController?.dispose();

    videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoController!.initialize();

    setState(() {});
    videoController!.play();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: videoController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: videoController!.value.aspectRatio,
                      child: VideoPlayer(videoController!),
                    )
                  : const CircularProgressIndicator(),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  videoController?.pause();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- AUDIO ----------------
  String? playingAudioUrl;
  bool isPlaying = false;
  StreamSubscription? _playerSubscription;

  Future<void> playAudioFromUrl(String url) async {
    try {
      if (playingAudioUrl == url && isPlaying) {
        await player.pause();
        setState(() => isPlaying = false);
        return;
      }

      await player.stop();
      await _playerSubscription?.cancel();

      setState(() {
        playingAudioUrl = url;
        isPlaying = true;
      });

      await player.setUrl(url);
      await player.play();

      _playerSubscription = player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            isPlaying = false;
            playingAudioUrl = null;
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Audio error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          // ✅ NEW: data is now a single object, not a list
          final data = controller.feedbackDetailModel.value.data;

          return Column(
            children: [
              CustomAppBarDoubleBackAddFeedback(
                title: AppMetaLabels().feedbackComplaint,
                onAddPressed: () {
                  Get.to(() => AddFeedbackComplaintScreen(
                        selectproject: widget.selectproject,
                      ));
                },
              ),
              controller.loadingProjectsData.value
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: LoadingIndicatorBlue(),
                      ),
                    )
                  : data == null
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Text(
                              "No feedback found.",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: Column(
                                children: [
                                  // ================= CARD 1 (USER INFO) =================
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(3.w),
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.grey1),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Column(
                                      children: [
                                        buildText("Name", data.nameEn),
                                        buildText("Email", data.email),
                                        buildText("Phone", data.phone),
                                      ],
                                    ),
                                  ),

                                  // ================= CARD 2 (COMPLAINT + MEDIA) =================
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(3.w),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: AppColors.grey1),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppMetaLabels().description,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 1.h),

                                        // ================= COMPLAINT TEXT =================
                                        buildTextComplaint(
                                          "Complaint",
                                          data.textMessage ,
                                        ),

                                        SizedBox(height: 1.h),

                                        // ================= MEDIA SECTION =================
                                        _buildMediaSection(data.media),

                                        SizedBox(height: 2.h),

                                        // ================= ADD MORE BUTTON =================
                                        Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: 60.w,
                                            child: ButtonWidgetPermBlue(
                                              buttonText: AppMetaLabels()
                                                  .addMoreFeedbackComplaint,
                                              onPress: () {
                                                Get.to(() =>
                                                    AddFeedbackComplaintScreen(
                                                      selectproject:
                                                          widget.selectproject,
                                                    ));
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
            ],
          );
        }),
      ),
    );
  }

  // ================= MEDIA SECTION WIDGET =================
  Widget _buildMediaSection(List<FeedbackMedia> media) {
    if (media.isEmpty) return const SizedBox.shrink();

    final images = media.where((e) => e.mediaType == 'image').toList();
    final videos = media.where((e) => e.mediaType == 'video').toList();
    final audios = media.where((e) => e.mediaType == 'audio').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================= IMAGES =================
        if (images.isNotEmpty) ...[
          Text(
            AppMetaLabels().image,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 12.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final e = images[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.black,
                          insetPadding: EdgeInsets.zero,
                          child: Stack(
                            children: [
                              Center(
                                child: InteractiveViewer(
                                  minScale: 0.5,
                                  maxScale: 4,
                                  child: Image.network(
                                    e.previewUrl ?? "",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                right: 20,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white, size: 30),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        e.previewUrl ?? "",
                        width: 40.w,
                        height: 12.h,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 40.w,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.broken_image,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
        ],

        // ================= VIDEOS =================
        if (videos.isNotEmpty) ...[
          Text(
            AppMetaLabels().video,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 12.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final e = videos[index];
                return GestureDetector(
                  onTap: () => _showVideoFromUrl(e.previewUrl ?? ""),
                  child: Container(
                    width: 40.w,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.play_circle, size: 40),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
        ],

        // ================= AUDIO =================
        if (audios.isNotEmpty) ...[
          Text(
            AppMetaLabels().audio,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1.h),
          Column(
            children: audios.map((e) {
              final url = e.previewUrl?.replaceAll('audios', 'audio') ?? "";
              final isCurrent = playingAudioUrl == url;

              return Card(
                child: ListTile(
                  leading: Icon(
                    isCurrent && isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    color: AppColors.bgBlue1,
                    size: 35,
                  ),
                  title: Text(
                    isCurrent && isPlaying
                        ? AppMetaLabels().playing
                        : AppMetaLabels().playAudio,
                  ),
                  onTap: () {
                    playAudioFromUrl(url);
                    setState(() {});
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  // ---------------- TEXT UI ----------------
  Widget buildText(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          value.isEmpty ? label : value,
          style: TextStyle(
            fontSize: 14,
            color: value.isEmpty ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildTextComplaint(String hint, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          value.isEmpty ? hint : value,
          style: TextStyle(
            fontSize: 14,
            color: value.isEmpty ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}