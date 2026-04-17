import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar2 extends StatelessWidget {
  final String? title;
  final Function? onBackPressed;
  const CustomAppBar2({
    super.key,
    @required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.8.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            height: 12.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 3.h,
                  ),
                  onPressed: () {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Get.back();
                    }
                  },
                ),
                Expanded(
                  child: Text(
                    title!,
                    style: AppTextStyle.semiBoldWhite15,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 5.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBarDoubleBack extends StatelessWidget {
  final String? title;
  final Function? onBackPressed;
  const CustomAppBarDoubleBack({
    super.key,
    @required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.8.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            height: 12.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 3.h,
                  ),
                  onPressed: () {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Get.back();
                      Get.back();
                    }
                  },
                ),
                Expanded(
                  child: Text(
                    title!,
                    style: AppTextStyle.semiBoldWhite15,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 5.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar2ForVendorTechniance extends StatelessWidget {
  final String? title;
  final Function? onBackPressed;
  const CustomAppBar2ForVendorTechniance({
    super.key,
    @required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.8.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            height: 8.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 3.h,
                  ),
                  onPressed: () {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Get.back();
                    }
                  },
                ),
                Text(title!, style: AppTextStyle.semiBoldWhite14),
                SizedBox(
                  width: 5.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBarDoubleBackAddFeedback extends StatelessWidget {
  final String? title;
  final Function? onBackPressed;
  final VoidCallback? onAddPressed; // 👈 NEW

  const CustomAppBarDoubleBackAddFeedback({
    super.key,
    @required this.title,
    this.onBackPressed,
    this.onAddPressed, // 👈 NEW
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5.h,
            spreadRadius: 0.8.h,
            offset: Offset(0.1.h, 0.1.h),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            height: 12.h,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h),
            child: Row(
              children: [
                // 🔙 BACK BUTTON
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 3.h,
                  ),
                  onPressed: () {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Get.back();
                      Get.back();
                    }
                  },
                ),

                // 🏷 TITLE
                Expanded(
                  child: Text(
                    title!,
                    style: AppTextStyle.semiBoldWhite15,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),

                // ➕ ADD BUTTON (TOP RIGHT)
                if (onAddPressed != null)
                  Tooltip(
                    message: "Add Feedback / Complaint",
                    // Don't set triggerMode at all — hover works by default on desktop/web
                    waitDuration:
                        Duration(milliseconds: 1), // delay before showing
                    child: IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 3.5.h,
                      ),
                      onPressed: onAddPressed,
                    ),
                  ),

                SizedBox(width: 1.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
