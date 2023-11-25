class Geolocation {
  final double latitude;
  final double longitude;
  final String address;

  Geolocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}
