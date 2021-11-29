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
  if (user.firstName == '') {
    return true;
  }
  ;
  if (user.lastName == '') {
    return true;
  }
  ;
  return false;
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
