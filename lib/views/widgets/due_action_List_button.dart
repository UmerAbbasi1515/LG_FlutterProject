// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:localgovernment_project/views/widgets/step_no_widget.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';

class DueActionListButton extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final bool? loading;
  final String? srNo;
  const DueActionListButton(
      {super.key, this.onPressed, this.text, this.loading = false, this.srNo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading!
          ? null
          : () {
              onPressed!();
            },
      child: Row(
        children: <Widget>[
          StepNoWidget(
            label: srNo!,
            tooltip: text!,
            color: AppColors.blueColor2,
            textColor: AppColors.blueColor,
          ),
          SizedBox(
            height: 8.h,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(text.toString())  ),
          ),
        ],
      ),
    );
  }
}
