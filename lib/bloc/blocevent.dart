abstract class AudioRecorderEvent {}

class StartRecording extends AudioRecorderEvent {}

class StopRecording extends AudioRecorderEvent {}

class PlayRecording extends AudioRecorderEvent {
  final int index;
  PlayRecording(this.index);
}

class DeleteRecording extends AudioRecorderEvent {
  final int index;
  DeleteRecording(this.index);
}

class LoadRecordedFiles extends AudioRecorderEvent {}

class TimerStart extends AudioRecorderEvent {}

class PausePlaying extends AudioRecorderEvent {}

class StopPlaying extends AudioRecorderEvent {}
