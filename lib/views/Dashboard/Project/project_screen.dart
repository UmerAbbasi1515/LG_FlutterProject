import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_controller.dart';
import 'package:localgovernment_project/views/Dashboard/Project/projects_widget.dart';
import 'package:localgovernment_project/views/Dashboard/More/profile/profile_screen.dart';
import 'package:localgovernment_project/views/Dashboard/More/notifications/read_notifications.dart';
import 'package:localgovernment_project/views/Dashboard/More/notifications/notifications_controller.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/error_text_widget.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'package:badges/badges.dart' as badge;

class ProjectScreen extends StatefulWidget {
  final Function(int)? projects;

  const ProjectScreen({
    super.key,
    this.projects,
  });

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  // ✅ Removed TickerProviderStateMixin
  final ProjectController tDGDController = Get.put(ProjectController());
  final GetTenantNotificationsController getTNController =
      Get.put(GetTenantNotificationsController());

  @override
  void initState() {
    super.initState();
    int userID = SessionController().getUserID() ?? 0;
    if (kDebugMode) {
      print('User ID ::::: $userID');
    }
    getDBData();
  }

  Future<void> getDBData() async {
    await tDGDController.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.0.h),
            child: Obx(() {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.h),
                    child: Row(
                      children: [
                        SizedBox(width: 45.0.w, child: const AppLogo()),
                        const Spacer(),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(72, 88, 106, 1),
                            shape: BoxShape.circle,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await Get.to(() => const TenantProfile());
                            },
                            child: Text(
                              tDGDController.getInitials(
                                  SessionController().getLanguage() == 1
                                      ? SessionController().nameEn ?? ""
                                      : SessionController().nameUr ?? ""
                                      ),
                              style: AppTextStyle.semiBoldWhite14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.0.w, vertical: 0.0.h),
                          child: InkWell(
                            onTap: () async {
                              await Get.to(() => const TenantNotifications());
                            },
                            child: badge.Badge(
                              showBadge: true,
                              badgeStyle: badge.BadgeStyle(
                                padding: EdgeInsets.all(0.8.h),
                              ),
                              position: badge.BadgePosition.topEnd(
                                  top: -1.0.h, end: 0.0.h),
                              badgeAnimation:
                                  const badge.BadgeAnimation.rotation(
                                animationDuration: Duration(seconds: 300),
                                colorChangeAnimationDuration:
                                    Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                              badgeContent: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                                size: 5.0.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  tDGDController.error.value != ''
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0.w, vertical: 1.0.h),
                          child: Container(
                            height: 33.0.h,
                            width: 94.0.w,
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
                            child: AppErrorWidget(
                              errorText: tDGDController.error.value,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0.w, vertical: 0.0.h),
                          child: Container(
                            width: 94.0.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0.5.h),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1.0.h,
                                  spreadRadius: 0.6.h,
                                  offset: Offset(0.0.h, 0.7.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProjectsWidget(
                            projects: widget.projects,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
