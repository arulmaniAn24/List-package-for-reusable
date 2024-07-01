abstract class DocumentUploadEvent {}

class PickFiles extends DocumentUploadEvent {}

class ToggleExpanded extends DocumentUploadEvent {}

class RemoveFile extends DocumentUploadEvent {
  final int index;

  RemoveFile(this.index);
}
