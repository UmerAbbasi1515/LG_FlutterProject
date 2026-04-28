import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
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
  final ProjectController controller = Get.find();

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
          // ================= SEARCH BOX =================
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

          // ================= MAIN BOX =================
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
                // ================= HEADER =================
                Obx(() {
                  final count = controller.model.value.data?.length ?? 0;

                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
                    child: Row(
                      children: [
                        Text(
                          "${AppMetaLabels().totalProjects} ($count)",
                          style: AppTextStyle.semiBoldBlack14,
                        ),
                      ],
                    ),
                  );
                }),

                Padding(
                  padding: EdgeInsets.only(bottom: 2.h, left: 5.h, right: 5.h),
                  child: const AppDivider(),
                ),

                // ================= LOADING =================
                Obx(() {
                  if (controller.loadingProjectsData.value) {
                    return SizedBox(
                      height: 10.h,
                      child: const Center(
                        child: LoadingIndicatorBlue(),
                      ),
                    );
                  }
                  return const SizedBox();
                }),

                // ================= LIST / ERROR =================
                Obx(() {
                  final data = controller.model.value.data ?? [];

                  if (controller.error.value.isNotEmpty || data.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(6.h),
                      child: AppErrorWidget(
                        errorText: AppMetaLabels().noDatafound,
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];

                      return InkWell(
                        onTap: () async {
                          await Get.to(() => ProjectDetailScreen(
                                selectedProject: item,
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
                                    width: 78.0.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // NAME + YEAR
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 50.0.w,
                                              child: Text(
                                                SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? item.nameEn ?? ""
                                                    : item.nameUr ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle
                                                    .semiBoldBlack13,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              item.adpYear ?? "",
                                              style:
                                                  AppTextStyle.semiBoldBlack13,
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 1.0.h),

                                        // DESCRIPTION
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 30.0.w,
                                              child: Text(
                                                AppMetaLabels().description,
                                                style: AppTextStyle
                                                    .semiBoldBlack12,
                                              ),
                                            ),
                                            const Spacer(),
                                            SizedBox(
                                              width: 40.0.w,
                                              child: Text(
                                                SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? item.descriptionEn ?? ""
                                                    : item.descriptionUr ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                style: AppTextStyle
                                                    .semiBoldBlack13,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 1.0.h),

                                        // LOCATION
                                        Text(
                                          SessionController().getLanguage() == 1
                                              ? item.locationEn ?? ""
                                              : item.locationUr ?? "",
                                          style: AppTextStyle.normalGrey12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != data.length - 1)
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
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
