// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:sizer/sizer.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorText;
  final String errorImage;
  final VoidCallback? onRetry;
  const CustomErrorWidget(
      {super.key,
      this.errorText = '',
      this.errorImage = AppImagesPath.noDataFound,
      this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Align(
              alignment: Alignment.center,
              child:
                  Image.asset(errorImage, fit: BoxFit.contain, width: 45.0.w)),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                errorText,
                style: AppTextStyle.semiBoldGrey16,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (onRetry != null)
            Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: onRetry,
                )),
        ],
      ),
    );
  }
}
