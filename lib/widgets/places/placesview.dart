import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class PlacesView extends StatefulWidget {
  final LatLng selectedLocation;
  final String address;

  PlacesView({this.selectedLocation, this.address});

  @override
  State<StatefulWidget> createState() {
    return _PlaceView();
  }
}

class _PlaceView extends State<PlacesView> {
  String imageUrl = '';
  PlacesSingleTon _placesSingleTon = PlacesSingleTon.getInstance();

  @override
  void initState() {
    super.initState();
    imageUrl =
        '${Constants.baseUrl}/api/staticmap?center=${widget.selectedLocation.latitude},${widget.selectedLocation.longitude}&zoom=18&size=9000x400&key=${Constants.apiKey}&maptype=roadmap&markers=color:black|label:Se|${widget.selectedLocation.latitude},${widget.selectedLocation.longitude}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Place View'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: null,
                icon: Icon(Icons.home),
                label: Text('Set As Home'))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            key: UniqueKey(),
            tooltip: 'Directions',
            onPressed: () {
              _placesSingleTon.selectedOrigin = DirectionPlace(
                  location:
                      '${widget.selectedLocation.latitude},${widget.selectedLocation.longitude}',
                  showName: widget.address);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<PlaceAutoSuggestBloc>(
                    create: (context) => PlaceAutoSuggestBloc(),
                    child: DirectionsTo(),
                  ),
                ),
              );
            },
            child: Icon(Icons.directions)),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(imageUrl),
          ],
        ),
      ),
    );
  }
}
