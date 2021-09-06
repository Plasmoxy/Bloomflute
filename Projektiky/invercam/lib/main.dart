import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as IMG;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Ensure plugin services are initialized
  final cameras = await availableCameras(); //Get list of available cameras
  runApp(App(cameras: cameras));
}

class App extends StatelessWidget {
  final List<CameraDescription> cameras;
  final aspectV = ValueNotifier<double>(0.5625);

  App({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(),
      debugShowCheckedModeBanner: false,
      home: MainPage(
        cameras: cameras,
        aspectV: aspectV,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final ValueNotifier<double> aspectV;

  MainPage({
    Key? key,
    required this.cameras,
    required this.aspectV,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CameraController? _ctrl;
  int selectedCam = 0;
  List<File> capturedImages = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      _ctrl = CameraController(
        widget.cameras[selectedCam],
        ResolutionPreset.ultraHigh,
      );

      await _ctrl!.initialize();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _ctrl == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationX(pi),
                          child: ValueListenableBuilder<double>(
                            valueListenable: widget.aspectV,
                            builder: (ctx, asp, w) => AspectRatio(
                              aspectRatio: asp,
                              child: CameraPreview(
                                _ctrl!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AppSettings(
                            aspectV: widget.aspectV,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera,
                      size: 50,
                    ),
                    onPressed: () async {
                      // CAPTURE
                      if (_ctrl == null) return;
                      var xFile = await _ctrl!.takePicture();

                      File file = File(xFile.path);

                      IMG.Image image = IMG.decodeJpg(await file.readAsBytes());
                      IMG.Image flipped = IMG.flipHorizontal(image);
                      await file.writeAsBytes(IMG.encodeJpg(flipped));

                      final result = await ImageGallerySaver.saveFile(file.path);
                      setState(() {
                        capturedImages.add(File(file.path));
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${result}'),
                        ),
                      );
                      print(result);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.photo_album,
                      size: 50,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppSettings extends StatefulWidget {
  final ValueNotifier<double> aspectV;

  AppSettings({
    Key? key,
    required this.aspectV,
  }) : super(key: key);

  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  final aspectC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: aspectC,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Aspect',
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.aspectV.value = double.tryParse(aspectC.text) ?? 4 / 3;
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
