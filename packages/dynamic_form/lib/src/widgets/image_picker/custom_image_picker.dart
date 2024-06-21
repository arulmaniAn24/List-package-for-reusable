import 'dart:io';
import 'package:dynamic_form/src/widgets/image_picker/image_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({
    required this.onSelected,
    super.key,
    this.isReadOnly,
    this.hintText,
    this.labelText,
    this.multiSelect,
  });
  final String? hintText;
  final bool? isReadOnly;
  final bool? multiSelect;
  final String? labelText;
  final ValueChanged<List<File>?> onSelected;

  @override
  CustomImagePickerState createState() => CustomImagePickerState();
}

final imagePicker = ImageHelper();

class CustomImagePickerState extends State<CustomImagePicker> {
  File? _image;
  List<File>? _images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: widget.multiSelect == true
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    final files = await imagePicker.pickImage(multiple: true);
                    if (files?.isNotEmpty == true) {
                      setState(() {
                        _images = files?.map((e) => File(e.path)).toList();
                        widget.onSelected(_images);
                      });
                    }
                  },
                  child: const Text('Select image'),
                ),
                _images != null
                    ? Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: _images!
                            .map(
                              (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  e,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox()
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image != null
                    ? SizedBox(
                        width: MediaQuery.sizeOf(context).width / 1.25,
                        height: MediaQuery.sizeOf(context).height / 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.file(_image!),
                          ),
                        ),
                      )
                    : const SizedBox(),
                TextButton(
                  onPressed: () => _showActionSheet(context),
                  child: const Text('Select image'),
                )
              ],
            ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Pick Image'),
        // message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final files = await imagePicker.captureImage();
              if (files?.isNotEmpty == true) {
                final croppedFile = await imagePicker.crop(file: files!.first);
                if (croppedFile != null) {
                  setState(() {
                    _image = File(croppedFile.path);
                    widget.onSelected([_image!]);
                  });
                }
              }
            },
            child: const Text('From Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final files = await imagePicker.pickImage();
              if (files?.isNotEmpty == true) {
                final croppedFile = await imagePicker.crop(file: files!.first);
                if (croppedFile != null) {
                  setState(() {
                    _image = File(croppedFile.path);
                    widget.onSelected([_image!]);
                  });
                }
              }
            },
            child: const Text('From Files'),
          ),
        ],
      ),
    );
  }
}
