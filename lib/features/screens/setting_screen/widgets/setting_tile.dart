import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_test/features/screens/setting_screen/widgets/game_switch.dart';

class SettingTile extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  late bool current;

  @override
  void initState() {
    super.initState();
    current = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          GameSwitch(
            value: current,
            onChanged: (v) {
              setState(() => current = v);
              widget.onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}
