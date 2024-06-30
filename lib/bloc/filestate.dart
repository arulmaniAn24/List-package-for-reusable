import 'package:file_picker/file_picker.dart';

class DocumentUploadState {
  final bool isExpanded;
  final List<PlatformFile> uploadFiles;

  DocumentUploadState({
    required this.isExpanded,
    required this.uploadFiles,
  });

  DocumentUploadState copyWith({
    bool? isExpanded,
    List<PlatformFile>? uploadFiles,
  }) {
    return DocumentUploadState(
      isExpanded: isExpanded ?? this.isExpanded,
      uploadFiles: uploadFiles ?? this.uploadFiles,
    );
  }
}

class DocumentUploadInitial extends DocumentUploadState {
  DocumentUploadInitial() : super(isExpanded: false, uploadFiles: []);
}
