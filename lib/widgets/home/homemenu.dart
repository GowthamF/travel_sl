import 'package:flutter/material.dart';
import 'package:travel_sl/widgets/widgets.dart';

class HomeMenu extends StatefulWidget {
  HomeMenu();
  @override
  State<StatefulWidget> createState() {
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
                          Navigator.pushNamed(context, NavigationRoutes.map,
                              arguments: NavigationRoutes.home);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.map,
                              color: Color(0xFFF9A825),
                            ),
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
                          Navigator.pushNamed(
                              context, NavigationRoutes.directions);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.directions,
                              color: Color(0xFF00c853),
                            ),
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
                          Navigator.pushNamed(context, NavigationRoutes.buses);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.directions_bus,
                              color: Color(0xFF80deea),
                            ),
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
                        onPressed: null,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.local_taxi,
                              color: Color(0xFF80deea),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Taxi'),
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
                          Navigator.pushNamed(context, NavigationRoutes.trains);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.directions_railway,
                              color: Color(0xFFbf360c),
                            ),
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
                          Navigator.pushNamed(
                              context, NavigationRoutes.translator);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.g_translate,
                              color: Color(0xFF2196f3),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Translator'),
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
                        onPressed: null,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.airline_seat_recline_normal,
                              color: Color(0xFF9c27b0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text('Seat Booking'),
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
