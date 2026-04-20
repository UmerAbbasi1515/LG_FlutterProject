import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/background_image_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/divider_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/error_text_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:sizer/sizer.dart';
import 'language_controller.dart';

// ignore: must_be_immutable
class LanguageScreen extends StatefulWidget {
  final bool? cont;
  final bool? loggedIn;
  const LanguageScreen({super.key, this.cont = false, this.loggedIn});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final gLController = Get.put(LanguageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Stack(
          children: [
            const AppBackgroundImage(),
            Obx(() {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0.h),
                      child: Row(
                        mainAxisAlignment: widget.cont ?? false
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          if (!widget.cont!)
                            SizedBox(
                              width: 12.w,
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppMetaLabels().choose,
                                style: AppTextStyle.semiBoldWhite16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.0.h),
                                child: Text(
                                  AppMetaLabels().language,
                                  style: AppTextStyle.semiBoldWhite15,
                                ),
                              ),
                            ],
                          ),
                          if (!widget.cont!)
                            IconButton(
                              padding: EdgeInsets.all(1.w),
                              iconSize: 7.w,
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: gLController.loadingData.value
                          ? const LoadingIndicatorWhite()
                          : gLController.error.value != ''
                              ? AppErrorWidget(
                                  errorText: gLController.error.value,
                                  onRetry: () {
                                    gLController.getData();
                                  },
                                  color: AppMetaLabels().color,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 4.0.h),
                                  child: ListView.builder(
                                    // shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        gLController.model.value.data?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 1.0.h, bottom: 1.0.h),
                                            child: InkWell(
                                              onTap: () {
                                                gLController.changeLanguage(
                                                    gLController.model.value
                                                            .data?[index].id ??
                                                        -1,
                                                    widget.loggedIn ?? false,
                                                    widget.cont ?? false);
                                                setState(() {});
                                              },
                                              child: SizedBox(
                                                width: 90.0.w,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      (gLController
                                                                  .model
                                                                  .value
                                                                  .data?[index]
                                                                  .nameEn ==
                                                              "Urdu")
                                                          ? "اردو"
                                                          : gLController
                                                                  .model
                                                                  .value
                                                                  .data?[index]
                                                                  .nameEn ??
                                                              "",
                                                      style: AppTextStyle
                                                          .normalWhite16,
                                                    ),
                                                    const Spacer(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 3.0.h),
                                                      child: gLController
                                                                  .selectedLang
                                                                  .value ==
                                                              gLController
                                                                  .model
                                                                  .value
                                                                  .data?[index]
                                                                  .id
                                                          // index
                                                          ? Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                              size: 2.5.h,
                                                            )
                                                          : const SizedBox(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          index ==
                                                  (gLController.model.value.data
                                                              ?.length ??
                                                          0) -
                                                      1
                                              ? const SizedBox()
                                              : const AppDivider(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              );
            }),
            if (widget.cont!)
              Padding(
                padding: EdgeInsets.only(bottom: 4.0.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: gLController.loadingData.value
                      ? const LoadingIndicatorWhite()
                      : gLController.error.value != ''
                          ? const SizedBox()
                          : ButtonWidget(
                              buttonText: AppMetaLabels().cont,
                              onPress: () async {
                                await gLController.countinueBtn();
                              },
                            ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
