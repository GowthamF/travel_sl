class BusViewData {
  static final BusViewData _busViewData = BusViewData._internal();

  BusViewData._internal();

  static BusViewData getInstance() => _busViewData;

  List<BusData> busData = [
    BusData(
        id: 1,
        busNumber: '87',
        route: 'Fort - Chillaw - Puttalam - Anuradhapura - Jaffna/Vavuniya',
        routeName: 'Colombo - Jaffna'),
    BusData(
        id: 2,
        busNumber: '100',
        route:
            'Fort - Galle face - Kollupitiya - Bambalapitiya - Wellawatta  - Dehiwala - Galkissa - Ratmalana - Moratuwa - Keselwatta - Old galle road - Walana - Panadura',
        routeName: 'Pettah – Moratuwa / Panadura'),
    BusData(
        id: 3,
        busNumber: '101',
        route:
            'Fort - Lake house - Slave island - Kollupitiya - Bambalapitiya - Wellawatta - Dehiwala - Galkissa - Ratmalana - Katubedda',
        routeName: 'Colombo – Moratuwa'),
    BusData(
        id: 1,
        busNumber: '120',
        route:
            'Fort - Lake house - D.R.Wijewardana road - Gamini hall junction - T.B.Jaya Mawatha - Ibbanwala junction - Town hall - Reid avenue - Thummula - Thimbirigasaya junction - Havelock town - Pamankada - Dutugemunu street - Kohuwala - Pepiliyana - Rattanapitiya - Boralesgamuwa - Piliyandala - Kesbewa - Kahatuduwa - Gonapola - Pokunuwita - Horana ',
        routeName: 'Pettah – Horana')
  ];
}

class BusData {
  final int id;
  final String busNumber;
  final String routeName;
  final String route;

  BusData({this.id, this.routeName, this.route, this.busNumber});
}
