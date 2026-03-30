
import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';

class AppBackgroundImage extends StatelessWidget {
  const AppBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        AppImagesPath.backgroundImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
