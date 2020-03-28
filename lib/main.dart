import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:travel_sl/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;

import 'widgets/widgets.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(Main());
}

class Main extends StatelessWidget {
  Main({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}
