import 'package:bloc/bloc.dart';
import 'package:bloc_00/bloc_logger.dart';

import 'package:bloc_00/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  print("App init");
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
  late final CounterBloc _counter;

  @override
  void initState() {
    super.initState();

    // Bloc.observer = BlocLogger(ctx: context);
    _counter = CounterBloc(ctx: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // change
            ElevatedButton(
              child: Text('slowrise'),
              onPressed: () => _counter.add(CounterSlowRise(to: 3)),
            ),
            ElevatedButton(
              child: Text('error'),
              onPressed: () => _counter.add(CounterErrorEvent()),
            ),
            Divider(thickness: 2),

            // watch
            BlocBuilder<CounterBloc, int>(
              bloc: _counter,
              builder: (ctx, state) => Text('counter: $state'),
            ),
          ],
        ),
      ),
    );
  }
}
