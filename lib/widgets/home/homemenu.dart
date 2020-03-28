import 'package:flutter/material.dart';
import 'package:travel_sl/widgets/widgets.dart';

class HomeMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeMenu();
  }
}

class _HomeMenu extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomScrollView(
          shrinkWrap: true,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(20.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 1.0,
                crossAxisCount: 3,
                mainAxisSpacing: 1.0,
                children: <Widget>[
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black12, width: 0.5)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GMap(NavigationRoutes.home)));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.map),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Map'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black12, width: 0.5)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Directions()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.directions),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Directions'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black12, width: 0.5)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Buses()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.directions_bus),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Buses'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black12, width: 0.5)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Places()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.business),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Malls'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black12, width: 0.5)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Trains()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.directions_railway),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Trains'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black12, width: 0.5)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Translator()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.g_translate),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Translator'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
