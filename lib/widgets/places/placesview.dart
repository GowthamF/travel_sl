import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:travel_sl/widgets/widgets.dart';

class PlacesView extends StatefulWidget {
  final LatLng selectedLocation;

  PlacesView({this.selectedLocation});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlaceView();
  }
}

class _PlaceView extends State<PlacesView> {
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl =
        '${Constants.baseUrl}/api/staticmap?center=${widget.selectedLocation.latitude},${widget.selectedLocation.longitude}&zoom=18&size=9000x400&key=${Constants.apiKey}&maptype=roadmap&markers=color:black|label:Se|${widget.selectedLocation.latitude},${widget.selectedLocation.longitude}';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Place View'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(imageUrl),
            RaisedButton(
              onPressed: () {},
              child: Text('Set as Home'),
            ),
            RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Directions(
                        selectedLocation: widget.selectedLocation,
                      ),
                    ),
                  );
                },
                child: Text('Directions'))
          ],
        ),
      ),
    );
  }
}
