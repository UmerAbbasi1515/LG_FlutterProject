
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:sizer/sizer.dart';

class StatusWidget extends StatelessWidget {
  final String? text;
  final String? valueToCompare;
  const StatusWidget(
      {super.key, @required this.text, @required this.valueToCompare});

  @override
  Widget build(BuildContext context) {
    if (valueToCompare! != null) {
      valueToCompare!.trim();
    }
    return Container(
      decoration: BoxDecoration(
        color: valueToCompare!.contains('Posted') ||
                valueToCompare!.contains('Active')
            // valueToCompare!.contains('Posted') ||
            //         valueToCompare!.contains('Active') ||
            //         valueToCompare!.contains("Closed")
            ? AppColors.greenColorWithOpacity035
            : valueToCompare!.contains("Cancelled") ||
                    valueToCompare!.contains("Rejected")
                ? const Color.fromRGBO(244, 67, 54, 0.35)
                : valueToCompare!.contains('Ended') ||
                        valueToCompare!.contains('Terminated') ||
                        valueToCompare!.contains('Closed')
                    ? const Color.fromRGBO(158, 158, 158, 0.35)
                    : valueToCompare!.contains('draft') ||
                            valueToCompare!.contains('Received')
                        ? AppColors.amberWithOpacity035
                        : AppColors.amberWithOpacity035,
        borderRadius: BorderRadius.circular(0.5.h),
      ),
      child: Padding(
        // padding: EdgeInsets.fromLTRB(2.0.h, 0.8.h, 2.0.h, 0.8.h),
        padding: EdgeInsets.fromLTRB(
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
        ),
        child: Text(
          text!,
          style: AppTextStyle.statusStyle(valueToCompare!.contains('Active') ||
                      valueToCompare!.contains('Posted') ||
                      valueToCompare!.contains("Closed")
                  ? AppColors.blackColor
                  : valueToCompare!.contains("Cancelled") ||
                          valueToCompare!.contains("Rejected")
                      ? AppColors.blackColor
                      : valueToCompare!.contains('Ended') ||
                              valueToCompare!.contains('Terminated')
                          ? AppColors.blackColor
                          : valueToCompare!.contains('draft') ||
                                  valueToCompare!.contains('Received')
                              ? AppColors.blackColor
                              : AppColors.blackColor)
              .copyWith(
            fontWeight: valueToCompare!.contains('Under Approval')
                ? SessionController().getLanguage() == 1
                    ? FontWeight.bold
                    : null
                : null,
            fontSize: valueToCompare!.contains('Under Approval')
                ? SessionController().getLanguage() == 1
                    ? 14.sp
                    : null
                : null,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

class StatusWidgetVendor extends StatelessWidget {
  final String? text;
  final String? valueToCompare;
  const StatusWidgetVendor(
      {super.key, @required this.text, @required this.valueToCompare});

  @override
  Widget build(BuildContext context) {
    valueToCompare!.trim();
    return Container(
      decoration: BoxDecoration(
        color: valueToCompare!.contains('Posted') ||
                valueToCompare!.contains('Active')
            // valueToCompare!.contains('Posted') ||
            //         valueToCompare!.contains('Active') ||
            //         valueToCompare!.contains("Closed")
            ? AppColors.greenColorWithOpacity035
            : valueToCompare!.contains("Cancelled") ||
                    valueToCompare!.contains("Rejected")
                ? const Color.fromRGBO(244, 67, 54, 0.35)
                : valueToCompare!.contains('Ended') ||
                        valueToCompare!.contains('Terminated') ||
                        valueToCompare!.contains('Closed')
                    ? const Color.fromRGBO(158, 158, 158, 0.35)
                    : valueToCompare!.contains('draft') ||
                            valueToCompare!.contains('Received')
                        ? AppColors.amberWithOpacity035
                        : AppColors.amberWithOpacity035,
        borderRadius: BorderRadius.circular(0.5.h),
      ),
      child: Padding(
        // padding: EdgeInsets.fromLTRB(2.0.h, 0.8.h, 2.0.h, 0.8.h),
        padding: EdgeInsets.fromLTRB(
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
          valueToCompare!.contains('Under Approval') ? 1.h : 2.0.h,
          valueToCompare!.contains('Under Approval') ? 1.4.h : 0.8.h,
        ),
        child: Text(
          text!,
          style: AppTextStyle.statusStyle(valueToCompare!.contains('Active') ||
                      valueToCompare!.contains('Posted') ||
                      valueToCompare!.contains("Closed")
                  ? AppColors.blackColor
                  : valueToCompare!.contains("Cancelled") ||
                          valueToCompare!.contains("Rejected")
                      ? AppColors.blackColor
                      : valueToCompare!.contains('Ended') ||
                              valueToCompare!.contains('Terminated')
                          ? AppColors.blackColor
                          : valueToCompare!.contains('draft') ||
                                  valueToCompare!.contains('Received')
                              ? AppColors.blackColor
                              : AppColors.blackColor)
              .copyWith(
            fontWeight: valueToCompare!.contains('Under Approval')
                ? FontWeight.bold
                : null,
            fontSize: valueToCompare!.contains('Under Approval') ? 10.sp : null,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
