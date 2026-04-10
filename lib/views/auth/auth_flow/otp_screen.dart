// ignore_for_file: deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/app_const.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user_controller.dart';
import 'package:localgovernment_project/views/auth/auth_flow/otp_controller.dart';
import 'package:localgovernment_project/views/widgets/New/pin_field_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/background_image_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class OTPScreen extends StatefulWidget {
  final String? otpCodeForVerifyOTP;
  const OTPScreen({super.key, this.otpCodeForVerifyOTP});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  ValidateFirebaseUserController authController = Get.find();
  OTPController controller = Get.put(OTPController());

  String getPhone() {
    var p = SessionController().getPhone();
    var l = p!.length;
    var first = p.substring(0, 5);
    var last = p.substring(l - 3, l);
    return "$first****$last";
  }

  @override
  void initState() {
    // Adding New Functionality
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // Navigate the user away from the login screens
        // autoVerifyOtpBtn();
      } else {}
    });
    setState(() {
      authController.isCodeSent.value = false;
    });
    super.initState();
  }

  autoVerifyOtpBtn() async {
    var otpCodeFrombackend = SessionController().otpCodeFrombackend;
    if (kDebugMode) {
      print(otpCodeFrombackend);
    }
    await controller.verifyOtpBtn('159159', otpCodeFrombackend ?? "", "1");
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      authController.isCodeSent.value = false;
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Stack(
              children: [
                const AppBackgroundImage(),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child:
                          ////////////////////////////
                          /// Loading
                          ////////////////////////////

                          Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: Text(
                              AppMetaLabels().otpVerification,
                              style: AppTextStyle.semiBoldWhite13,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 10.0.h),
                            child: authController.loadingData.value
                                ? Container(
                                    height: 1.5.h,
                                  )
                                : Text(
                                    AppMetaLabels().enterTheCode,
                                    style: AppTextStyle.normalWhite12,
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0.5.h),
                            child: authController.loadingData.value
                                ? Container(
                                    height: 1.5.h,
                                  )
                                : Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      getPhone(),
                                      style: AppTextStyle.semiBoldWhite11,
                                    ),
                                  ),
                          ),

                          ////////////////////////////
                          /// PinCodeField
                          ////////////////////////////

                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Center(
                              child: authController.loadingData.value
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 24.0.h),
                                      child: Column(
                                        children: [
                                          const LoadingIndicatorWhite(),
                                          SizedBox(
                                            height: 2.0.h,
                                          ),
                                          Text(
                                            AppMetaLabels().verifyingOtp,
                                            style: AppTextStyle.semiBoldWhite10,
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      width: 85.0.w,
                                      child: PinCodeField(
                                        controller: authController,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 7.0.h),
                            child: authController.loadingData.value ||
                                    authController.resending.value ||
                                    authController.resendProgressBar.value
                                ? Container(
                                    height: 2.0.h,
                                  )
                                : Text(
                                    AppMetaLabels().didnotrecieve,
                                    style: AppTextStyle.normalWhite10,
                                  ),
                          ),
                          ////////////////////////////
                          /// ResendOtp Button ///
                          ////////////////////////////

                          if (!authController.loadingData.value)
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0.h, left: 5.0.h, right: 5.0.h),
                              child: authController
                                      .resendProgressBarLoading.value
                                  ? const LoadingIndicatorWhite()
                                  : authController.resendProgressBar.value
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(1.0.h),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: TweenAnimationBuilder<double>(
                                              tween: Tween<double>(
                                                  begin: 1.0, end: 0.0),
                                              // setting the time for Progress
                                              duration: const Duration(
                                                  seconds:
                                                      AppConst.resendOtpTime),
                                              onEnd: () {
                                                authController.resendProgressBar
                                                    .value = false;
                                              },
                                              builder: (context, value, _) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (timeStamp) {});
                                                return LinearProgressIndicator(
                                                  backgroundColor:
                                                      AppColors.grey1,
                                                  color: AppColors.whiteColor,
                                                  minHeight: 0.6.h,
                                                  value: value,
                                                );
                                              }))
                                      : authController
                                              .resendProgressBarLoading.value
                                          ? Container(
                                              height: 6.0.h,
                                            )
                                          : const ResendOtpFB(),
                            ),

                          //////////////////////////////////////
                          /// Error Message
                          //////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(
                              top: 2.0.h,
                            ),
                            child: authController.error.value == ''
                                ? Container()
                                : Container(
                                    width: 85.0.w,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 59, 48, 0.6),
                                      borderRadius:
                                          BorderRadius.circular(1.0.h),
                                      border: Border.all(
                                        color: const Color.fromRGBO(
                                            255, 59, 48, 1),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(0.7.h),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            color: Colors.white,
                                            size: 3.0.h,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 1.0.h),
                                            child: SizedBox(
                                              width: 72.0.w,
                                              child: Text(
                                                authController.error.value,
                                                style: AppTextStyle
                                                    .semiBoldWhite11,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),

                          //////////////////////////////////////
                          /// verifyOtp Button
                          //////////////////////////////////////
                          Padding(
                            padding: EdgeInsets.only(top: 18.0.h),
                            child: authController.loadingData.value ||
                                    authController.resending.value
                                ? Container()
                                : ButtonWidget(
                                    buttonText: AppMetaLabels().verify,
                                    onPress: () {
                                      // controller.verifyOtpBtn();
                                    },
                                  ),
                          ),
                          if (!authController.loadingData.value)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  authController.error.value = '';

                                  authController
                                      .resendProgressBarLoading.value = false;
                                  authController.errorValidateUser.value = '';
                                  authController.resendProgressBar.value = true;
                                  authController.verifying.value = false;
                                  authController.isUpdating.value = false;
                                });
                                // final CountryPickerController
                                //     countryController =
                                //     Get.put(CountryPickerController());
                                // // countryController.selectedDialingCode.value =
                                // //     '+92';
                                Get.back();
                              },
                              child: Column(
                                children: [
                                  Text(
                                    AppMetaLabels().cancel,
                                    style: AppTextStyle.normalWhite13,
                                  ),
                                  Container(
                                    color: AppColors.whiteColor,
                                    height: 0.1.h,
                                    width: 8.0.w,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
