enum Region {
  north,
  south,
  east,
  west,
  centre,
  portLouis,
}

class Location {
  final double lat;
  final double lng;
  final String address;
  final Region region;

  Location({
    required this.lat,
    required this.lng,
    required this.address,
    required this.region,
  });

  String get coordinates => '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';

  String getRegionName() {
    switch (region) {
      case Region.north:
        return 'North';
      case Region.south:
        return 'South';
      case Region.east:
        return 'East';
      case Region.west:
        return 'West';
      case Region.centre:
        return 'Centre';
      case Region.portLouis:
        return 'Port Louis';
    }
  }
}