part of 'order.dart';

enum OrderStatus {
  processing,
  approved,
  canceled,
  delivered,
}

extension OrderStatusExtension on OrderStatus {
  static const processingString = 'В обработке';
  static const approvedString = 'Подтверждён';
  static const canceledString = 'Отменён';
  static const deliveredString = 'Доставлен';

  static OrderStatus parse(String value) {
    switch (value) {
      case processingString:
        return OrderStatus.processing;
      case approvedString:
        return OrderStatus.approved;
      case canceledString:
        return OrderStatus.canceled;
      case deliveredString:
        return OrderStatus.delivered;
      default:
        throw FormatException('$value is invalid value for OrderStatus');
    }
  }

  String get stringValue {
    switch (this) {
      case OrderStatus.processing:
        return processingString;
      case OrderStatus.approved:
        return approvedString;
      case OrderStatus.canceled:
        return canceledString;
      case OrderStatus.delivered:
        return deliveredString;
    }
  }
}
