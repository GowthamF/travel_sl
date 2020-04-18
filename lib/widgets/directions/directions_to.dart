import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/widgets.dart';

class DirectionsTo extends StatefulWidget {
  DirectionsTo();

  @override
  State<StatefulWidget> createState() {
    return _DirectionsTo();
  }
}

class _DirectionsTo extends State<DirectionsTo> {
  List<AutoSuggestPlace> list = [];

  PlaceAutoSuggestBloc placeAutoSuggestBloc;
  singleton.Location _location = singleton.Location.getInstance();
  singleton.PlacesSingleTon _placeSingleton =
      singleton.PlacesSingleTon.getInstance();

  @override
  void initState() {
    super.initState();
    placeAutoSuggestBloc = BlocProvider.of<PlaceAutoSuggestBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Leave To'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 50,
              child: TextFormField(
                onChanged: (value) {
                  placeAutoSuggestBloc.add(GetAutoSuggestions(
                    input: value,
                    location:
                        '${_location.currentLocation.latitude},${_location.currentLocation.longitude}',
                  ));
                },
                style: TextStyle(fontSize: 15),
                autovalidate: true,
                decoration: InputDecoration(
                  focusColor: Colors.blue[500],
                  fillColor: Colors.blue[800],
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Leave To',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
                ),
              ),
            ),
            Expanded(
                child:
                    BlocConsumer<PlaceAutoSuggestBloc, PlaceAutoSuggestState>(
                        builder: (c, s) {
              if (s is PlaceAutoSuggestEmpty) {
                return Container(
                    child: Center(
                  child: Text('Enter Something'),
                ));
              }

              if (s is PlaceAutoSuggestLoaded) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Wrap(
                            spacing: 10,
                            children: <Widget>[
                              list[index].placeIcon,
                              Text(
                                list[index].placeFormatting.mainText,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          subtitle: index == 0
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.only(left: 35),
                                  child: Text(list[index].description),
                                ),
                          onTap: () {
                            _placeSingleton.selectedDestination =
                                DirectionPlace(
                                    location: 'place_id:${list[index].placeId}',
                                    showName:
                                        list[index].placeFormatting.mainText);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider<RouteBloc>(
                                  create: (context) => RouteBloc(),
                                  child: DirectionView(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: list.length,
                );
              }
              return Align(
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(),
              );
            }, listener: (c, s) {
              if (s is PlaceAutoSuggestLoaded) {
                list.clear();
                list.addAll(s.autoSuggestions);
              }
            })),
          ],
        ),
      ),
    ));
  }
}
