import 'package:e_commerce_app_with_firebase_riverpod/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final String? hintText;
  final String labelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const KTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.hintText,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.numberFormatters = false,
      this.obscureText = false});
  final bool obscureText, numberFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 15.sp,
          color: AppColors.deep_orange,
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF414041),
        ),
      ),
      obscureText: obscureText,
      inputFormatters: [
        if (numberFormatters)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
