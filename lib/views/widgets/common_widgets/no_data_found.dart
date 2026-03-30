
import 'package:flutter/material.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppMetaLabels().noDatafound,
          ),
        ],
      ),
    );
  }
}
