import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:just_audio/just_audio.dart';

import 'project_controller.dart';

class FeedbackComplaintDetailScreen extends StatefulWidget {
  final String projectId;
  const FeedbackComplaintDetailScreen({super.key, required this.projectId});

  @override
  State<FeedbackComplaintDetailScreen> createState() =>
      _FeedbackComplaintDetailScreenState();
}

class _FeedbackComplaintDetailScreenState
    extends State<FeedbackComplaintDetailScreen> {
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
      // ignore: use_build_context_synchronously
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
  Future<void> playAudioFromUrl(String url) async {
    await player.setUrl(url);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    final dataList = controller.feedbackDetailModel.value.data ?? [];

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
                      // ================= TEXT =================
                      buildText("Name",
                          dataList.isNotEmpty ? dataList.first.nameEn : ""),
                      buildText("Email",
                          dataList.isNotEmpty ? dataList.first.email : ""),
                      buildText("Phone / WhatsApp",
                          dataList.isNotEmpty ? dataList.first.phone : ""),
                      buildTextComplaint(
                        "Feedback / complaint...",
                        dataList.isNotEmpty ? dataList.first.textMessage : "",
                      ),
                      // ================= FULL LIST =================
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          final item = dataList[index];
                          final media = item.media;

                          final images = media
                              .where((e) => e.mediaType == "image")
                              .toList();

                          final videos = media
                              .where((e) => e.mediaType == "video")
                              .toList();

                          final audios = media
                              .where((e) => e.mediaType == "audio")
                              .toList();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ================= IMAGES =================
                              if (images.isNotEmpty) ...[
                                Text("Images",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 1.h),
                                SizedBox(
                                  height: 12.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: images.length,
                                    itemBuilder: (context, i) {
                                      final img = images[i];

                                      return Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image.network(
                                            img.previewUrl ?? "",
                                            width: 20.w,
                                            height: 12.h,
                                            fit: BoxFit.cover,
                                          ));
                                    },
                                  ),
                                ),
                              ],

                              SizedBox(height: 2.h),

                              // ================= VIDEOS =================
                              if (videos.isNotEmpty) ...[
                                Text("Videos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 1.h),
                                SizedBox(
                                  height: 12.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: videos.length,
                                    itemBuilder: (context, i) {
                                      final video = videos[i];

                                      return GestureDetector(
                                        onTap: () => _showVideoFromUrl(
                                            video.previewUrl ?? ""),
                                        child: Container(
                                          width: 20.w,
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(Icons.play_circle,
                                              size: 40),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],

                              SizedBox(height: 2.h),

                              // ================= AUDIO =================
                              if (audios.isNotEmpty) ...[
                                Text("Audio",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 1.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: audios.length,
                                  itemBuilder: (context, i) {
                                    final audio = audios[i];

                                    return Card(
                                      child: ListTile(
                                        leading: const Icon(Icons.audiotrack),
                                        title: Text("Audio ${i + 1}"),
                                        onTap: () => playAudioFromUrl(
                                            audio.previewUrl ?? ""),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          );
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

  // ---------------- TEXT UI ----------------
  Widget buildText(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(1.5.h),
        ),
        child: Text(
          value.isEmpty ? label : value,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget buildTextComplaint(String hint, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(1.5.h),
        ),
        child: Text(
          value.isEmpty ? hint : value,
        ),
      ),
    );
  }
}
