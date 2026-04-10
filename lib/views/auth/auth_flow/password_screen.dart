import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/auth/auth_flow/password_controller.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user_controller.dart';
import 'package:localgovernment_project/views/widgets/New/password_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/background_image_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';

class PasswordScreen extends StatefulWidget {
  final RxBool? isFirstTime;
  const PasswordScreen({super.key, required this.isFirstTime});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  PasswordController controller = Get.put(PasswordController());
  ValidateFirebaseUserController authController = Get.find();
  RxBool isPassword = false.obs;
  @override
  void initState() {
    controller.error.value = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Column(
            children: [
              CustomAppBar2(
                title: AppMetaLabels().password,
                onBackPressed: () {
                  // tDGDController.getDashboardData();
                  setState(() {
                    authController.verifying.value = false;
                    authController.isUpdating.value = false;
                  });
                  Get.back();
                },
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      controller.tempVariable.value != ''
                          ? SizedBox()
                          : widget.isFirstTime?.value == true
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(AppMetaLabels().login,
                                            style:
                                                AppTextStyle.semiBoldBlack16),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 4.0.h, bottom: 6.0.h),
                                        child: const AppLogo(),
                                      ),
                                      Text(AppMetaLabels().pleaseenterPassword,
                                          style: AppTextStyle.semiBoldBlack14),
                                      SizedBox(height: 1.h),
                                      PasswordFieldWidget(),
                                      SizedBox(height: 5.h),
                                      ButtonWidgetBlue(
                                        buttonText: AppMetaLabels().login,
                                        onPress: controller.password.value == ""
                                            ? null
                                            : () {
                                                controller.loginWithPassword();
                                              },
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.only(left: 3.w, right: 3.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(AppMetaLabels().pleaseenterPassword,
                                          style: AppTextStyle.semiBoldBlack14),
                                      SizedBox(height: 1.h),
                                      PasswordRulesCard(),

                                      SizedBox(height: 3.h),
                                      Text(AppMetaLabels().password,
                                          style: AppTextStyle.semiBoldBlack14),
                                      SizedBox(height: 1.h),
                                      PasswordFieldWidget(), // 👈 THIS IS YOUR CARD

                                      SizedBox(height: 3.h),
                                      Text(AppMetaLabels().confirm,
                                          style: AppTextStyle.semiBoldBlack14),
                                      SizedBox(height: 1.h),
                                      ConfirmPasswordFieldWidget(),
                                      SizedBox(height: 5.h),
                                      ButtonWidgetBlue(
                                        buttonText:
                                            AppMetaLabels().savePassword,
                                        onPress:
                                            controller.password.value == "" &&
                                                    controller.confirmPassword
                                                            .value ==
                                                        ""
                                                ? null
                                                : () {
                                                    controller.setPassword();
                                                  },
                                      )
                                    ],
                                  ),
                                )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
