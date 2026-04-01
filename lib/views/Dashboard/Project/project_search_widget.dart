import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/utils/styles/colors.dart';
import 'package:localgovernment_project/utils/styles/text_field_style.dart';
import 'package:localgovernment_project/utils/styles/text_styles.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_controller.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/button_widget.dart';
import 'package:sizer/sizer.dart';

class ProjectSearchWidget extends StatefulWidget {
  const ProjectSearchWidget({super.key});

  @override
  State<ProjectSearchWidget> createState() => _ProjectSearchWidgetState();
}

class _ProjectSearchWidgetState extends State<ProjectSearchWidget> {
  int _selectedType = 1;
  final TextEditingController _searchController = TextEditingController();

  final Map<int, String> searchTypes = {
    1: 'Halka',
    2: 'UC',
    3: 'Ward',
    4: 'PMO',
    5: 'Project Leader',
    6: 'Project Name',
  };
  final ProjectController getContractsController = Get.find();
  void _onSearch(String searchType, String search) {
    if (kDebugMode) {
      print('Type: $searchType | Query: $search');
    }
    getContractsController.getProjectsWithFilter(searchType, search);
    // call your API here
    // e.g. getContractsController.searchProjects(searchType, query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Search project with",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.semiBoldBlack14,
        ),
        SizedBox(
          height: 1.h,
        ),
        Wrap(
          spacing: 3,
          runSpacing: 3,
          children: searchTypes.entries.map((entry) {
            final selected = _selectedType == entry.key;
            return GestureDetector(
              onTap: () => setState(() => _selectedType = entry.key),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: selected ? Colors.blue.shade50 : Colors.transparent,
                  border: Border.all(
                    color:
                        selected ? AppColors.blueColor : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<int>(
                      value: entry.key,
                      groupValue: _selectedType,
                      activeColor: AppColors.blueColor,
                      onChanged: (val) => setState(() => _selectedType = val!),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    SizedBox(width: 4),
                    Text(
                      entry.value,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {});
            if (value.trim().isEmpty) {
              getContractsController.getProjects();
            }
          },
          decoration: textFieldDecoration.copyWith(
            hintText: AppMetaLabels().search,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: AppColors.blueColor, width: 2.0),
            ),
          ),
          style: AppTextStyle.normalGrey10,
        ),
        SizedBox(height: 12),
        ButtonWidgetBlue(
          buttonText: AppMetaLabels().search,
          onPress: _searchController.text.trim().isEmpty
              ? null
              : () => _onSearch(
                  _selectedType.toString(), _searchController.text.trim()),
        ),
      ],
    );
  }
}
