class TrainViewData {
  static final TrainViewData _trainViewData = TrainViewData._internal();

  TrainViewData._internal();

  static TrainViewData getInstance() => _trainViewData;

  List<TrainData> trainData = [
    TrainData(
        id: 1,
        route: 'Gampaha Veyangoda Meerigama Rambukkana Kandy',
        routeName: 'Colombo - Kandy'),
    TrainData(
        id: 2,
        route:
            'Mount Panadura Kalutura Aluthgama Ambalangoda Hikkaduwa Galle Mirissa Matara',
        routeName: 'Colombo - Matara'),
  ];
}

class TrainData {
  final int id;
  final String routeName;
  final String route;

  TrainData({this.id, this.routeName, this.route});
}
