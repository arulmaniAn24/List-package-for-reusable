abstract class AudioRecorderState {}

class AudioRecorderInitial extends AudioRecorderState {}

class AudioRecordingStarted extends AudioRecorderState {
  final Duration duration;
  AudioRecordingStarted(this.duration);
}

class AudioRecorderStopped extends AudioRecorderState {
  final List<String> recordedFiles;

  AudioRecorderStopped(this.recordedFiles);
}

class AudioRecordingPlaying extends AudioRecorderState {
  final int playingIndex;
  AudioRecordingPlaying(this.playingIndex);
}

class AudioRecordingDeleting extends AudioRecorderState {
  final int deletingIndex;
  AudioRecordingDeleting(this.deletingIndex);
}

class AudioRecorderError extends AudioRecorderState {
  final String message;
  AudioRecorderError(this.message);
}

class AudioPlayerPaused extends AudioRecorderState {}

class AudioPlayerStopped extends AudioRecorderState {}
