import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatefulWidget {
  final String label;
  final String? initial;
  final ValueChanged<String>? onChanged;

  const InputField({
    super.key,
    required this.label,
    this.initial,
    this.onChanged,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initial ?? "");
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initial != oldWidget.initial) {
      controller.text = widget.initial ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6CD8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: widget.onChanged,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: widget.label,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.edit, color: Colors.white, size: 20.sp),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}
