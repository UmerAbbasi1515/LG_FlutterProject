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

class GetMultipleFeedbackComplaintScreen extends StatefulWidget {
  final String projectId;
  final ProjectVM selectproject;
  const GetMultipleFeedbackComplaintScreen(
      {super.key, required this.projectId, required this.selectproject});

  @override
  State<GetMultipleFeedbackComplaintScreen> createState() =>
      _GetMultipleFeedbackComplaintScreenState();
}

class _GetMultipleFeedbackComplaintScreenState
    extends State<GetMultipleFeedbackComplaintScreen> {
  final controller = Get.put(ProjectController());

  final player = AudioPlayer();
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();
    getFeedbackData();
  }

  getFeedbackData() async {
    await controller.getProjectsMultipleFeedback(widget.projectId);
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

      // 👇 Cancel old listener before creating new one
      await _playerSubscription?.cancel();

      setState(() {
        playingAudioUrl = url;
        isPlaying = true;
      });

      await player.setUrl(url);
      await player.play();

      // 👇 Store the subscription
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
    setState(() {});
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          final data = controller.feedbackListDetailModel.value.data;
          return controller.temp.value
              ? SizedBox()
              : Column(
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
                            child: Center(child: LoadingIndicatorBlue()),
                          ))
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
                                          buildText(
                                              "Name",
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? data?.first?.nameEn ?? ""
                                                  : data?.first?.nameUr ?? ""),
                                          buildText("Email",
                                              data?.first?.email ?? ""),
                                          buildText("Phone",
                                              data?.first?.phone ?? ""),
                                        ],
                                      ),
                                    ),

                                    // ================= CARD 2 (COMPLAINT + MEDIA) =================
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                              .feedbackListDetailModel
                                              .value
                                              .data
                                              ?.length ??
                                          0,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        final data = controller
                                            .feedbackListDetailModel
                                            .value
                                            .data![index];

                                        final media = data?.media;

                                        return Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          padding: EdgeInsets.all(3.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.grey1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade50,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // ================= TEXT =================
                                              Text(
                                                AppMetaLabels().description,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 1.h),

                                              buildTextComplaint("Complaint",
                                                  data?.textMessage ?? ""),

                                              // ================= IMAGE + VIDEO =================
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // ================= IMAGES =================
                                                  if (media!.any((e) =>
                                                      e.mediaType == 'image'))
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              AppMetaLabels()
                                                                  .image,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(height: 1.h),
                                                          SizedBox(
                                                            height: 12.h,
                                                            child: ListView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              children: media
                                                                  .where((e) =>
                                                                      e.mediaType ==
                                                                      'image')
                                                                  .map((e) =>
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                10),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
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
                                                                                        icon: const Icon(Icons.close, color: Colors.white, size: 30),
                                                                                        onPressed: () => Navigator.pop(context),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            child:
                                                                                Image.network(
                                                                              e.previewUrl ?? "",
                                                                              width: 40.w,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  SizedBox(width: 2.w),

                                                  // ================= VIDEOS =================
                                                  if (media.any((e) =>
                                                      e.mediaType == 'video'))
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              AppMetaLabels()
                                                                  .video,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          SizedBox(height: 1.h),
                                                          SizedBox(
                                                            height: 12.h,
                                                            child: ListView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              children: media
                                                                  .where((e) =>
                                                                      e.mediaType ==
                                                                      'video')
                                                                  .map((e) =>
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            _showVideoFromUrl(e.previewUrl ??
                                                                                ""),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              40.w,
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              right: 10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.black12,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          child: const Icon(
                                                                              Icons.play_circle,
                                                                              size: 40),
                                                                        ),
                                                                      ))
                                                                  .toList(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),

                                              SizedBox(height: 2.h),

                                              // ================= AUDIO =================
                                              if (media.any((e) =>
                                                  e.mediaType == 'audio')) ...[
                                                Text(AppMetaLabels().audio,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Column(
                                                  children: media
                                                      .where((e) =>
                                                          e.mediaType ==
                                                          'audio')
                                                      .map((e) {
                                                    final url = e.previewUrl
                                                            ?.replaceAll(
                                                                'audios',
                                                                'audio') ??
                                                        "";

                                                    final isCurrent =
                                                        playingAudioUrl == url;

                                                    return Card(
                                                      child: ListTile(
                                                        leading: Icon(
                                                          isCurrent && isPlaying
                                                              ? Icons
                                                                  .pause_circle_filled
                                                              : Icons
                                                                  .play_circle_fill,
                                                          color:
                                                              AppColors.bgBlue1,
                                                          size: 35,
                                                        ),
                                                        title: Text(
                                                          isCurrent && isPlaying
                                                              ? AppMetaLabels()
                                                                  .playing
                                                              : AppMetaLabels()
                                                                  .playAudio,
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
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0.1.h),
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
                            ),
                          ),
                  ],
                );
        }),
      ),
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
