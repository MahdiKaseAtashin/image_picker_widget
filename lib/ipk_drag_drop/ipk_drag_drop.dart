import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@protected
class ImagePickerDragDrop extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Border border;
  final BorderRadius borderRadius;
  final String? buttonTitle;
  final TextStyle errorMessageStyle;
  final Function(String data) onChange;
  final String? title;
  final TextStyle titleStyle;
  final String subtitle;
  final TextStyle subtitleStyle;

  const ImagePickerDragDrop({
    super.key,
    this.backgroundColor = const Color.fromARGB(255, 249, 250, 251),
    this.foregroundColor = const Color.fromARGB(255, 156, 163, 175),
    this.border = const Border.symmetric(
      horizontal:
          BorderSide(color: Color.fromARGB(255, 229, 231, 235), width: 2),
      vertical: BorderSide(color: Color.fromARGB(255, 229, 231, 235), width: 2),
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.buttonTitle,
    this.errorMessageStyle = const TextStyle(
      fontSize: 12,
      color: Colors.red,
    ),
    required this.onChange,
    this.title = "Click to upload or drag and drop",
    this.titleStyle = const TextStyle(
        fontSize: 14, color: Color.fromARGB(255, 107, 114, 128)),
    this.subtitle = "SVG, PNG, JPG or GIF (MAX. 800x400px)",
    this.subtitleStyle = const TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 107, 114, 128),
    ),
  });

  @override
  State<ImagePickerDragDrop> createState() => _ImagePickerDragDropState();
}

class _ImagePickerDragDropState extends State<ImagePickerDragDrop> {
  String _errorMessage = "";
  Uint8List? _selfieImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _getUserSelfie(),
      child: Container(
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: widget.border,
            borderRadius: widget.borderRadius),
        child: _selfieImage == null ? _emptyField() : _imageField(),
      ),
    );
  }

  Column _emptyField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 54),
        Icon(
          Icons.cloud_upload_rounded,
          size: 40,
          color: widget.foregroundColor,
        ),
        const SizedBox(height: 8),
        Text(widget.title ?? '',
            style: widget.titleStyle, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(widget.subtitle,
            style: widget.subtitleStyle, textAlign: TextAlign.center),
        if (widget.buttonTitle != null) const SizedBox(height: 8),
        if (widget.buttonTitle != null)
          ElevatedButton(onPressed: () => _getUserSelfie(), child: Text(widget.buttonTitle!)),
        if (_errorMessage.isNotEmpty) const SizedBox(height: 8),
        if (_errorMessage.isNotEmpty)
          Text("* $_errorMessage",
              style: widget.subtitleStyle.copyWith(color: Colors.red)),
        const SizedBox(height: 54),
      ],
    );
  }

  _getUserSelfie() async {
    try {
      _errorMessage = '';
      XFile? pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (pickedFile != null && mounted) {
        _selfieImage = await pickedFile.readAsBytes();
        if (_selfieImage != null) widget.onChange(base64Encode(_selfieImage!));
        setState(() {});
      }
    } catch (e) {
      _errorMessage = '$e';
      setState(() {});
    }
  }

  Widget _imageField() {
    return Center(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Image.memory(
            _selfieImage!,
            height: 200,
          ),
          InkWell(
            onTap: () => setState(() {
              _selfieImage = null;
            }),
            child: Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color.fromARGB(77, 0, 0, 0)),
              child: const Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
