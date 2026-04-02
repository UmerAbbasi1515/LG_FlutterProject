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

class ButtonWidgetPermBlueIcon extends StatelessWidget {
  final VoidCallback? onPress;
  final String? buttonText;
  final IconData? icon; // ✅ optional icon

  const ButtonWidgetPermBlueIcon(
      {super.key, this.buttonText, this.onPress, this.icon});

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
          disabledForegroundColor: Colors.white.withOpacity(0.6),
          padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 1.5.h),
        ),
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.whiteColor, size: 2.2.h),
              SizedBox(width: 1.w),
            ],
            Text(
              buttonText ?? "",
              style: AppTextStyle.buttonTextStyle.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
