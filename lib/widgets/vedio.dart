import 'package:flutter/material.dart';
import 'package:gradproj/theme/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String link;

  const VideoPlayerWidget({Key? key, required this.link}) : super(key: key);
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController? _controller;
  late String id;
  @override
  void initState() {
    super.initState();
    id = YoutubePlayer.convertUrlToId(widget.link)!;
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: kButtonColor,
        progressColors: const ProgressBarColors(
          playedColor: kButtonColor,
          handleColor: kButtonColor,
        ),

      ),
      builder: (BuildContext , player ) {
        return Scaffold(
          body: player,
        );
      },);

  }
}