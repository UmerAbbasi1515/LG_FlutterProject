import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:sizer/sizer.dart';

class FeedbackComplaintScreen extends StatefulWidget {
  const FeedbackComplaintScreen({super.key});

  @override
  State<FeedbackComplaintScreen> createState() =>
      _FeedbackComplaintScreenState();
}

class _FeedbackComplaintScreenState extends State<FeedbackComplaintScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final complaintController = TextEditingController();

  File? imageFile;
  File? videoFile;
  File? audioFile;

  final ImagePicker picker = ImagePicker();

  /// AUDIO
  final recorder = AudioRecorder();
  final player = AudioPlayer();
  bool isRecording = false;

  /// Pick Image
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => imageFile = File(picked.path));
    }
  }

  /// Pick Video
  Future<void> pickVideo() async {
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => videoFile = File(picked.path));
    }
  }

  /// Start Recording
  Future<void> startRecording() async {
    if (await recorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await recorder.start(
        const RecordConfig(),
        path: path,
      );

      setState(() => isRecording = true);
    }
  }

  /// Stop Recording
  Future<void> stopRecording() async {
    final path = await recorder.stop();
    setState(() {
      isRecording = false;
      if (path != null) {
        audioFile = File(path);
      }
    });
  }

  /// Play Audio
  Future<void> playAudio() async {
    if (audioFile != null) {
      await player.setFilePath(audioFile!.path);
      player.play();
    }
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();
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
            CustomAppBar2(title: "Feedback / Complaint"),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    children: [
                      buildTextField("Name", nameController),
                      buildTextField("Email", emailController),
                      buildTextField("Phone / WhatsApp", phoneController),
                      buildTextField("Write complaint...", complaintController,
                          maxLines: 5),

                      SizedBox(height: 2.h),

                      /// IMAGE
                      ButtonWidgetPermBlue(
                        buttonText: "Upload Image",
                        onPress: pickImage,
                      ),

                      if (imageFile != null)
                        Image.file(imageFile!, height: 100),

                      SizedBox(height: 2.h),

                      /// VIDEO
                      ButtonWidgetPermBlue(
                        buttonText: "Upload Video",
                        onPress: pickVideo,
                      ),

                      if (videoFile != null)
                        const Text("Video Selected"),

                      SizedBox(height: 2.h),

                      /// AUDIO RECORD
                      Row(
                        children: [
                          Expanded(
                            child: ButtonWidgetPermBlue(
                              buttonText: isRecording
                                  ? "Stop Recording"
                                  : "Start Recording",
                              onPress: isRecording
                                  ? stopRecording
                                  : startRecording,
                            ),
                          ),
                        ],
                      ),

                      if (audioFile != null)
                        Column(
                          children: [
                            SizedBox(height: 1.h),
                            Text("Audio Recorded"),
                            ButtonWidgetPermBlue(
                              buttonText: "Play Audio",
                              onPress: playAudio,
                            ),
                          ],
                        ),

                      SizedBox(height: 3.h),

                      /// SUBMIT
                      ButtonWidgetPermBlue(
                        buttonText: "Submit",
                        onPress: () {
                          if (kDebugMode) {
                            print(audioFile?.path);
                          } // ready for API
                        },
                      ),
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

  Widget buildTextField(String hint, TextEditingController controller,
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