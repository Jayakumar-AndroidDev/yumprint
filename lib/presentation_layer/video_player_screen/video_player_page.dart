import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _videoPlayer;
  //late Pla

  @override
  void initState() {
    print('video_url: ${widget.videoUrl}');
    final videoKey = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoKey != null) {
      _videoPlayer = YoutubePlayerController(initialVideoId: videoKey!)
        ..addListener(() {
          //playerState = _controller.value.playerState;
        });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (YoutubePlayer.convertUrlToId(widget.videoUrl) == null) {
      return Scaffold(
         appBar: AppBar(
          title: const Text(
            'Video Player',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Lottie.asset('image/404_error.json', width: 150, height: 150),
              const SizedBox(height: 5),
              const TextComponent(
                text: 'Something Went Wrong Please Try Again Later.',
                textSize: 15,
                textColor: Colors.orange,
                textAlign: Alignment.center,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      );
    }
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _videoPlayer,
        onReady: () => _videoPlayer.addListener(() {}),
      ),
      builder: (build, player) => player,
    );
  }

  @override
  void dispose() {
    _videoPlayer.dispose();
    super.dispose();
  }
}
