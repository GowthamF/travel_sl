import 'package:flutter/material.dart';
import 'package:travel_sl/homemenu.dart';
import 'package:travel_sl/homephoto.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'travelSL',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          children: <Widget>[
            HomePagePhoto(),
            HomeMenu(),
          ],
        ),
      ),
    );
  }
}
