import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';

class GetBusCurrentLocationBloc
    extends Bloc<GetBusCurrentLocationEvent, GetBusCurrentLocationState> {
  final db = Firestore.instance;

  StreamSubscription<DocumentSnapshot> _fireBaseSubscription;

  @override
  GetBusCurrentLocationState get initialState => GetBusCurrentLocationEmpty();

  @override
  Stream<GetBusCurrentLocationState> mapEventToState(
      GetBusCurrentLocationEvent event) async* {
    if (event is StartGetBusCurrentLocation) {
      yield GetBusCurrentLocationLoading();
      _fireBaseSubscription?.cancel();
      _fireBaseSubscription = db
          .collection('busLocation')
          .document('currentLocation')
          .snapshots()
          .listen((onData) =>
              add(GetBusCurrentLocation(geoPoint: onData.data['location'])));
    }

    if (event is GetBusCurrentLocation) {
      yield GetBusCurrentLocationLoaded(geoPoint: event.geoPoint);
    }
  }

  @override
  Future<void> close() {
    _fireBaseSubscription?.cancel();
    return super.close();
  }
}
