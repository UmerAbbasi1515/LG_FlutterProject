import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/More/profile/profile_controller.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/backbround_concave.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/error_text_widget.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:sizer/sizer.dart';

class TenantProfile extends StatefulWidget {
  const TenantProfile({super.key});

  @override
  State<TenantProfile> createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile> {
  final profileController = Get.put(ProfileController());

  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _populateFields() {
    final data = profileController.model.value.data;
    final isEn = SessionController().getLanguage() == 1;
    _nameController.text = isEn
        ? SessionController().getUser().nameEn ?? ""
        : SessionController().getUser().nameUr ?? "";
    _phoneController.text = data?.phone ?? "";
    _emailController.text = data?.email ?? "";
    _addressController.text =
        isEn ? data?.address ?? "" : data?.addressUr ?? "";
  }

  Future<void> _onUpdatePressed() async {
    if (_isEditing) {
      await profileController.updateProfile(
        _nameController.text,
        _phoneController.text,
        _emailController.text,
        _addressController.text,
      );
      profileController.getProfile();
    } else {
      _populateFields();
    }
    setState(() => _isEditing = !_isEditing);
  }

  @override
  Widget build(BuildContext context) {
    final isEn = SessionController().getLanguage() == 1;

    return Directionality(
      textDirection: isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            const AppBackgroundConcaveProfile(),
            SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 1.0.h, top: 2.0.h),
                      child: SizedBox(
                        height: 8.h,
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () => Get.back(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 11.0.h),
                              child: Text(
                                AppMetaLabels().myProfile,
                                style: AppTextStyle.semiBoldWhite14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (profileController.loadingData.value) {
                      return Padding(
                        padding: EdgeInsets.only(top: 30.0.h),
                        child: const LoadingIndicatorBlue(),
                      );
                    }

                    if (profileController.error.value != '') {
                      return Padding(
                        padding: EdgeInsets.only(top: 30.0.h),
                        child: AppErrorWidget(
                          errorText: profileController.error.value,
                        ),
                      );
                    }

                    return Column(
                      children: [
                        // Avatar
                        Container(
                          height: 15.h,
                          padding: EdgeInsets.all(0.0.h),
                          margin: EdgeInsets.only(top: 1.h),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(72, 88, 106, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(2.0.h),
                                child: Text(
                                  profileController.getInitials(
                                    isEn
                                        ? profileController
                                                .model.value.data?.nameEn ??
                                            ""
                                        : profileController
                                                .model.value.data?.nameUr ??
                                            "",
                                  ),
                                  style: AppTextStyle.semiBoldWhite16
                                      .copyWith(fontSize: 24.sp),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Info Card
                        Padding(
                          padding: EdgeInsets.all(2.0.h),
                          child: Padding(
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: Container(
                              width: 94.0.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.3.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(1.0.h),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppMetaLabels().personalInfo,
                                      style: AppTextStyle.semiBoldBlack14,
                                    ),
                                    SizedBox(height: 0.h),
                                    _profileField(
                                      label: AppMetaLabels().name,
                                      controller: _nameController,
                                      isEditing: _isEditing,
                                      staticValue: isEn
                                          ? profileController
                                                  .model.value.data?.nameEn ??
                                              ""
                                          : profileController
                                                  .model.value.data?.nameUr ??
                                              "",
                                    ),
                                    _profileField(
                                      label: AppMetaLabels().mobileNumber,
                                      controller: _phoneController,
                                      isEditing: _isEditing,
                                      staticValue: profileController
                                              .model.value.data?.phone ??
                                          "",
                                      keyboardType: TextInputType.phone,
                                      forceLeftToRight: true,
                                    ),
                                    _profileField(
                                      label: AppMetaLabels().email,
                                      controller: _emailController,
                                      isEditing: _isEditing,
                                      staticValue: profileController
                                              .model.value.data?.email ??
                                          "",
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    _profileField(
                                      label: AppMetaLabels().address,
                                      controller: _addressController,
                                      isEditing: _isEditing,
                                      staticValue: isEn
                                          ? profileController
                                                  .model.value.data?.address ??
                                              ""
                                          : profileController.model.value.data
                                                  ?.addressUr ??
                                              "",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 1.0.h),

                        // Button toggles between "Update Profile" and "Save"
                        ButtonWidgetPermBlue(
                          buttonText: _isEditing
                              ? AppMetaLabels().save
                              : AppMetaLabels().updateProfile,
                          onPress: _onUpdatePressed,
                        ),

                        // Cancel button shown only in edit mode
                        if (_isEditing)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => setState(() => _isEditing = false),
                              child: Column(
                                children: [
                                  Text(
                                    AppMetaLabels().cancel,
                                    style: AppTextStyle.semiBoldBlue15,
                                  ),
                                  Container(
                                    color: AppColors.blueColor,
                                    height: 0.1.h,
                                    width: 10.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required String staticValue,
    TextInputType keyboardType = TextInputType.text,
    bool forceLeftToRight = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 2.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.normalGrey12),
          SizedBox(height: 0.5.h),
          isEditing
              ? Directionality(
                  textDirection:
                      forceLeftToRight ? TextDirection.ltr : TextDirection.ltr,
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    style: AppTextStyle.semiBoldBlack12,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 1.5.h, vertical: 1.2.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            BorderSide(color: AppColors.blueColor, width: 2.0),
                      ),
                    ),
                  ),
                )
              : Directionality(
                  textDirection:
                      forceLeftToRight ? TextDirection.ltr : TextDirection.ltr,
                  child: Text(
                    staticValue,
                    style: AppTextStyle.semiBoldBlack13,
                  ),
                ),
        ],
      ),
    );
  }
}
