import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/Project/feedback_complaint_screen.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectVM selectedProject;
  const ProjectDetailScreen({super.key, required this.selectedProject});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(title: "Project Detail"),
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Row(
                  children: [
                    Text(
                      SessionController().getLanguage() == 1
                          ? widget.selectedProject.nameEn ?? ""
                          : widget.selectedProject.nameUr ?? "",
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    const Spacer(),
                    Text(
                      widget.selectedProject.id.toString(),
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                child: const AppDivider(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0.h),
                      child: Container(
                        width: 94.0.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.0.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.5.h,
                              spreadRadius: 0.3.h,
                              offset: Offset(0.1.h, 0.1.h),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowList(
                                'Name',
                                SessionController().getLanguage() == 1
                                    ? widget.selectedProject.nameEn ?? ""
                                    : widget.selectedProject.nameUr ?? "",
                              ),
                              rowList(
                                'Description',
                                SessionController().getLanguage() == 1
                                    ? widget.selectedProject.descriptionEn ?? ""
                                    : widget.selectedProject.descriptionUr ??
                                        "",
                              ),
                              rowList(
                                'Location',
                                SessionController().getLanguage() == 1
                                    ? widget.selectedProject.locationEn ?? ""
                                    : widget.selectedProject.locationUr ?? "",
                              ),
                              rowList(
                                'ADP Financial Year',
                                widget.selectedProject.adpYear.toString(),
                              ),
                              rowList(
                                  'Project Leader',
                                  SessionController().getLanguage() == 1
                                      ? widget.selectedProject.projectLeader
                                              ?.projectLeaderNameEn ??
                                          ""
                                      : widget.selectedProject.projectLeader
                                              ?.projectLeaderNameUr ??
                                          ""),
                              rowList(
                                  'PMO',
                                  SessionController().getLanguage() == 1
                                      ? widget.selectedProject.pmo?.pmoNameEn ??
                                          ""
                                      : widget.selectedProject.pmo?.pmoNameUr ??
                                          ""),
                              rowList(
                                'Commattee Member',
                                SessionController().getLanguage() == 1
                                    ? widget.selectedProject
                                            .committeeMembersNameEn ??
                                        ""
                                    : widget.selectedProject
                                            .committeeMembersNameUr ??
                                        "",
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
                                child: const AppDivider(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Halka",
                                        style: AppTextStyle.normalGrey10,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject.halka
                                                    ?.halkaNameEn ??
                                                ""
                                            : widget.selectedProject.halka
                                                    ?.halkaNameUr ??
                                                "",
                                        style: AppTextStyle.semiBoldBlack10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Union Councile",
                                        style: AppTextStyle.normalGrey10,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject.uc
                                                    ?.ucNameEn ??
                                                ""
                                            : widget.selectedProject.uc
                                                    ?.ucNameUr ??
                                                "",
                                        style: AppTextStyle.semiBoldBlack10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Ward",
                                        style: AppTextStyle.normalGrey10,
                                      ),
                                      SizedBox(
                                        height: 1.0.h,
                                      ),
                                      Text(
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject.ward
                                                    ?.wardNameEn ??
                                                ""
                                            : widget.selectedProject.ward
                                                    ?.wardNameUr ??
                                                "",
                                        style: AppTextStyle.semiBoldBlack10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: ButtonWidgetPermBlue(
                        buttonText: "Feedback/Complaint",
                        onPress: () {
                          Get.to(() => FeedbackComplaintScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Row rowList(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: AppTextStyle.normalBlack10,
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 1.8.h),
          child: Text(
            text2,
            style: AppTextStyle.semiBoldBlack10,
          ),
        ),
      ],
    );
  }
}
