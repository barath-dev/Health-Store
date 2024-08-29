// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hospital/core/theme/theme_helper.dart';
import 'package:hospital/core/utils/size_utils.dart';

class CustomCheckboxButton extends StatelessWidget {
  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  bool? value;
  final Function(bool) onChange;
  final EdgeInsetsGeometry? padding;
  final String? text;
  final double? width;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final bool isExpandedText;
  CustomCheckboxButton({
    super.key,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    required this.onChange,
    this.padding,
    this.text,
    this.width,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  });
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildCheckBoxWidget)
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => GestureDetector(
        onTap: () {
          value = !(value!);
          onChange(value!);
        },
        child: Container(
          decoration: decoration,
          width: width,
          child: (isRightCheck ?? false) ? rightSideCheckbox : leftSideCheckbox,
        ),
      );
  Widget get leftSideCheckbox => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: checkboxWidget,
          ),
          isExpandedText ? Expanded(child: textWidget) : textWidget
        ],
      );
  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: checkboxWidget,
          )
        ],
      );
  Widget get textWidget => Text(
        text ?? "null",
        textAlign: textAlignment ?? TextAlign.start,
        style: textStyle ?? theme.textTheme.bodyLarge,
      );
  Widget get checkboxWidget => SizedBox(
        height: iconSize ?? 20.h,
        width: iconSize ?? 20.h,
        child: Checkbox(
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? false,
          activeColor: appTheme.lightGreen40001,
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(
              color: appTheme.lightGreen40001,
            ),
          ),
          onChanged: (value) {
            onChange(value!);
          },
        ),
      );
}
