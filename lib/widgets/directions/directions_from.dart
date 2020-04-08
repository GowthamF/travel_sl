import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/widgets.dart';

class DirectionsFrom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DirectionsFrom();
  }
}

class _DirectionsFrom extends State<DirectionsFrom> {
  List<AutoSuggestPlace> list = [
    AutoSuggestPlace(
      description: 'Current Location',
      placeFormatting: PlaceFormatting(mainText: 'Current Location'),
      placeIcon: Icon(Icons.my_location),
      isCurrentLocation: true,
    ),
  ];

  PlaceAutoSuggestBloc placeAutoSuggestBloc;
  singleton.Location _location = singleton.Location.getInstance();
  CurrentLocationBloc currentLocationBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placeAutoSuggestBloc = PlaceAutoSuggestBloc();
    currentLocationBloc = BlocProvider.of<CurrentLocationBloc>(context);
    currentLocationBloc.add(GetCurrentLocation());
    placeAutoSuggestBloc.listen((state) {
      if (state is PlaceAutoSuggestLoaded) {
        setState(
          () {
            list.removeWhere((t) => t.isCurrentLocation != true);
            list.addAll(state.autoSuggestions);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Leave From'),
          ),
          body: BlocListener<CurrentLocationBloc, CurrentLocationState>(
              listener: (context, state) {
            if (state is CurrentLocationLoaded) {
              _location.currentLocation = state.position;
            }
          }, child: BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
                  builder: (context, state) {
            if (state is CurrentLocationLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GestureDetector(
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
                        hintText: 'Leave From',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                            top: 0, bottom: 10, left: 10, right: 10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Divider(
                                thickness: 0.5,
                              ),
                              Text(
                                'Recent Searches',
                                style: TextStyle(fontSize: 20),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                            ],
                          );
                        }
                        return Divider();
                      },
                      itemCount: list.length,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DirectionsTo()));
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }))),
    );
  }
}
