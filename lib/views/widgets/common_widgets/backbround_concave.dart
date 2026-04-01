
import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:sizer/sizer.dart';

class AppBackgroundConcave extends StatelessWidget {
  const AppBackgroundConcave({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0.w,
      height: 40.0.h,
      child: Image.asset(
        AppImagesPath.concave,
        fit: BoxFit.fill,
      ),
    );
  }
}

class AppBackgroundConcaveProfile extends StatelessWidget {
  const AppBackgroundConcaveProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0.w,
      height: 30.0.h,
      child: Image.asset(
        AppImagesPath.concave,
        fit: BoxFit.fill,
      ),
    );
  }
}
