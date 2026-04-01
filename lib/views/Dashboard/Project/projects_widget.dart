import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_controller.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_detail.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_search_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/error_text_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:sizer/sizer.dart';

class ProjectsWidget extends StatefulWidget {
  final Function(int)? projects;
  const ProjectsWidget({super.key, this.projects});

  @override
  State<ProjectsWidget> createState() => _ProjectsWidgetState();
}

class _ProjectsWidgetState extends State<ProjectsWidget> {
  final ProjectController getContractsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 2.0.h,
        right: 2.0.h,
        top: 1.0.h,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Container(
              width: 94.0.w,
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.0.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1.0.h,
                    spreadRadius: 0.6.h,
                    offset: Offset(0.0.h, 0.7.h),
                  ),
                ],
              ),
              child: ProjectSearchWidget(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.0.h),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1.0.h,
                  spreadRadius: 0.6.h,
                  offset: Offset(0.0.h, 0.7.h),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
                  child: Row(
                    children: [
                      Obx(() {
                        return Text(
                          "${AppMetaLabels().totalProjects}  (${getContractsController.model.value.data!.length})",
                          style: AppTextStyle.semiBoldBlack13,
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h, left: 5.h, right: 5.h),
                  child: const AppDivider(),
                ),
                Obx(() {
                  return getContractsController.loadingProjectsData.value ==
                          true
                      ? SizedBox(
                          height: 10.h,
                          width: 6.h,
                          child: Center(child: const LoadingIndicatorBlue()),
                        )
                      : getContractsController.error.value != '' ||
                              getContractsController.model.value.data!.isEmpty
                          ? AppErrorWidget(
                              errorText: AppMetaLabels().noDatafound,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getContractsController
                                  .model.value.data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await Get.to(() => ProjectDetailScreen(
                                          selectedProject:
                                              getContractsController
                                                  .model.value.data![index],
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.5.w, vertical: 1.5.h),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              // height: 12.0.h,
                                              width: 78.0.w,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width: 50.0.w,
                                                        child: Text(
                                                          SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? getContractsController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .nameEn ??
                                                                  ""
                                                              : getContractsController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .nameUr ??
                                                                  "",
                                                          style: AppTextStyle
                                                              .semiBoldBlack12,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        getContractsController
                                                                .model
                                                                .value
                                                                .data![index]
                                                                .adpYear ??
                                                            "",
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      SizedBox(
                                                        width: 30.0.w,
                                                        child: Text(
                                                          AppMetaLabels()
                                                              .description,
                                                          style: AppTextStyle
                                                              .semiBoldBlack12,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: 40.0.w,
                                                        child: Text(
                                                          SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? getContractsController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .descriptionEn ??
                                                                  ""
                                                              : getContractsController
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .descriptionUr ??
                                                                  "",
                                                          style: AppTextStyle
                                                              .semiBoldBlack12,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.h,
                                                  ),
                                                  Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? getContractsController
                                                                .model
                                                                .value
                                                                .data![index]
                                                                .locationEn ??
                                                            ""
                                                        : getContractsController
                                                                .model
                                                                .value
                                                                .data![index]
                                                                .locationUr ??
                                                            "",
                                                    style: AppTextStyle
                                                        .normalGrey10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 0.5.h, left: 2.0.h),
                                              child: SizedBox(
                                                width: 0.15.w,
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: AppColors.grey1,
                                                  size: 20,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      getContractsController.model.value.data!
                                                      .length -
                                                  1 ==
                                              index
                                          ? SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  left: 1.0.h, right: 1.0.h),
                                              child: const AppDivider(),
                                            ),
                                    ],
                                  ),
                                );
                              },
                            );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
