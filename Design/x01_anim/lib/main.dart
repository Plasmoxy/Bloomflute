import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomoste nam',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.tealAccent,
        textTheme: GoogleFonts.comfortaaTextTheme(),
      ),
      home: HomePage(title: 'Pomoste nam'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double hejt = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(seconds: 2), (timer) async {
      setState(() {
        hejt = hejt == 0 ? 20 : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(seconds: 2),
                height: hejt,
                curve: Curves.easeInOut,
              ),
              Text(
                'DOPICI.js',
                style: TextStyle(
                  color: Colors.purpleAccent[400],
                  fontSize: 80,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              Text(
                'Moja zena je gay',
                style: TextStyle(
                  color: Colors.purple[100],
                  fontSize: 30,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SvgPicture.asset(
                'assets/undraw_happy_women_day_fbjt.svg',
                height: 400,
              ),
              SizedBox(height: 30),
              Text(
                'Novi javaskripp frejmvork pre homoseks',
                style: TextStyle(
                  color: Colors.purple[100],
                  fontSize: 20,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(0, 3),
                      blurRadius: 4.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
