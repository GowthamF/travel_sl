import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:travel_sl/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;

import 'widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final RouteRepository routeRepository = RouteRepository();

  runApp(Main(
    routeRepository: routeRepository,
  ));
}

class Main extends StatelessWidget {
  final RouteRepository routeRepository;
  Main({Key key, this.routeRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: NavigationRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RouteBloc(),
        child: Home(
          routeRepository: routeRepository,
        ),
      ),
    );
  }
}
