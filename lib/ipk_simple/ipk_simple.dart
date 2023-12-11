import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final Color backgroundColor;
  final Border? border;
  final BorderRadius? borderRadius;
  final String? buttonTitle;
  final TextStyle buttonTitleStyle;
  final Color foregroundColor;
  final String? helperText;
  final TextStyle helperTextStyle;
  final Function(String data) onChange;
  final String subtitle;
  final TextStyle subtitleStyle;
  final String? title;
  final TextStyle titleStyle;

  const ImagePickerField({
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
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  String _errorMessage = "";
  String _selfieImage = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) _titleText(),
        if (widget.title != null) const SizedBox(height: 12),
        _body(),
        if (_errorMessage.isNotEmpty) const SizedBox(height: 12),
        if (_errorMessage.isNotEmpty) _errorText(),
        if (widget.helperText != null) const SizedBox(height: 12),
        if (widget.helperText != null) _helperText(),
      ],
    );
  }

  Text _titleText() {
    return Text(
      widget.title!,
      style: widget.titleStyle,
    );
  }

  Text _helperText() {
    return Text(
      widget.helperText!,
      style: widget.helperTextStyle,
    );
  }

  Container _body() {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: widget.border,
        borderRadius: widget.borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _chooseFileButton(),
          const SizedBox(width: 16),
          _subtitleWidget()
        ],
      ),
    );
  }

  Widget _subtitleWidget() {
    return Expanded(
        child: Text(
      _selfieImage.isEmpty ? widget.subtitle : _selfieImage,
      style: widget.subtitleStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ));
  }

  Widget _chooseFileButton() {
    return InkWell(
      onTap: () => _getUserSelfie(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: widget.foregroundColor,
          borderRadius: BorderRadius.only(
            topRight: widget.borderRadius?.topRight ?? Radius.zero,
            bottomRight: widget.borderRadius?.bottomRight ?? Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            widget.buttonTitle??'',
            style: widget.buttonTitleStyle,
          ),
        ),
      ),
    );
  }

  Widget _errorText() {
    return Text(
      "* $_errorMessage",
      style: widget.helperTextStyle.copyWith(color: Colors.red),
    );
  }

  _getUserSelfie() async {
    try {
      _errorMessage = '';
      XFile? pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (pickedFile != null && mounted) {
        _selfieImage = pickedFile.path;
        if (_selfieImage.isNotEmpty) widget.onChange(_selfieImage);
        setState(() {});
      }
    } catch (e) {
      _errorMessage = '$e';
      setState(() {});
    }
  }
}
