import 'package:flutter/material.dart';
import 'package:travel_sl/widgets/widgets.dart';

class Translator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Translator'),
        ),
        body: TranslatorView(),
      ),
    );
  }
}
