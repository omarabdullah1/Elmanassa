import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/student_home_cubit/student_home_cubit.dart';
import '../styles/colors.dart';
import '../styles/texts.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function? onSubmit;
  final ValueChanged<String>? onChange;
  final Function? onTap;
  final double borderRadius;
  final Icon? suffixIcon;
  final Color baseColor;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.borderRadius = 20.0,
    this.suffixIcon,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppColor.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: baseColor
                  .withOpacity(0.4),
              blurRadius: borderRadius,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: TextFormField(
            style: TextStyles
                .studentHomeCourseSubscribeScreenPaymentCodeTextInputStyle,
            controller: controller,
            keyboardType: type,
            onFieldSubmitted: (s) => onSubmit!(s),
            onChanged: onChange,
            onTap: () => onTap,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: baseColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              suffixIcon: suffixIcon,
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.error,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.error,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: baseColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: baseColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            cursorColor: AppColor.black,
            cursorWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
