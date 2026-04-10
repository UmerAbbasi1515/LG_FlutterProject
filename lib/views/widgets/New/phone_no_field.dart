import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/auth/auth_flow/validate_user_controller.dart';
import 'package:sizer/sizer.dart';

class PhoneNoFieldWidget extends StatelessWidget {
  PhoneNoFieldWidget({super.key});
  static final TextEditingController phoneController = TextEditingController();
  final tooltipKey = GlobalKey<State<Tooltip>>();
  final vUController = Get.put(ValidateFirebaseUserController());

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: phoneController,
      onTap: () {
        vUController.textFieldTap.value = true;
      },
      cursorHeight: 3.0.h,
      style: AppTextStyle.normalWhite13,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      onSubmitted: (a) {
        FocusScope.of(context).unfocus();

        vUController.textFieldTap.value = false;
      },
      onEditingComplete: () async {
        await vUController.validateMobileUser();
        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        vUController.textFieldTap.value = false;
      },
      decoration: InputDecoration(
        suffixIcon: Tooltip(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          textStyle: AppTextStyle.normalBlack10,
          key: tooltipKey,
          message: AppMetaLabels().validPhoneNo,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _onTap(tooltipKey),
            child: Icon(
              Icons.info_outline,
              color: vUController.error.value != '' ||
                      vUController.errorValidateUser.value != ""
                  ? AppColors.redColor
                  : AppColors.whiteColor,
            ),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.3.h),
          borderSide: BorderSide(color: Colors.transparent, width: 0.1.h),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.3.h),
          borderSide: BorderSide(color: Colors.transparent, width: 0.1.h),
        ),
      ),
      cursorColor: Colors.white,
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}

