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
      home: BlocProvider(
        lazy: false,
        create: (ctx) => CounterBloc(ctx: ctx),
        child: HomePage(title: 'Yo'),
      ),
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
  @override
  Widget build(BuildContext context) {
    // dependency injection
    final _counter = BlocProvider.of<CounterBloc>(context);

    return BlocListener<CounterBloc, int>(
      listener: (ctx, state) {
        print("Home page listened to state change to $state !");
      },
      child: Scaffold(
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
      ),
    );
  }
}
