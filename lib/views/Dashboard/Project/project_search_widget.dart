import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
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
  String? _selectedYear;

  final Map<int, String> searchTypes = {
    1: AppMetaLabels().halka,
    2: AppMetaLabels().uc,
    3: AppMetaLabels().ward,
    4: AppMetaLabels().pmo,
    5: AppMetaLabels().projectLeader,
    6: AppMetaLabels().projectName,
    7: AppMetaLabels().adpyear,
  };

  Map<int, String> getSearchTypes() {
    bool isEnglish = SessionController().getLanguage() == 1;

    return {
      1: isEnglish ? 'Halka' : 'حلقہ',
      2: isEnglish ? 'UC' : 'یوسی',
      3: isEnglish ? 'Ward' : 'وارڈ',
      4: isEnglish ? 'PMO' : 'پی ایم او',
      5: isEnglish ? 'Project Leader' : 'پروجیکٹ لیڈر',
      6: isEnglish ? 'Project Name' : 'پروجیکٹ کا نام',
      7: isEnglish ? 'ADP Year' : 'اے ڈی پی سال',
    };
  }

  final ProjectController getContractsController = Get.find();

  void _onSearch(String searchType, String search) {
    if (kDebugMode) {
      print('Type: $searchType | Query: $search');
    }
    getContractsController.getProjectsWithFilter(searchType, search);
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
          AppMetaLabels().searchProjectWith,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.semiBoldBlack14,
        ),
        SizedBox(height: 1.h),

        Wrap(
          spacing: 3,
          runSpacing: 3,
          children: searchTypes.entries.map((entry) {
            final selected = _selectedType == entry.key;
            return GestureDetector(
              onTap: () => setState(() {
                _selectedType = entry.key;
                _searchController.clear();
                _selectedYear = null;
              }),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
                      onChanged: (val) => setState(() {
                        _selectedType = val!;
                        _searchController.clear();
                        _selectedYear = null;
                      }),
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      entry.value,
                      style: AppTextStyle.semiBoldBlack13,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 12),

        /// 🔥 Dynamic Field (Dropdown OR TextField)
        _selectedType == 7
            ? SizedBox(
                height: 5.5.h,
                child: SizedBox(
                  height: 5.5.h,
                  child: DropdownButtonFormField<String>(
                    value: _selectedYear,
                    dropdownColor: Colors.white, // ✅ FIX: background color

                    items: List.generate(
                      2026 - 1995 + 1,
                      (index) {
                        final year = (1995 + index).toString();
                        return DropdownMenuItem(
                          value: year,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SessionController().getLanguage() == 1
                                    ? 4.w
                                    : 0.w,
                                right: SessionController().getLanguage() == 1
                                    ? 0.w
                                    : 4.w),
                            child: Text(
                              year,
                              style: AppTextStyle.normalGrey15,
                              textAlign: TextAlign.center,
                              // optional styling
                            ),
                          ),
                        );
                      },
                    ),

                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                    },

                    decoration: textFieldDecoration.copyWith(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColors.blueColor,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        bottom: 0.1.h,
                        left: 3.w,
                      ),
                    ),

                    /// ✅ IMPORTANT: use this instead of hintText
                    hint: Text(AppMetaLabels().selectyear,
                        style: AppTextStyle.normalGrey14),
                  ),
                ))
            : TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                  if (value.trim().isEmpty) {
                    getContractsController.getProjects();
                  }
                },
                decoration: textFieldDecoration.copyWith(
                  hintText: AppMetaLabels().search,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                            getContractsController.getProjects();
                          },
                        )
                      : null,
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
                style: AppTextStyle.normalGrey13,
              ),

        const SizedBox(height: 12),

        ButtonWidgetBlue(
          buttonText: AppMetaLabels().search,
          onPress: (_selectedType == 7
                  ? (_selectedYear == null || _selectedYear!.isEmpty)
                  : _searchController.text.trim().isEmpty)
              ? null
              : () => _onSearch(
                    _selectedType.toString(),
                    _selectedType == 7
                        ? _selectedYear!
                        : _searchController.text.trim(),
                  ),
        ),
      ],
    );
  }
}
