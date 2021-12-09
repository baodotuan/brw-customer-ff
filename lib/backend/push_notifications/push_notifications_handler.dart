import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../login_page/login_page_widget.dart';
import '../../activation_page/activation_page_widget.dart';
import '../../complete_customer_detail_page/complete_customer_detail_page_widget.dart';
import '../../congrat_page/congrat_page_widget.dart';
import '../../history_page/history_page_widget.dart';
import '../../transaction_detail_page/transaction_detail_page_widget.dart';
import '../../processing_order_page/processing_order_page_widget.dart';
import '../../cart_page/cart_page_widget.dart';
import '../../setting_page/setting_page_widget.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler(
      {Key key, this.handlePushNotification, this.child})
      : super(key: key);

  final Function(BuildContext) handlePushNotification;
  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    setState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Builder(
            builder: (context) => Image.asset(
              'assets/images/app_splash.png',
              fit: BoxFit.cover,
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'LoginPage': (data) async => LoginPageWidget(),
  'ActivationPage': (data) async => ActivationPageWidget(),
  'CompleteCustomerDetailPage': (data) async =>
      CompleteCustomerDetailPageWidget(
        newUser: getParameter(data, 'newUser'),
      ),
  'congratPage': (data) async => CongratPageWidget(),
  'HistoryPage': (data) async => HistoryPageWidget(),
  'TransactionDetailPage': (data) async => TransactionDetailPageWidget(
        url: getParameter(data, 'url'),
        creditBool: getParameter(data, 'creditBool'),
        amount: getParameter(data, 'amount'),
        dateTime: getParameter(data, 'dateTime'),
      ),
  'ProcessingOrderPage': (data) async => ProcessingOrderPageWidget(),
  'OrderPage': (data) async => NavBarPage(initialPage: 'OrderPageWidget'),
  'CartPage': (data) async => CartPageWidget(),
  'SettingPage': (data) async => SettingPageWidget(),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
