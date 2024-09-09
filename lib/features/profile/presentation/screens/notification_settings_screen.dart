import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/widgets/custom_app_bar.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBackAppBar(title: 'Notifications'),
      body: Column(
        children: [
          CustomSwitch(
            title: 'Toutes les notifications',
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            height: 24.h,
          ),
          CustomSwitch(
            title: 'Mise à jour des applications',
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            height: 24.h,
          ),
          CustomSwitch(
            title: 'Alertes par SMS',
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            height: 24.h,
          ),
          CustomSwitch(
            title: 'Politique de confidentialité',
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            height: 24.h,
          ),
          CustomSwitch(
            title: 'Nouveau service',
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
            height: 24.h,
          ),
        ],
      ),
    );
  }
}

//
//
// Politique de confidentialité
// Nouveau service

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double height;
  final Color activeColor;
  final String title;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
    this.height = 24.0, // Default height
    this.activeColor = AppColor.primary, // Default active color
    // Default inactive color
  });

  @override
  Widget build(BuildContext context) {
    final double width = height * 2.0;
    final double switchPadding = height * 0.1;

    return SizedBox(
      // height: 38.h,
      child: ListTile(
        minTileHeight: 38.h,
        title: Text(
          title,
          style: TextStyle(
            color: AppColor.primaryGray,
            fontSize: 14.sp,
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25.sp,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            onChanged(!value);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width,
            height: height,
            padding: EdgeInsets.all(switchPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              color: value ? activeColor : Colors.grey[300]!,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: value ? width - height : 0.0,
                  top: 0.0,
                  right: value ? 0.0 : width - height,
                  child: Container(
                    width: height - switchPadding * 2,
                    height: height - switchPadding * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
