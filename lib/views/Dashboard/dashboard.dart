import 'package:flutter/material.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        height: 100.h,
        width: 100.w,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(SessionController().getUser().nameEn??""),
            Text(SessionController().getUser().nameUr??""),
            Text(SessionController().getUser().email??""),
            Text(SessionController().getUser().phone??""),
            Text(SessionController().getUser().id.toString()),
            Text(SessionController().getToken()??""),
          ],
        )),
      ),
    );
  }
}
