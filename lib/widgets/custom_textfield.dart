import 'package:flutter/material.dart';
import 'package:hospital/core/theme/theme_helper.dart';
import 'package:hospital/core/utils/size_utils.dart';

extension T on TextFormField {
  static OutlineInputBorder get fillGreen => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static UnderlineInputBorder get underLineBlack => UnderlineInputBorder(
        borderSide: BorderSide(
          color: appTheme.black900.withOpacity(0.1),
        ),
      );
  static OutlineInputBorder get fillLightGreen => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide.none,
      );
  static OutlineInputBorder get outlineLightGreen => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide(
          color: appTheme.lightGreen40001,
          width: 1,
        ),
      );
}

class CustomTextFormField extends StatelessWidget {
  final Alignment alignment;
  final double width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle textStyle;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final int maxLines;
  final String hintText;
  final TextStyle hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets contentPadding;
  final InputBorder borderDecoration;
  final Color? fillColor;
  final bool filled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextCapitalization textCapitalization;
  const CustomTextFormField({
    super.key,
    borderRadius = const BorderRadius.all(Radius.circular(10)),
    borderSide = const BorderSide(color: Colors.grey, width: 1),
    this.alignment = Alignment.center,
    this.width = double.maxFinite,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle = const TextStyle(),
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.hintText = "",
    this.hintStyle = const TextStyle(),
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding = const EdgeInsets.all(9.0),
    this.borderDecoration = const OutlineInputBorder(),
    this.fillColor,
    this.filled = false,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != Alignment.center
        ? Align(
            alignment: alignment,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          focusNode: focusNode,
          autofocus: autofocus,
          style: textStyle,
          obscureText: obscureText,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines,
          decoration: decoration,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          textCapitalization: textCapitalization,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding,
        fillColor: fillColor,
        filled: filled,
        border: borderDecoration,
        enabledBorder: borderDecoration,
        focusedBorder: borderDecoration,
      );
}
