part of 'order.dart';

class DeliveryInfo {
  final String address;
  final DateTime date;

  DeliveryInfo({required this.address, required this.date});

  factory DeliveryInfo.fromMap(Map<String, dynamic> map) {
    return DeliveryInfo(
      address: map['address'],
      date: map['date'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'date': date,
    };
  }
}
