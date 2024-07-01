import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'fileevent.dart';
import 'filestate.dart';

class DocumentUploadBloc
    extends Bloc<DocumentUploadEvent, DocumentUploadState> {
  DocumentUploadBloc() : super(DocumentUploadInitial()) {
    on<PickFiles>((event, emit) async {
      await _pickFiles(emit);
    });
    on<ToggleExpanded>((event, emit) {
      _toggleExpanded(emit);
    });
    on<RemoveFile>((event, emit) {
      _removeFile(event.index, emit);
    });
  }

  Future<void> _pickFiles(Emitter<DocumentUploadState> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
         
      allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx']
    );

    if (result != null) {
      List<PlatformFile> updatedFiles = List.from(state.uploadFiles)
        ..addAll(result.files);
      emit(state.copyWith(uploadFiles: updatedFiles));
    }
  }

  void _toggleExpanded(Emitter<DocumentUploadState> emit) {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  void _removeFile(int index, Emitter<DocumentUploadState> emit) {
    List<PlatformFile> updatedFiles = List.from(state.uploadFiles)
      ..removeAt(index);
    emit(state.copyWith(uploadFiles: updatedFiles));
  }
}
