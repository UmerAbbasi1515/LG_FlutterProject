// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/utils/constants/assets_path.dart';
import 'package:localgovernment_project/utils/constants/meta_labels.dart';
import 'package:localgovernment_project/views/Dashboard/Project/project_screen.dart';
import 'package:localgovernment_project/views/Dashboard/dashboard_tabs/dashboard_tabs_controller.dart';
import 'package:localgovernment_project/views/Dashboard/More/more.dart';
import 'package:localgovernment_project/views/widgets/common_widgets/backbround_concave.dart';
import 'package:localgovernment_project/views/widgets/custom_nav_bar.dart';


class TenantDashboardTabs extends StatefulWidget {
  final int? initialIndex;
  const TenantDashboardTabs({
    super.key,
    this.initialIndex = 0,
  });

  @override
  TenantDashboardTabsState createState() => TenantDashboardTabsState();
}

class TenantDashboardTabsState extends State<TenantDashboardTabs> {
  // ignore: unused_field
  final TenantDashboardTabsController _dashboardTabsController =
      Get.put(TenantDashboardTabsController());

  int? _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  List<Widget>? _buildScreens;

  @override
  Widget build(BuildContext context) {
    _buildScreens = [
      ProjectScreen(
        projects: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    ];

    return WillPopScope(
        onWillPop: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          return false;
        },
        child: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                const AppBackgroundConcave(),
                SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: _buildScreens![_selectedIndex!],
                      ),
                      CustomNavBar(
                        items: [
                          NavBarItem(
                            icon: _selectedIndex == 0
                                ? AppImagesPath.home2
                                : AppImagesPath.home,
                            title: AppMetaLabels().projects,
                            onTap: (pos) {
                              setState(() {
                                _selectedIndex = pos;
                              });
                            },
                            position: 0,
                          ),
                          NavBarItem(
                            icon: AppImagesPath.menu,
                            title: AppMetaLabels().more,
                            onTap: (pos) async {
                              await Get.to(() => const TenantMoreScreen());
                              
                            },
                            position: 4,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
