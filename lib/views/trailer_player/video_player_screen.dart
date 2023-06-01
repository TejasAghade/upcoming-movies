import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upcoming_movies/utils/shared/spacings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  String videoKey;
  VideoPlayerScreen({super.key, required this.videoKey});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController controller;

  int duration = 0;

  @override
  void initState() {
    log(widget.videoKey);

    String url = "https://www.youtube.com/watch?v=eT_UrX1gHt8";

    log(url);
    controller = YoutubePlayerController(
        initialVideoId: widget.videoKey,

        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: true,
          
        ));
    controller.toggleFullScreenMode();
    super.initState();

    Future.delayed(Duration(seconds: controller.metadata.duration.inSeconds), () {
      exitFullScreenMode();
      // Navigator.pop(context);
    });
  }

  void enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void exitFullScreenMode(){
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          

  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller, onEnded: (metaData) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

          // Navigator.pop(context);
      },),
      builder: (context, player) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height10,
                    Text(
                      controller.metadata.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    height10,
                    height10,
                    Text(
                      "Author : ${controller.metadata.author}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          )),
        );
      },
      // ),
    );
  }
}
