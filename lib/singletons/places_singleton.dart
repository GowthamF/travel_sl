import 'package:travel_sl/models/models.dart';

class PlacesSingleTon {
  static final PlacesSingleTon _placesSingleTon = PlacesSingleTon._internal();

  PlacesSingleTon._internal();

  static PlacesSingleTon getInstance() => _placesSingleTon;

  DirectionPlace selectedOrigin;
  DirectionPlace selectedDestination;
}
