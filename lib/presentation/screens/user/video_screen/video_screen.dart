// video_screen.dart
import 'package:edumaster/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../business_logic/video_cubit/video_cubit.dart';
import '../../../../data/local/args.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/flat_button.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, this.arguments});

  final ScreenArguments? arguments;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VideoCubit()..initializeController(arguments!.message),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          final VideoCubit videoCubit = context.read<VideoCubit>();

          return Scaffold(
            backgroundColor: AppColor.black,
            appBar: videoCubit.controller.value.isFullScreen
                ? const CustomAppBar(
                    appBarWidget: SizedBox(),
                  )
                : CustomAppBar(
                    appBarWidget: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              height: 40.0,
                              width: 40.0,
                              child: FlatButton(
                                onPressed: (){
                                    Navigator.pop(context);
                                },
                                tOrI: false,
                                icon: Icons.arrow_back_ios,
                                radius: 50.0,
                                height: 5.0,
                                minWidth: 5.0,
                                iconSize: 15.0,
                                iconColor: AppColor.roseMadder,
                                color: AppColor.white,
                                elevation: 0.0,
                                iconWidgetState: false,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              height: 35.0,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    arguments!.title,
                                    style: const TextStyle(
                                      fontFamily: 'cairo',
                                      color: AppColor.indigoDye,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
            body: Center(
              child: YoutubePlayerBuilder(
                onExitFullScreen: () => SystemChrome.setPreferredOrientations(
                    DeviceOrientation.portraitUp as List<DeviceOrientation>),
                onEnterFullScreen: () => SystemChrome.setPreferredOrientations(
                    DeviceOrientation.landscapeRight
                        as List<DeviceOrientation>),
                player: YoutubePlayer(
                  controller: videoCubit.controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  topActions: <Widget>[
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        videoCubit.controller.metadata.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                  onReady: () {
                    // videoCubit.controller.addListener(videoCubit.listener);
                  },
                  onEnded: (data) {},
                ),
                builder: (context, player) => player,
              ),
            ),
          );
        },
      ),
    );
  }
}
