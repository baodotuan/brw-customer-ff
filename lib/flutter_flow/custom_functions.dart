import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import '../../auth/auth_util.dart';

String getFullName(
  String lastName,
  String firstName,
) {
  // Add your function code here!
  return lastName + ' ' + firstName;
}

bool missingData(UsersRecord user) {
  // Add your function code here!
  if ([null, ''].contains(user.firstName) ||
      [null, ''].contains(user.lastName)) {
    return true;
  } else {
    return false;
  }
}

String getShortName(UsersRecord user) {
  // Add your function code here!
  return (user.lastName[0] + user.firstName[0]);
}

String capitalize(String input) {
  // Add your function code here!
  return input.toUpperCase();
}

int addSubstractTotalPrice(
  int price,
  int quantity,
  int initialTotal,
  bool addToCart,
) {
  // Add your function code here!
  if (addToCart) {
    return (initialTotal + price * quantity);
  } else {
    return (initialTotal - price * quantity);
  }
}

DateTime add15min(DateTime currentTime) {
  // Add your function code here!
  return currentTime.add(const Duration(days: 0, hours: 0, minutes: 15));
}

int totalQantityOfOrderitems(List<OrderItemsRecord> docs) {
  // Add your function code here!
  var maxIndex = docs.length - 1;
  var total = 0;
  for (var i = 0; i <= maxIndex; i++) {
    total += docs[i].quantity;
  }

  return total;
}

int totalAmountOfOrderitems(List<OrderItemsRecord> docs) {
  // Add your function code here!
  var maxIndex = docs.length - 1;
  var total = 0;
  for (var i = 0; i <= maxIndex; i++) {
    total += docs[i].amount;
  }

  return total;
}

int multiplyTwoInterger(
  int input1,
  int input2,
) {
  // Add your function code here!
  return input1 * input2;
}

int addOrSubstractTwoInterger(
  int input1,
  int input2,
  bool add,
) {
  // Add your function code here!
  if (add) {
    return input1 + input2;
  } else {
    return input1 - input2;
  }
}
