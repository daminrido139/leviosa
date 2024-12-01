import 'package:flutter/material.dart';
import 'package:leviosa/widgets/common/leviosa_text.dart';

class LeviosaFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextStyle? titleTextStyle;
  final EdgeInsets? padding;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  const LeviosaFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.titleTextStyle,
    this.padding,
    this.minLines,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: LeviosaText(
              title,
              style: titleTextStyle ??
                  const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 4),
              Expanded(
                child: TextFormField(
                  minLines: minLines,
                  maxLines: maxLines,
                  maxLength: maxLength,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter $hintText';
                    }
                    return null;
                  },
                  controller: controller,
                  style: const TextStyle(fontSize: 20),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xffad9c00)),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
