import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/auth/auth_flow/password_controller.dart';
import 'package:sizer/sizer.dart';

class PasswordRulesCard extends StatelessWidget {
  PasswordRulesCard({super.key});

  final pController = Get.find<PasswordController>();

  Widget buildRule(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? AppColors.greenColor : AppColors.redColor,
          size: 16,
        ),
        SizedBox(width: 6),
        SizedBox(
          width: 80.w,
          child: Text(
            text,
            style: TextStyle(
              color: isValid ? AppColors.greenColor : AppColors.redColor,
              fontSize: 12,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String pass = pController.password.value;

      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRule(AppMetaLabels().passwordMustbe8Char,
                pController.hasMinLength(pass)),
            buildRule(AppMetaLabels().passwordMContainOneAlphaNumericVal,
                pController.hasUpperCase(pass)),
            buildRule(AppMetaLabels().passwordMContainOneCapSmaAlpha,
                pController.hasLowerCase(pass)),
            buildRule(AppMetaLabels().passwordMContainOneNumericVal,
                pController.hasDigit(pass)),
          ],
        ),
      );
    });
  }
}

class PasswordFieldWidget extends StatelessWidget {
  PasswordFieldWidget({super.key});

  final pController = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() => Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.ltr,
            child: TextField(
              controller: pController.passwordController,
              onChanged: (val) {
                pController.passwordController.text = val;
                pController.password.value = val;
              },
              style: AppTextStyle.semiBoldBlack14,
              obscureText: pController.obscurePassword.value,
              onEditingComplete: () {
                if (pController.passwordController.text !=
                    pController.confirmPasswordController.text) {
                  pController.error.value = "Passwords do not match";
                } else {
                  pController.error.value = "";
                }
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    pController.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.chartBlueColor,
                  ),
                  onPressed: () {
                    pController.obscurePassword.value =
                        !pController.obscurePassword.value;
                  },
                ),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.2.h),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.w),
                  borderSide: BorderSide(
                    color: AppColors.chartBlueColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.w),
                  borderSide:
                      BorderSide(color: AppColors.chartBlueColor, width: 2.0),
                ),
              ),
            ),
          )),
    );
  }
}

class ConfirmPasswordFieldWidget extends StatelessWidget {
  ConfirmPasswordFieldWidget({super.key});

  final pController = Get.find<PasswordController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() => TextField(
            controller: pController.confirmPasswordController,
            obscureText: pController.obscureConfirm.value,
            style: AppTextStyle.semiBoldBlack14,
            onChanged: (val) {
              pController.confirmPassword.value = val;
              pController.confirmPassword.value = val;
              if (pController.confirmPasswordController.text == "") {
                pController.error.value = "";
                return;
              }
              pController.validateConfirmPassword();
            },
            onEditingComplete: () {
              if (pController.passwordController.text ==
                  pController.confirmPasswordController.text) {
                pController.error.value = "";
              }
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  pController.obscureConfirm.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.chartBlueColor,
                ),
                onPressed: () {
                  pController.obscureConfirm.value =
                      !pController.obscureConfirm.value;
                },
              ),

              // 🔥 THIS IS EXTRA (error text)
              errorText: pController.error.value.isEmpty
                  ? null
                  : pController.error.value,

              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.2.h),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.w),
                borderSide: BorderSide(
                  color: AppColors.chartBlueColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.w),
                borderSide:
                    BorderSide(color: AppColors.chartBlueColor, width: 2.0),
              ),
            ),
          )),
    );
  }
}
