import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoggleMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GMap();
  }
}

class _GMap extends State<GoggleMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polyline = {};
  List<LatLng> latlng = List();
  List<PointLatLng> result;
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.9345573, 79.8512368),
    zoom: 15.75,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    // _polyline.add(Polyline(polylineId: PolylineId('1'), points: latlng));
    // TODO: implement build
    return GoogleMap(
      onTap: (latlng) {
        print(latlng);
      },
      polylines: _polyline,
      initialCameraPosition: _kGooglePlex,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  void getCoordinates() async {
    PolylinePoints polylinePoints = PolylinePoints();
    var results =
        polylinePoints.decodePolyline('kjii@i}jfNDNJb@Jb@Jj@@L@RBT?V?`@');

    List<LatLng> _ppp = [];

    // polylineCoordinates.add(LatLng(6.934054100000001, 79.8500248));

    // results.addAll(polylinePoints.decodePolyline('exci@elkfNl@^'));
    // results.addAll(polylinePoints.decodePolyline(
    //     '{whi@_fifNBDDBBD@Dp@Af@CPAXGXIJCbASp@Ov@Oz@Up@Or@W^Op@g@RQFILMFILOPSDEFGLMBCJGNMPMJGHEJG@AFIDCFCFCXINGPEb@K`@Kb@Kb@KPGbAStDy@n@Oj@OTGxBs@XIFCXIDC`@K`@K`@KXIFA`@MLCVI`@K`@K`@M`@K@?^KLE`@KFC?A?A?A@A?A@A?A@ABCBABAB?BA@@B?@@@@B@h@MvAWr@Of@KNCv@SbAUl@Qf@MnBg@PEp@SbBa@HCnBg@z@SpAYjBa@@?`@KfCk@n@O`AUFA`@I^GLCb@K`@K@?`@K`@KNCt@Q~Bg@RGFEFEBG@E@G?CCOSo@?SCEk@eCCIEO'));
    // results.addAll(polylinePoints.decodePolyline(
    //     'o_ei@_|jfNBa@@G@KDIDGDGDEFCFCr@SvD_ApAc@tBm@v@UrCk@xEiAB?BAzCg@LCx@UHClCk@'));

    // var rrrs = polylinePoints.decodePolyline(
    //     'ggii@kujfNBaBQeAQk@a@q@Id@ETJb@Lx@Dh@A`BQ~FDpAXxCLn@\\l@hA`A`BhA`Af@bAb@lAn@|@z@N\\@|CLxHBv@BNBDHH@Dp@Ax@Er@QxDw@lBe@rAg@dAy@TWl@s@d@a@v@i@LILMx@YzBi@nHaBzA_@nC{@`A[~Bm@vEoApA]FGBIHGLAJD|EaAxD_AzEoAxGaB`FgA`GsArBa@`IiBNKDM@KW_ACYo@oCEOBa@BSV_@NGjFsAfEqAjEaA|EiA~Ci@~EiA');

    // rrrs.forEach((PointLatLng point) {
    //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    // });

    // Polyline polyline1 = Polyline(
    //     consumeTapEvents: true,
    //     onTap: () {
    //       setState(() {});
    //     },
    //     polylineId: PolylineId("poly"),
    //     color: Colors.blue,
    //     points: polylineCoordinates);

    result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyB-ZaS-W7kKVaDRu61Oqm7lTaOUTjd8T3o',
        6.933631546201688,
        79.84993167221546,
        6.9111014766863885,
        79.84824791550636);

    if (result.isNotEmpty) {
      results.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        consumeTapEvents: true,
        onTap: () {
          setState(() {
            print(id);

            print(results);
          });
        },
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates);
    _polyline.add(polyline);

    _polyline.add(Polyline(polylineId: PolylineId('Poly1'), points: _ppp));
    // _polyline.add(polyline1);
    setState(() {});
    print(result);
  }
}
