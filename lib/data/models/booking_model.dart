class BookingModel {
  final String id;
  final String date;
  final String slotTime;
  final String venueName;

  BookingModel({
    required this.id,
    required this.date,
    required this.slotTime,
    required this.venueName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      date: json['date'],
      slotTime: json['slotTime'],
      venueName: json['venue']?['name'] ?? '',
    );
  }
}
