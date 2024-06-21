import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class FilePickerExample extends StatefulWidget {
  @override
  _FilePickerExampleState createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  List<PlatformFile>? _files;

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setState(() {
          _files = result.files;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple File Picker Example'),centerTitle: true,backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickFiles,
              child: Text(' + Pick Files'),
            ),
            SizedBox(height: 20),
            _files != null ? buildFileListView() : Container(),
          ],
        ),
      ),
    );
  }

  Widget buildFileListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _files!.length,
        itemBuilder: (context, index) {
          final file = _files![index];
          return ListTile(
            title: Text(file.name),
            subtitle: Text('${file.size} bytes'),
          );
        },
      ),
    );
  }
}


// class File_Picker extends StatefulWidget {
//   const File_Picker({super.key});

//   @override
//   State<File_Picker> createState() => _File_PickerState();
// }

// class _File_PickerState extends State<File_Picker> {
//   FilePickerResult? result;
//   String? fileName;
//   PlatformFile? pickedFile;
//   bool isLoading = false;
//   File? fileToDisplay;

//   void PickFile() async{

//     try{
//       setState(() {
//         isLoading = true;
//       });


//       result = await FilePicker.platform.pickFiles(
//         type: FileType.any,allowMultiple: true,
//       );

//       if (result != null){
//         fileName = result!.files.first.name;
//         pickedFile = result!.files.first;
//         fileToDisplay = File(pickedFile!.path.toString());

//         print('File name $fileName');

//       }

//       setState(() {
//         isLoading = false;
//       });
//     }catch(e){
//       print(e);
//     }
//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("F I L E   P I C K E R"),backgroundColor: Colors.blue,centerTitle: true,),
//       body: 
//         Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: isLoading? CircularProgressIndicator():TextButton(onPressed: (){
//                 PickFile();
//               }, child: Text(" + Add File"))
//             ),
//             if (pickedFile != null)
//             SizedBox(height: 200,child: Image.file(fileToDisplay!),)
//           ],
//         ),
      
    
//     );
//   }
// }