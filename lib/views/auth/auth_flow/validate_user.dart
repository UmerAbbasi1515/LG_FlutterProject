import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/global_preferences.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/auth/country_picker/country_picker_controller.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user_controller.dart';
import 'package:localgovernment_project/views/auth/choose_language/language_screen.dart';
import 'package:localgovernment_project/views/widgets/New/phone_no_field.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/app_logo_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/background_image_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:localgovernment_project/views/widgets/snackbar_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../country_picker/country_picker.dart';

class ValidateUserScreen extends StatefulWidget {
  const ValidateUserScreen({super.key});

  @override
  State<ValidateUserScreen> createState() => _ValidateUserScreenState();
}

class _ValidateUserScreenState extends State<ValidateUserScreen> {
  final CountryPickerController countryController =
      Get.put(CountryPickerController());
  ValidateFirebaseUserController authController =
      Get.put(ValidateFirebaseUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            authController.textFieldTap.value = false;
          },
          child: Scaffold(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 32,
                                ),
                                Text(
                                  AppMetaLabels().login,
                                  style: AppTextStyle.semiBoldWhite15,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.to(() => const LanguageScreen(
                                            cont: false,
                                            loggedIn: false,
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.language,
                                      color: Colors.white,
                                      size: 3.h,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: authController.textFieldTap.value == true
                                ? 2.0.h
                                : 7.0.h,
                          ),
                          const AppLogo(),
                          SizedBox(
                            height: authController.textFieldTap.value == true
                                ? 2.0.h
                                : 10.0.h,
                          ),
                          Text(
                            AppMetaLabels().oneTimePassword,
                            textAlign: TextAlign.center,
                            // style: AppTextStyle.semiBoldWhite10,
                            style: AppTextStyle.normalWhite12,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0.h, left: 5.0.w, right: 5.0.w),
                            child: Align(
                              alignment: SessionController().getLanguage() == 1
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Text(
                                AppMetaLabels().mobileNumber,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.normalWhite12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.0.h),
                            child: Container(
                              width: 90.0.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(70, 82, 95, 0.2),
                                border: Border.all(
                                  color: Colors.white30,
                                ),
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        Get.to(() => const CountryPicker());
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 2.0.h),
                                            child: Obx(() {
                                              return Text(
                                                countryController
                                                    .selectedDialingCode.value,
                                                style:
                                                    AppTextStyle.normalWhite13,
                                              );
                                            }),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 1.0.h),
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                              size: 3.0.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: PhoneNoFieldWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          authController.error.value != '' ||
                                  authController.errorValidateUser.value != ''
                              ? Padding(
                                  padding: EdgeInsets.only(top: 1.0.h),
                                  child: Container(
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
                                            size: 3.5.h,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 1.0.h),
                                              child: Text(
                                                authController.errorValidateUser
                                                            .value ==
                                                        ''
                                                    ? authController.error.value
                                                    : authController
                                                        .errorValidateUser
                                                        .value,
                                                style: AppTextStyle
                                                    .semiBoldWhite11,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: authController.textFieldTap.value == true
                                ? 2.0.h
                                : 15.0.h,
                          ),
                          authController.isUpdating.value == true ||
                                  authController.verifying.value == true
                              ? Column(
                                  children: [
                                    const LoadingIndicatorWhite(),
                                    SizedBox(
                                      height: 2.0.h,
                                    ),
                                    Text(
                                      AppMetaLabels().validatingUser,
                                      style: AppTextStyle.semiBoldWhite10,
                                    ),
                                  ],
                                )
                              : ButtonWidget(
                                  buttonText: AppMetaLabels().getOTP,
                                  onPress: () async {
                                    FocusScope.of(context).unfocus();
                                    authController.textFieldTap.value = false;
                                    // checking weather user entered mobile no or not
                                    if (PhoneNoFieldWidget
                                                .phoneController.text ==
                                            '' ||
                                        PhoneNoFieldWidget
                                            .phoneController.text.isEmpty ||
                                        PhoneNoFieldWidget.phoneController.text
                                            .contains(' ')) {
                                      SnakBarWidget.getSnackBarErrorBlue(
                                        AppMetaLabels().error,
                                        AppMetaLabels().pleaseEnterMobileNo,
                                      );
                                      return;
                                    }
                                    // checking weather user started enter mobile no with 0 or not
                                    if (PhoneNoFieldWidget.phoneController.text
                                            .toString()[0] ==
                                        '0') {
                                      Get.snackbar(
                                          AppMetaLabels().error,
                                          AppMetaLabels()
                                              .pleaseEnterMobileNoWithoutZero,
                                          backgroundColor: AppColors.redColor,
                                          colorText: AppColors.whiteColor);
                                    } else {
                                      var dailingCode =
                                          SessionController().getDialingCode();
                                      var number = PhoneNoFieldWidget
                                          .phoneController.text;
                                      final String phone =
                                          '$dailingCode$number';
                                      SessionController().setPhone(phone);
                                      var phoneNbrValidation =
                                          authController.validateMobile(phone);
                                      if (kDebugMode) {
                                        print('Phone  ::: $phone');
                                        print(
                                            'Phone Validation ::: $phoneNbrValidation');
                                      }
                                      if (phoneNbrValidation ==
                                          "Invalid Mobile Number") {
                                        SnakBarWidget.getSnackBarError(
                                            AppMetaLabels().error,
                                            AppMetaLabels().invalidPhoneNumber);
                                      } else {
                                        await authController
                                            .validateMobileUser();
                                        setState(() {
                                          authController.isUpdating.value ==
                                              false;
                                          authController.verifying.value ==
                                              false;
                                        });
                                      }
                                    }
                                  },
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.0.h),
                            child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 11.5.h,
                                      width: 100.0.w,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          Text(
                                            AppMetaLabels().sureToExit,
                                            style: AppTextStyle.semiBoldBlack12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppMetaLabels().no,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0.h),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    GlobalPreferences.setbool(
                                                        GlobalPreferencesLabels
                                                            .isLoginBool,
                                                        false);
                                                    exit(0);
                                                  },
                                                  child: Text(
                                                    AppMetaLabels().yes,
                                                    style: AppTextStyle
                                                        .semiBoldWhite12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
