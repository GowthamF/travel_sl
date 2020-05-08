import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/busLocationEntering.dart';
import 'package:travel_sl/simple_bloc_delegate.dart';

import 'widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(Main());
}

class Main extends StatelessWidget {
  Main({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: NavigationRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFE57373),
        accentColor: Color(0xFFffcdd2),
        buttonColor: Color(0xFFffa4a2),
      ),
      home: BlocProvider(
        create: (context) => RouteBloc(),
        child: Home(),
      ),
    );
  }
}
