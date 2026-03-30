// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:localgovernment_project/views/auth/otp_firebase/otp_firebase_controller.dart';
import 'package:sizer/sizer.dart';

class PinCodeField extends StatefulWidget {
  final String? otpCodeForVerifyOTP;
  FirebaseAuthController? controller;
  PinCodeField({super.key, this.otpCodeForVerifyOTP, this.controller});

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  final TextEditingController smsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Form(
      key: formKey,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.0.w),
          child: Directionality(
              textDirection: TextDirection.ltr,
              child: PinInput(
                length: 4,
                builder: (context, cells) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cells.map((cell) {
                      return Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              cell.isFocused ? Colors.blue : Colors.grey[200],
                        ),
                        child: Center(
                          child: Text(
                            cell.character ?? '',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                onCompleted: (pin) {
                  if (kDebugMode) {
                    print('PIN: $pin');
                  }
                },
              ))),
    );
  }
}

class ResendOtpFB extends StatefulWidget {
  const ResendOtpFB({super.key});

  @override
  State<ResendOtpFB> createState() => _ResendOtpFBState();
}

class _ResendOtpFBState extends State<ResendOtpFB> {
  final FirebaseAuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: 90.0.w,
        child: authController.resending.value
            ? const LoadingIndicatorWhite()
            : OutlinedButton(
                onPressed: () async {
                  setState(() {
                    authController.resendProgressBar.value = false;
                    authController.resendProgressBarLoading.value = true;
                  });
                  await authController
                      .resendingOtp(SessionController().getPhone() ?? "");
                  if (kDebugMode) {
                    print('After ::::: func call ::::');
                  }
                  setState(() {
                    authController.resendCounter++;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 0.1.w,
                    color: AppColors.whiteColor,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.3.h),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    AppMetaLabels().resentOtp,
                    style: AppTextStyle.semiBoldWhite13,
                  ),
                ),
              ),
      );
    });
  }
}
