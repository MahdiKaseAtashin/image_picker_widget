import 'package:flutter/material.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

class ImagePickerK3 extends StatelessWidget {
  final Color backgroundColor;
  final Border border;
  final BorderRadius borderRadius;
  final String? buttonTitle;
  final TextStyle buttonTitleStyle;
  final Color foregroundColor;
  final String? helperText;
  final TextStyle helperTextStyle;
  final ImagePickerType ipkType;
  final Function(String data) onChange;
  final String subtitle;
  final TextStyle subtitleStyle;
  final String? title;
  final TextStyle titleStyle;

  const ImagePickerK3({
    super.key,
    this.backgroundColor = Colors.white,
    this.border = const Border.symmetric(
        horizontal: BorderSide(color: Color.fromARGB(255, 209, 213, 219)),
        vertical: BorderSide(color: Color.fromARGB(255, 209, 213, 219))),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.buttonTitle = "Choose File",
    this.buttonTitleStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.foregroundColor = Colors.blue,
    this.helperText,
    this.helperTextStyle = const TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 107, 114, 128),
    ),
    this.ipkType = ImagePickerType.dragDrop,
    required this.onChange,
    this.subtitle = "No file chosen",
    this.subtitleStyle = const TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 17, 25, 40),
    ),
    this.title,
    this.titleStyle = const TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 17, 25, 40),
    ),
  });

  @override
  Widget build(BuildContext context) {
    switch (ipkType) {
      case ImagePickerType.dragDrop:
        return ImagePickerDragDrop(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          border: border,
          borderRadius: borderRadius,
          buttonTitle: buttonTitle,
          errorMessageStyle: helperTextStyle.copyWith(color: Colors.red),
          onChange: onChange,
          title: title,
          titleStyle: titleStyle,
          subtitle: subtitle,
          subtitleStyle: subtitleStyle,
        );
      case ImagePickerType.simple:
        return ImagePickerField(
          backgroundColor: backgroundColor,
          border: border,
          borderRadius: borderRadius,
          buttonTitle: buttonTitle,
          buttonTitleStyle: buttonTitleStyle,
          foregroundColor: foregroundColor,
          helperText: helperText,
          helperTextStyle: helperTextStyle,
          onChange: onChange,
          subtitle: subtitle,
          subtitleStyle: subtitleStyle,
          title: title,
          titleStyle: titleStyle,
        );
    }
  }
}
