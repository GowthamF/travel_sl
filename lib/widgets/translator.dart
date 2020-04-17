import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/widgets/widgets.dart';

class Translator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Translator'),
          ),
          body: BlocProvider(
            create: (context) => TranslatorBloc(),
            child: TranslatorView(),
          )),
    ));
  }
}
