import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 50,
              child: TextFormField(
                style: TextStyle(fontSize: 15),
                autovalidate: true,
                decoration: InputDecoration(
                  focusColor: Colors.blue[500],
                  fillColor: Colors.blue[800],
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Search',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                ),
              ),
            ),
          ],
        ),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
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
        CustomScrollView(
          shrinkWrap: true,
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.all(20.0),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10.0,
                crossAxisCount: 3,
                children: <Widget>[
                  Text('He\'d have you all unravel at the'),
                  Text('Heed not the rabble'),
                  Text('Sound of screams but the'),
                  Text('Who scream'),
                  Text('Revolution is coming...'),
                  Text('Revolution, they...'),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
