import 'package:flutter/material.dart';
import 'package:travel_sl/home/homemenu.dart';
import 'package:travel_sl/home/homepagephoto.dart';
import 'package:travel_sl/home/homesearchbar.dart';

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
    _scrollController = ScrollController(initialScrollOffset: 5);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'travelSL',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    bottom: HomeSearchBar(),
                    backgroundColor: Colors.white,
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    forceElevated: innerBoxIsScrolled,
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            top: false,
            bottom: false,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: <Widget>[
                  HomePagePhoto(),
                  HomeMenu(),
                  HomePagePhoto(),
                  HomeMenu()
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _scrollController.animateTo(100 + _scrollController.offset,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }),
    );
  }
}
