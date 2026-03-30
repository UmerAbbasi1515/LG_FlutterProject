
import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:sizer/sizer.dart';

class LoadingIndicatorWhite extends StatelessWidget {
  const LoadingIndicatorWhite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.whiteColor,
        strokeWidth: 0.5.h,
      ),
    );
  }
}
