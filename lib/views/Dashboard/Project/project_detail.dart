import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/project_model/project_model.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/Project/add_feedback_screen.dart';
import 'package:localgovernment_project/views/Dashboard/Project/get_multiplefeedback_screen.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_controller.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectVM selectedProject;
  const ProjectDetailScreen({super.key, required this.selectedProject});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  ProjectController controller = Get.put(ProjectController());
  @override
  void initState() {
    isFeedbackinit();
    super.initState();
  }

  isFeedbackinit() async {
    await controller.isFeedbackAdded(widget.selectedProject.id.toString());
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
            return controller.loadingProjectsData.value == true
                ? Column(
                    children: [
                      CustomAppBar2(title: AppMetaLabels().projectDetail),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Center(child: LoadingIndicatorBlue()),
                      )
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomAppBar2(title: AppMetaLabels().projectDetail),
                      Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: Row(
                          children: [
                            Text(
                              SessionController().getLanguage() == 1
                                  ? widget.selectedProject.nameEn ?? ""
                                  : widget.selectedProject.nameUr ?? "",
                              style: AppTextStyle.semiBoldBlack15,
                            ),
                            const Spacer(),
                            Text(
                              widget.selectedProject.id.toString(),
                              style: AppTextStyle.semiBoldBlack15,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      rowList(
                                        AppMetaLabels().name,
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject.nameEn ??
                                                ""
                                            : widget.selectedProject.nameUr ??
                                                "",
                                      ),
                                      rowList(
                                        AppMetaLabels().description,
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject
                                                    .descriptionEn ??
                                                ""
                                            : widget.selectedProject
                                                    .descriptionUr ??
                                                "",
                                      ),
                                      rowList(
                                        AppMetaLabels().name,
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject
                                                    .locationEn ??
                                                ""
                                            : widget.selectedProject
                                                    .locationUr ??
                                                "",
                                      ),
                                      rowList(
                                        AppMetaLabels().adpFinancialYear,
                                        widget.selectedProject.adpYear
                                            .toString(),
                                      ),
                                      rowList(
                                          AppMetaLabels().projectLeader,
                                          SessionController().getLanguage() == 1
                                              ? widget
                                                      .selectedProject
                                                      .projectLeader
                                                      ?.projectLeaderNameEn ??
                                                  ""
                                              : widget
                                                      .selectedProject
                                                      .projectLeader
                                                      ?.projectLeaderNameUr ??
                                                  ""),
                                      rowList(
                                          AppMetaLabels().pmo,
                                          SessionController().getLanguage() == 1
                                              ? widget.selectedProject.pmo
                                                      ?.pmoNameEn ??
                                                  ""
                                              : widget.selectedProject.pmo
                                                      ?.pmoNameUr ??
                                                  ""),
                                      rowList(
                                        AppMetaLabels().committeeMember,
                                        SessionController().getLanguage() == 1
                                            ? widget.selectedProject
                                                    .committeeMembersNameEn ??
                                                ""
                                            : widget.selectedProject
                                                    .committeeMembersNameUr ??
                                                "",
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.0.h, bottom: 2.0.h),
                                        child: const AppDivider(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                AppMetaLabels().halka,
                                                style:
                                                    AppTextStyle.normalGrey12,
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Text(
                                                SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? widget
                                                            .selectedProject
                                                            .halka
                                                            ?.halkaNameEn ??
                                                        ""
                                                    : widget
                                                            .selectedProject
                                                            .halka
                                                            ?.halkaNameUr ??
                                                        "",
                                                style: AppTextStyle
                                                    .semiBoldBlack13,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                AppMetaLabels().unionCouncil,
                                                style:
                                                    AppTextStyle.normalGrey12,
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Text(
                                                SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? widget.selectedProject.uc
                                                            ?.ucNameEn ??
                                                        ""
                                                    : widget.selectedProject.uc
                                                            ?.ucNameUr ??
                                                        "",
                                                style: AppTextStyle
                                                    .semiBoldBlack13,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                AppMetaLabels().ward,
                                                style:
                                                    AppTextStyle.normalGrey12,
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              Text(
                                                SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? widget.selectedProject
                                                            .ward?.wardNameEn ??
                                                        ""
                                                    : widget.selectedProject
                                                            .ward?.wardNameUr ??
                                                        "",
                                                style: AppTextStyle
                                                    .semiBoldBlack13,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.isFeedbackAddedModel.value.data
                                              ?.isfeedbackAdded ==
                                          true
                                      ? Padding(
                                          padding: EdgeInsets.all(0.1.h),
                                          child: SizedBox(
                                            width: 47.w,
                                            child: ButtonWidgetPermBlue(
                                              buttonText: AppMetaLabels()
                                                  .viewFeedbackComplaint,
                                              onPress: () {
                                                Get.to(() =>
                                                    GetMultipleFeedbackComplaintScreen(
                                                        projectId: widget
                                                            .selectedProject.id
                                                            .toString(),
                                                        selectproject: widget
                                                            .selectedProject));
                                                // Get.to(() =>
                                                //     GetFeedbackComplaintScreen(
                                                //       projectId: widget
                                                //           .selectedProject.id
                                                //           .toString(),
                                                //     ));
                                              },
                                            ),
                                          ),
                                        )
                                      :
                                      // ADD BUTTON (always show OR you can conditionally control)
                                      Padding(
                                          padding: EdgeInsets.all(0.1.h),
                                          child: SizedBox(
                                            width: 47.w,
                                            child: ButtonWidgetPermBlue(
                                              buttonText:
                                                  "Add Feedback/Complaint",
                                              onPress: () {
                                                Get.to(() =>
                                                    AddFeedbackComplaintScreen(
                                                      selectproject: widget
                                                          .selectedProject,
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
                    ],
                  );
          })),
    );
  }

  Row rowList(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: AppTextStyle.normalBlack12,
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 1.8.h),
          child: Text(
            text2,
            style: AppTextStyle.semiBoldBlack14,
          ),
        ),
      ],
    );
  }
}
