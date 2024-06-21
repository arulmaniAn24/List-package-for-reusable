import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class CameraExample extends StatefulWidget {
   @override
  State<CameraExample> createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  late CameraController _controller;
  late Future<void> _initializeFutureController;

  @override
  void initState() {
    _controller = CameraController(
        CameraDescription(
            sensorOrientation: 1,
            name: '0',
            lensDirection: CameraLensDirection.back
        ),
        ResolutionPreset.medium
    );
    _initializeFutureController = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeFutureController,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(
          Icons.camera,
          color: Colors.black,
        ),
        onPressed: () async {
          try{
            final image = await _controller.takePicture();
            PreviewScreen(imagePath: image.path);
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewScreen(imagePath:image.path),
            // ));
          }catch(e){
            print(e.toString());
          }
        },
      ),

    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String imagePath;
  const PreviewScreen({Key? key, required this.imagePath}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PreviewScreen"),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

