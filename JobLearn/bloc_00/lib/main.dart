import 'package:bloc/bloc.dart';
import 'package:bloc_00/counter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  print("App init");
  Bloc.observer = BlocLogger();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Yo'),
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
  final _counter = CounterBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // change
            ElevatedButton(
              onPressed: () => setState(() {
                _counter.add(CounterSlowRise(to: 3));
              }),
              child: Text('set'),
            ),
          ],
        ),
      ),
    );
  }
}
