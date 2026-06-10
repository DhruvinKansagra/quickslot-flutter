class VenueModel {
  final String id;
  final String name;
  final String location;

  VenueModel({required this.id, required this.name, required this.location});

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
    );
  }
}
