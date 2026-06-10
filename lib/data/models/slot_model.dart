class SlotModel {
  final String time;
  final bool booked;

  SlotModel({required this.time, required this.booked});

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(time: json['time'], booked: json['booked'] ?? false);
  }
}
