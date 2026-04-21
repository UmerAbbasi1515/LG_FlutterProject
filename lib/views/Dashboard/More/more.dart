import 'package:flutter/material.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/More/profile/profile_screen.dart';
import 'package:localgovernment_project/views/Dashboard/More/notifications/read_notifications.dart';
import 'package:localgovernment_project/views/Dashboard/More/settings/settings_screen.dart';
import 'package:localgovernment_project/views/auth/auth_flow/password_screen.dart';
import 'package:localgovernment_project/views/common/about_app.dart/about_app.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class TenantMoreScreen extends StatefulWidget {
  const TenantMoreScreen({super.key});

  @override
  State<TenantMoreScreen> createState() => _TenantMoreScreenState();
}

class _TenantMoreScreenState extends State<TenantMoreScreen> {
  String name = "";

  void _getName() {
    String mystring = SessionController().getUserName() ?? "";
    var a = mystring.trim();
    if (a.isNotEmpty) {
      name = a[0];
    } else {
      name = '-';
    }
  }

  String getInitials(String fullName) {
    if (fullName.trim().isEmpty) return '';

    List<String> parts = fullName.trim().split(RegExp(r'\s+'));

    // If only one name → return first letter
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    // If multiple names → take first letter of each word
    String initials = parts.map((e) => e[0].toUpperCase()).join();

    return initials;
  }

  @override
  void initState() {
    super.initState(); // ✅ super first
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              width: 100.0.w,
              height: 38.0.h,
              child: Image.asset(
                AppImagesPath.concave,
                fit: BoxFit.fill,
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 2.w),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Colors.white,
                            size: 3.h,
                          ),
                          onPressed: () {
                            // tDGDController.getDashboardData();
                            Get.back();
                          },
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 3.h,
                        ),
                        onPressed: () {
                          SessionController().resetSession();
                          Get.offAll(() => PasswordScreen(
                              isPasswordSet:
                                  SessionController().isPasswordSet.obs));
                        },
                      ),
                      InkWell(
                        onTap: () {
                          SessionController().resetSession();
                          SessionController().resetSession();
                          Get.offAll(() => PasswordScreen(
                              isPasswordSet:
                                  SessionController().isPasswordSet.obs));
                        },
                        child: Text(
                          '${AppMetaLabels().logout}  ',
                          style: AppTextStyle.semiBoldWhite14
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      SizedBox(width: 3.w),
                    ],
                  ),
                  SizedBox(
                    height: 12.5.h,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 2.0.h, left: 5.0.h, right: 5.0.h),
                          child: Text(
                            SessionController().getUserName() ?? '',
                            style: AppTextStyle.semiBoldWhite18,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16.h,
                    padding: EdgeInsets.all(2.0.h),
                    child: InkWell(
                      onTap: () {
                        Get.off(() => const TenantProfile());
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(72, 88, 106, 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(3.0.h),
                            child: Text(
                              getInitials(
                                  SessionController().getUser().nameEn ?? ""),
                              style: AppTextStyle.semiBoldWhite16
                                  .copyWith(fontSize: 24.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0.h),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.off(() => const TenantProfile());
                                },
                                leading: Image.asset(
                                  AppImagesPath.myProfileLand,
                                  width: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().myProfile,
                                  style: AppTextStyle.normalBlack14,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => const TenantNotifications());
                                },
                                leading: Icon(
                                  Icons.notifications_outlined,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().notifications,
                                  style: AppTextStyle.normalBlack14,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.off(() => const TenantSettings());
                                },
                                leading: Icon(
                                  Icons.settings_outlined,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().settings,
                                  style: AppTextStyle.normalBlack14,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? ui.TextDirection.ltr
                                                : ui.TextDirection.rtl,
                                        child: SizedBox(
                                          height: 25.h,
                                          width: 100.0.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0.h),
                                                topRight:
                                                    Radius.circular(4.0.h),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 4.0.h),
                                                Text(
                                                  AppMetaLabels().needHelp,
                                                  style: AppTextStyle
                                                      .normalBlack14,
                                                ),
                                                SizedBox(height: 3.0.h),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: 25.h,
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(2.w, 0,
                                                                  2.w, 1.h),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            1.h)),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                          1.h,
                                                                          2.h,
                                                                          1.h,
                                                                          1.h),
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .contactCenter,
                                                                        style: AppTextStyle
                                                                            .normalBlack14,
                                                                      ),
                                                                    ),
                                                                    const AppDivider(),
                                                                  ],
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top: 1
                                                                              .h),
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              1.h)),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .all(1
                                                                            .h),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .cancel,
                                                                        style: AppTextStyle
                                                                            .normalBlack14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 3.0.h,
                                                        right: 3.0.h),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.call_outlined,
                                                          color: Colors.black,
                                                          size: 3.0.h,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 3.0.h,
                                                                  right: 3.0.h),
                                                          child: Text(
                                                            AppMetaLabels()
                                                                .callUs,
                                                            style: AppTextStyle
                                                                .semiBoldBlack12,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .blackColor,
                                                          size: 2.0.h,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 1.5.h),
                                                const AppDivider(),
                                                SizedBox(height: 3.0.h),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                leading: Icon(
                                  Icons.help_outline_outlined,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().help,
                                  style: AppTextStyle.normalBlack14,
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(() => AboutApp()); // ✅ const added
                                },
                                leading: Icon(
                                  Icons.info_outline,
                                  size: 3.0.h,
                                  color: AppColors.blackColor,
                                ),
                                title: Text(
                                  AppMetaLabels().about,
                                  style: AppTextStyle.normalBlack14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
