
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SnakBarWidget {
  static getSnackBarSuccess(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        backgroundColor: Colors.green[700],
        colorText: Colors.white,
        icon: const Icon(
          Icons.check,
          color: Colors.white,
        ));
  }

  static getSnackBarError(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlue(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  
 
 
  
  static getSnackBarErrorBlueWith20Sec(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 40),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getSnackBarErrorBlueWith5Sec(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.blue,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ));
  }
  static getSnackBarErrorRedWith5Sec(
    String title,
    String message,
  ) {
    return Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
        margin: EdgeInsets.only(bottom: 2.h, right: 1.h, left: 1.h),
        colorText: Colors.white,
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ));
  }

  static getLoading() {
    return Get.dialog(
        const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Colors.transparent,
        )),
        barrierDismissible: true);
  }

  static getLoadingWithColor() {
    return Get.dialog(
        const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
        )),
        barrierDismissible: false);
  }

  static getLoadingWithColorWithoutbarrierDismissible() {
    return Get.dialog(
        const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
        )),
        barrierDismissible: true);
  }
}
