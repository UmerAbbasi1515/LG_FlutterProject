import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/auth/auth_flow/password_controller.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user_controller.dart';
import 'package:localgovernment_project/views/widgets/New/password_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:localgovernment_project/views/widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';

class PasswordScreen extends StatefulWidget {
  final RxString? isPasswordSet;
  const PasswordScreen({super.key, required this.isPasswordSet});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final PasswordController controller = Get.put(PasswordController());
  final ValidateFirebaseUserController authController =
      Get.put(ValidateFirebaseUserController());

  @override
  void initState() {
    controller.error.value = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Column(
          children: [
            CustomAppBar2(
              title: AppMetaLabels().password,
              onBackPressed: () {
                authController.verifying.value = false;
                authController.isUpdating.value = false;
                Get.offAll(() => ValidateUserScreen());
              },
            ),

            /// ✅ Scrollable content ONLY here
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Obx(() {
                    final isSet =
                        widget.isPasswordSet?.value.toLowerCase() == "true";

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),

                        /// Title
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppMetaLabels().login,
                            style: AppTextStyle.semiBoldBlack18,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        /// Logo
                        const Center(child: AppLogoWithBG()),

                        SizedBox(height: 3.h),

                        /// Instruction text
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${AppMetaLabels().pleaseenterPasswordwithMobile} "
                            "${controller.maskPhoneNumber(SessionController().getPhone() ?? "")}",
                            style: AppTextStyle.normalBlack15,
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        /// 🔁 CONDITION UI
                        if (isSet) ...[
                          /// LOGIN FLOW
                          Text(
                            AppMetaLabels().pleaseenterPassword,
                            style: AppTextStyle.semiBoldBlack14,
                          ),
                          SizedBox(height: 1.h),

                          PasswordFieldWidget(),

                          SizedBox(height: 5.h),

                          controller.isLoading.value == true
                              ? Column(
                                  children: [
                                    const LoadingIndicatorBlue(),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      AppMetaLabels().loading,
                                      style: AppTextStyle.semiBoldBlue13,
                                    ),
                                  ],
                                )
                              : ButtonWidgetBlue(
                                  buttonText: AppMetaLabels().login,
                                  onPress: controller.password.value.isEmpty
                                      ? null
                                      : () => controller.loginWithPassword(),
                                ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 2.0.h),
                              child: TextButton(
                                onPressed: () {
                                  GlobalPreferences.setbool(
                                      GlobalPreferencesLabels.isLoginBool,
                                      false);
                                  Get.offAll(() => ValidateUserScreen());
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      AppMetaLabels().reset,
                                      style: AppTextStyle.semiBoldBlue15,
                                    ),
                                    Container(
                                      color: AppColors.blueColor,
                                      height: 0.1.h,
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          /// SET PASSWORD FLOW

                          PasswordRulesCard(),
                          SizedBox(height: 3.h),

                          Text(
                            AppMetaLabels().password,
                            style: AppTextStyle.semiBoldBlack14,
                          ),
                          SizedBox(height: 1.h),

                          PasswordFieldWidget(),

                          SizedBox(height: 3.h),

                          Text(
                            AppMetaLabels().confirm,
                            style: AppTextStyle.semiBoldBlack14,
                          ),
                          SizedBox(height: 1.h),

                          ConfirmPasswordFieldWidget(),

                          SizedBox(height: 5.h),

                          controller.isLoading.value == true
                              ? Column(
                                  children: [
                                    const LoadingIndicatorBlue(),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      AppMetaLabels().loading,
                                      style: AppTextStyle.semiBoldBlue13,
                                    ),
                                  ],
                                )
                              : ButtonWidgetBlue(
                                  buttonText: AppMetaLabels().savePassword,
                                  onPress: (controller.password.value.isEmpty ||
                                          controller
                                              .confirmPassword.value.isEmpty)
                                      ? null
                                      : () => controller.setPassword(),
                                ),
                        ],
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
