import 'package:flutter/material.dart';

import 'package:task1/File_Picker/FilePicker/fileupload.dart';

import 'Image_Picker/ImagePicker/imageupload.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImageUpload(),
    );
  }
}
