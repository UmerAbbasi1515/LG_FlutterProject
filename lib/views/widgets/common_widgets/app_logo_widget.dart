
import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:sizer/sizer.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0.w,
      height: 10.0.h,
      child: Image.asset(
        AppImagesPath.main1x,
        fit: BoxFit.contain,
      ),
    );
  }
}
class AppLogoWithBG extends StatelessWidget {
  const AppLogoWithBG({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.chartlightBlueColorCharges,
      padding: EdgeInsets.all(1.h),
      width: 80.0.w,
      height: 10.0.h,
      child: Image.asset(
        AppImagesPath.main1x,
        fit: BoxFit.contain,
      ),
    );
  }
}