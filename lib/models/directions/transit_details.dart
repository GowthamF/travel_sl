import 'package:travel_sl/models/models.dart';

class TransitDetails {
  final Location arrivalStop;
  final Location depatureStop;
  final String transitModeName;
  final String transitModeNumber;
  final String arrivalStopName;
  final String depatureStopName;
  final int numStops;
  final VehicleType vehicleType;

  TransitDetails(
      {this.arrivalStop,
      this.depatureStop,
      this.transitModeName,
      this.transitModeNumber,
      this.arrivalStopName,
      this.depatureStopName,
      this.numStops,
      this.vehicleType});

  factory TransitDetails.fromJson(Map<String, dynamic> json) {
    return TransitDetails(
      arrivalStop: Location.fromJson(json['arrival_stop']['location']),
      depatureStop: Location.fromJson(json['departure_stop']['location']),
      arrivalStopName: json['arrival_stop']['name'],
      depatureStopName: json['departure_stop']['name'],
      transitModeName: json['line']['name'],
      transitModeNumber: json['line']['short_name'],
      numStops: json['num_stops'],
      vehicleType: json['line']['vehicle']['name'] == 'Bus'
          ? VehicleType.Bus
          : json['line']['vehicle']['name'] == 'Train'
              ? VehicleType.Train
              : VehicleType.Driving,
    );
  }
}

enum VehicleType { Train, Bus, Driving }
enum TravelMode { Bus, Train, Driving }
