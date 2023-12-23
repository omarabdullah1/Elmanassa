// video_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {

  VideoCubit() : super(VideoInitialState());
  // static VideoCubit get(context) => BlocProvider.of(context);
  late YoutubePlayerController controller;

  void initializeController(String url) {
    controller = YoutubePlayerController(
      initialVideoId: extractYouTubeVideoId(url.toString()),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  void playPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    emit(VideoPlayingState(isPlaying: controller.value.isPlaying));
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
  void listener() {
    if (controller.value.isPlaying && !controller.value.isFullScreen) {
      emit(state);
    }
  }
  String extractYouTubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    String videoId = uri.queryParameters['v'] ?? '';

    return videoId;
  }
}
