import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: Scaffold(
      backgroundColor: Colors.black,
      body: App(),
    ),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ChewieController? _ctrl;

  Future<void> loadChew() async {
    final videoPlayerController = VideoPlayerController.network('https://plasmoxy.me/laslo.mp4');

    _ctrl = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      autoInitialize: true,
      customControls: Padding(
        padding: EdgeInsets.all(20),
        child: CupertinoControls(
          backgroundColor: Colors.transparent,
          iconColor: Colors.white,
        ),
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    loadChew();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _ctrl != null
          ? Chewie(
              controller: _ctrl!,
            )
          : Text("loading..."),
    );
  }
}
