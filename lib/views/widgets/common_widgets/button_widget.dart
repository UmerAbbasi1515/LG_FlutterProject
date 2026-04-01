// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String? buttonText;

  const ButtonWidget({super.key, this.buttonText, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.3.h),
          ),
          backgroundColor: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 1.5.h),
          // textStyle: AppTextStyle.buttonTextStyle,
        ),
        onPressed: onPress,
        child: Text(
          buttonText ?? "",
          style: AppTextStyle.buttonTextStyle,
        ),
      ),
    );
  }
}

class ButtonWidgetBlue extends StatelessWidget {
  final VoidCallback? onPress;
  final String? buttonText;

  const ButtonWidgetBlue({super.key, this.buttonText, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.3.h),
          ),
          backgroundColor: AppColors.blueColor,
          padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 1.5.h),
          // textStyle: AppTextStyle.buttonTextStyle,
        ),
        onPressed: onPress,
        child: Text(
          buttonText ?? "",
          style: AppTextStyle.buttonTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class ButtonWidgetPermBlue extends StatelessWidget {
  final VoidCallback? onPress;
  final String? buttonText;

  const ButtonWidgetPermBlue({super.key, this.buttonText, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.3.h),
          ),
          backgroundColor: AppColors.blueColor,
          disabledBackgroundColor: AppColors.blueColor.withOpacity(0.5),
          padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 1.5.h),
        ),
        onPressed: onPress,
        child: Text(
          buttonText ?? "",
          style: AppTextStyle.buttonTextStyle.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
