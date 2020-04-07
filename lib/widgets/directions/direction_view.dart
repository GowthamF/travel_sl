import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/autosuggest_api_client.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/widgets.dart';

class DirectionView extends StatefulWidget {
  final LatLng selectedLocation;

  DirectionView({this.selectedLocation});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DirectionView();
  }
}

class _DirectionView extends State<DirectionView> {
  CurrentLocationBloc currentLocationBloc;
  singleton.Location _location = singleton.Location.getInstance();
  singleton.RoutesSingleTon _routesSingleTon =
      singleton.RoutesSingleTon.getInstance();
  TextEditingController currentLocationController;
  TextEditingController destinationController;
  PlaceAutoSuggestBloc placeAutoSuggestBloc;
  RouteBloc routeBloc;
  List<AutoSuggestPlace> autoSuggestPlaces = [];
  GlobalKey<AutoCompleteTextFieldState<AutoSuggestPlace>> originKey =
      GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<AutoSuggestPlace>> destinationKey =
      GlobalKey();
  String originPlaceId = '';
  String destinationPlaceId = '';
  bool isCurrentLocationAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocationController = TextEditingController();
    destinationController = TextEditingController();
    placeAutoSuggestBloc = BlocProvider.of<PlaceAutoSuggestBloc>(context);
    routeBloc = BlocProvider.of<RouteBloc>(context);

    if (widget.selectedLocation == null) {
      currentLocationBloc = BlocProvider.of<CurrentLocationBloc>(context);
      currentLocationBloc.add(GetCurrentLocation());
    } else {
      currentLocationController.text = '${widget.selectedLocation}';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        if (state is CurrentLocationLoaded) {
          _location.currentLocation = state.position;
          currentLocationController.text = 'Current Location';
          isCurrentLocationAvailable = true;
          autoSuggestPlaces.add(
            AutoSuggestPlace(
                placeFormatting: PlaceFormatting(
                  mainText: 'Current Location',
                ),
                placeId:
                    '${_location.currentLocation.latitude},${_location.currentLocation.longitude}'),
          );

          originPlaceId =
              '${_location.currentLocation.latitude},${_location.currentLocation.longitude}';
        }
      },
      child: BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Form(
                  child:
                      BlocListener<PlaceAutoSuggestBloc, PlaceAutoSuggestState>(
                    listener: (context, state) {
                      if (state is PlaceAutoSuggestLoaded) {
                        setState(
                          () {
                            originKey.currentState
                                .updateSuggestions(state.autoSuggestions);
                          },
                        );
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.only(left: 15, top: 15),
                                  child:
                                      AutoCompleteTextField<AutoSuggestPlace>(
                                    clearOnSubmit: false,
                                    submitOnSuggestionTap: true,
                                    controller: currentLocationController,
                                    textChanged: (value) {
                                      if (value.isNotEmpty) {
                                        placeAutoSuggestBloc.add(
                                          GetAutoSuggestions(
                                              input: value,
                                              location:
                                                  '${_location.currentLocation.latitude},${_location.currentLocation.longitude}',
                                              isOrigin: true),
                                        );
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Choose Starting Place",
                                    ),
                                    itemSubmitted: (item) {
                                      setState(
                                        () => {
                                          currentLocationController.text =
                                              item.placeFormatting.mainText,
                                          if (isCurrentLocationAvailable)
                                            {
                                              originPlaceId = item.placeId,
                                            }
                                          else
                                            {
                                              originPlaceId =
                                                  'place_id:${item.placeId}',
                                            }
                                        },
                                      );
                                      if (originPlaceId.isNotEmpty &&
                                          destinationPlaceId.isNotEmpty) {
                                        getDirections(
                                            originPlaceId, destinationPlaceId);
                                      }
                                    },
                                    key: originKey,
                                    suggestions: autoSuggestPlaces,
                                    itemBuilder: (context, suggestion) =>
                                        Padding(
                                            child: ListTile(
                                              title: Text(suggestion
                                                  .placeFormatting.mainText),
                                            ),
                                            padding: EdgeInsets.all(8.0)),
                                    itemSorter: (a, b) => (a
                                        .placeFormatting.mainText
                                        .compareTo(b.placeFormatting.mainText)),
                                    itemFilter: (suggestion, input) =>
                                        suggestion.placeFormatting.mainText
                                            .toLowerCase()
                                            .startsWith(input.toLowerCase()),
                                  ),
                                )),
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      if (isCurrentLocationAvailable) {
                                        isCurrentLocationAvailable = false;
                                      }
                                      originKey.currentState.clear();
                                      originPlaceId = '';
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  child:
                      BlocListener<PlaceAutoSuggestBloc, PlaceAutoSuggestState>(
                    listener: (context, state) {
                      if (state is PlaceAutoSuggestLoaded) {
                        setState(() {
                          destinationKey.currentState
                              .updateSuggestions(state.autoSuggestions);
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child:
                                      AutoCompleteTextField<AutoSuggestPlace>(
                                    clearOnSubmit: false,
                                    submitOnSuggestionTap: true,
                                    controller: destinationController,
                                    textChanged: (value) {
                                      if (value.isNotEmpty) {
                                        placeAutoSuggestBloc.add(
                                          GetAutoSuggestions(
                                              input: value,
                                              location:
                                                  '${_location.currentLocation.latitude},${_location.currentLocation.longitude}',
                                              isOrigin: false),
                                        );
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Choose Destination Place",
                                    ),
                                    itemSubmitted: (item) {
                                      setState(
                                        () => {
                                          destinationController.text =
                                              item.placeFormatting.mainText,
                                          destinationPlaceId =
                                              'place_id:${item.placeId}',
                                        },
                                      );
                                      if (originPlaceId.isNotEmpty &&
                                          destinationPlaceId.isNotEmpty) {
                                        getDirections(
                                            originPlaceId, destinationPlaceId);
                                      }
                                    },
                                    key: destinationKey,
                                    suggestions: autoSuggestPlaces,
                                    itemBuilder: (context, suggestion) =>
                                        Padding(
                                            child: ListTile(
                                              title: Text(suggestion
                                                  .placeFormatting.mainText),
                                            ),
                                            padding: EdgeInsets.all(8.0)),
                                    itemSorter: (a, b) => (a
                                        .placeFormatting.mainText
                                        .compareTo(b.placeFormatting.mainText)),
                                    itemFilter: (suggestion, input) =>
                                        suggestion.placeFormatting.mainText
                                            .toLowerCase()
                                            .startsWith(input.toLowerCase()),
                                  ),
                                )),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      destinationController.clear();
                                      destinationPlaceId = '';
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<RouteBloc, RouteState>(
                    builder: (context, state) {
                      if (state is RouteLoaded) {
                        return DirectionsMenu(
                          drivingRoutes: state.drivingRoutes,
                          transitRoutes: state.transitRoutes,
                        );
                      }
                      if (state is RouteLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void getDirections(String origin, String destination) {
    routeBloc.add(
        GetRoute(origin: origin, destination: destination, mode: 'transit'));
  }
}
