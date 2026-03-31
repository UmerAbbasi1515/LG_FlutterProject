
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/tenant_dashboard/tenant_dashboard_get_data_controller.dart';
import 'package:localgovernment_project/views/Dashboard/tenant_dashboard/your_contracts_widget.dart';
import 'package:localgovernment_project/views/More/profile.dart';
import 'package:localgovernment_project/views/More/tenant_notifications/tenant_notifications.dart';
import 'package:localgovernment_project/views/More/tenant_notifications/tenant_notifications_controller.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/error_text_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'package:badges/badges.dart' as badge;

class TenantDashboard extends StatefulWidget {
  final BuildContext? parentContext;
  final Function(int)? managePayments;
  final Function(int)? manageContracts;
  const TenantDashboard(
      {super.key, this.managePayments, this.manageContracts, this.parentContext});

  @override
  State<TenantDashboard> createState() => _TenantDashboardState();
}

class _TenantDashboardState extends State<TenantDashboard>
    with TickerProviderStateMixin {
  final TenantDashboardGetDataController tDGDController = Get.put(TenantDashboardGetDataController());
  final GetTenantNotificationsController getTNController = Get.put(GetTenantNotificationsController());
  AnimationController? animateController;
  Animation<double>? animate;
  String status = "Unread";


  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    // int userID = SessionController().getUserID();
    // print('User ID ::::: $userID');
    animateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animate = Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
      parent: animateController!,
      curve: Curves.easeIn,
    ));
    animateController!.repeat(reverse: true);
    getDBData();
  }

  getDBData() async {
    // await tDGDController.getDashboardData();
  }

  @override
  void dispose() {
    animateController!.dispose();
    super.dispose();
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
                              // tDGDController.getDashboardData();
                              // showNotificationPopup();
                            },
                            child: Text(
                              "Test User",
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
                              // tDGDController.getDashboardData();
                            },
                            child: badge.Badge(
                              showBadge: 0 ==
                                          null ||
                                      1 ==
                                          0
                                  ? false
                                  : true,
                              badgeStyle: badge.BadgeStyle(
                                padding: EdgeInsets.all(0.8.h),
                              ),
                              position: badge.BadgePosition.topEnd(
                                  top: -1.0.h, end: 0.0.h),
                              badgeAnimation: const badge.BadgeAnimation.rotation(
                                animationDuration: Duration(seconds: 300),
                                colorChangeAnimationDuration:
                                    Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                              badgeContent: Text(
                                '12',
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
                  tDGDController.loadingData.value == true
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
                            child: const LoadingIndicatorBlue(),
                          ),
                        )
                      : tDGDController.error.value != ''
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
                                  horizontal: 0.0.w, vertical: 1.0.h),
                              child: Container(
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
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          4.w, 2.h, 4.w, 1.2.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Outstanding incl. Charges  NEXT 30 DAYS
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 50.w,
                                                child: Text(
                                                  AppMetaLabels()
                                                      .paymentBalance
                                                      .toUpperCase(),
                                                  style:
                                                      AppTextStyle.normalBlack8,
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 0.0.w, left: 0.w),
                                                child: Text(
                                                  AppMetaLabels().next30days,
                                                  style:
                                                      AppTextStyle.normalBlack8,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Amount
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: 0.6.h),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "${AppMetaLabels().aed} 123445",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle
                                                        .semiBoldBlack14),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const AppDivider(),
                                  ],
                                ),
                              ),
                            ),
               
                  Expanded(
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          // change column into stack
                          child: Column(
                            children: [
                              YourContracts(
                                manageContracts: widget.manageContracts,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
