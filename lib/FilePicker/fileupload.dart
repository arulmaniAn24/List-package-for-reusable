//import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
//import 'package:image_picker/image_picker.dart';
import '../bloc/filebloc.dart';
import '../bloc/fileevent.dart';
import '../bloc/filestate.dart';
import '../constants/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'filecard.dart';

class DocumentUpload extends StatefulWidget {
  const DocumentUpload({super.key});

  @override
  State<DocumentUpload> createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {
  bool isExpanded = false;
  final List<PlatformFile> _uploadFiles = [];

  // Future<void> _pickFiles() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);

  //   if (result != null) {
  //     setState(() {
  //       _uploadFiles.addAll(result.files);
  //     });
  //   }
  // }

  // Future<void> _captureImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _uploadFiles.add(PlatformFile(
  //         name: pickedFile.path.split('/').last,
  //         size: File(pickedFile.path).lengthSync(),
  //       ));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocumentUploadBloc(),
      child: BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
          builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 70.0, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Document Upload',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 15,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<DocumentUploadBloc>()
                                .add(ToggleExpanded());
                          },
                          child: BlocBuilder<DocumentUploadBloc,
                              DocumentUploadState>(builder: (context, state) {
                            return SvgPicture.asset(
                              state.isExpanded
                                  ? 'assets/images/arrowup.svg'
                                  : 'assets/images/arrowdown.svg',
                              height: 10,
                              width: 10,
                              fit: BoxFit.contain,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      border: Border.all(
                        color: AppColors.secondary3Color,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.read<DocumentUploadBloc>().add(PickFiles());

                        // Navigator.pop(context);
                        // showCupertinoModalPopup(
                        //   context: context,
                        //   builder: (context) => _buildCupertinoActionSheet(context),
                        // );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/upload.svg',
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Click to upload',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary3Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoContainer('PDF', isFirst: true),
                      const SizedBox(width: 2),
                      _buildInfoContainer('DOCX', isFirst: true),
                      const SizedBox(width: 2),
                      _buildInfoContainer('EXCEL', isFirst: true),
                      const SizedBox(width: 2),
                      _buildInfoContainer('>5MB', isFirst: false),
                    ],
                  ),
                  BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
                      builder: (context, state) {
                    return AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: Container(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.6 / 2,
                          ),
                          itemCount: state.uploadFiles.length,
                          itemBuilder: (context, index) {
                            return FileCard(
                                fileName: state.uploadFiles[index].name,
                                fileSize:
                                    '${(state.uploadFiles[index].size / 1024).toStringAsFixed(2)} KB',
                                onCancel: () {
                                  context
                                      .read<DocumentUploadBloc>()
                                      .add(RemoveFile(index));
                                });
                          },
                        ),
                      ),
                      crossFadeState: state.isExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Widget _buildCupertinoActionSheet(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 7.0),
  //     child: CupertinoActionSheet(
  //       actions: [
  //         CupertinoActionSheetAction(
  //           onPressed: () {
  //             _captureImage();
  //             Navigator.pop(context);
  //           },
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //                 child: SvgPicture.asset(
  //                   'assets/images/camera.svg',
  //                   height: 24,
  //                   width: 24,
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               const Text(
  //                 'Capture',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: AppColors.secondary3Color,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         CupertinoActionSheetAction(
  //           onPressed: () {
  //             _pickFiles();
  //             Navigator.pop(context);
  //           },
  //           child: Row(
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //                 child: SvgPicture.asset(
  //                   'assets/images/gallery.svg',
  //                   height: 24,
  //                   width: 24,
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               const Text(
  //                 'Gallery',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: AppColors.secondary3Color,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //       cancelButton: Container(
  //         decoration: BoxDecoration(
  //           color: AppColors.primaryColor,
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: CupertinoActionSheetAction(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text(
  //             'Cancel',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: AppColors.backgroundColor,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildInfoContainer(String text, {required bool isFirst}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: isFirst ? 4 : 2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: text == '>5MB'
              ? AppColors.backgroundColor
              : AppColors.secondary3Color,
          border: Border.all(color: AppColors.secondary3Color),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
