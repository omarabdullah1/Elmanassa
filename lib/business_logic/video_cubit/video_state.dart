// video_state.dart
part of 'video_cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitialState extends VideoState {}

class VideoPlayingState extends VideoState {
  final bool isPlaying;

  const VideoPlayingState({required this.isPlaying});

  @override
  List<Object> get props => [isPlaying];
}
