import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';

class HelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static Color getOrderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.green;
      case OrderStatus.delivered:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) => DateFormat(format).format(date);

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static DateTime getStartOfWeek(DateTime date) {
    final int dayUntilMonday = date.weekday - 1;
    final DateTime startOfWeek = date.subtract(Duration(days: dayUntilMonday));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  // isEmpty function
  static bool isEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  //  isNotEmpty function
  static bool isNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  // extract status from string
  static OrderStatus? orderStatusFromString(String status) {
    return OrderStatus.values.firstWhere(
      (e) => e.toString() == status,
      orElse: () => OrderStatus.processing, // fallback
    );
  }

  static PaymentMethods? getPaymentMethod(String paymentMethod) {
    // Master Card >> masterCard
    final paymentName = lowerFirstAndRemoveSpaces(paymentMethod);
    return PaymentMethods.values.firstWhere(
      (element) => element.name == paymentName,
      orElse: () => PaymentMethods.paypal,
    );
  }

  static String getPaymentIcon(PaymentMethods paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethods.paypal:
        return 'assets/icons/payment_methods/paypal.png';
      case PaymentMethods.googlePay:
        return 'assets/icons/payment_methods/google_pay.png';
      case PaymentMethods.applePay:
        return 'assets/icons/payment_methods/apple_pay.png';
      case PaymentMethods.visa:
        return 'assets/icons/payment_methods/visa.png';
      case PaymentMethods.masterCard:
        return 'assets/icons/payment_methods/mastercard.png';
      case PaymentMethods.creditCard:
        return 'assets/icons/payment_methods/credit_card.png';
      case PaymentMethods.paystack:
        return 'assets/icons/payment_methods/paystack.png';
      case PaymentMethods.razorPay:
        return 'assets/icons/payment_methods/razorpay.png';
      case PaymentMethods.paytm:
        return 'assets/icons/payment_methods/paytm.png';
    }
  }

  static String getPaymentIconPath(String paymentMethod) {
    final payment = getPaymentMethod(paymentMethod);
    return getPaymentIcon(payment ?? PaymentMethods.paypal);
  }

  static String lowerFirstAndRemoveSpaces(String text) {
    final words = text[0].toLowerCase() + text.substring(1);
    return words.replaceAll(' ', '');
  }

  static String upperCaseFirst(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
