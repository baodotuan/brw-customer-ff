import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/edit_item_comp_widget.dart';
import '../components/top_nav_widget.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({
    Key key,
    this.inCartOrder,
  }) : super(key: key);

  final DocumentReference inCartOrder;

  @override
  _CartPageWidgetState createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  DateTime datePicked;
  String dropDownValue;
  TextEditingController textController;
  OrdersRecord createdorder;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrdersRecord>(
      stream: OrdersRecord.getDocument(widget.inCartOrder),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: SpinKitRotatingPlain(
                color: FlutterFlowTheme.primaryColor,
                size: 20,
              ),
            ),
          );
        }
        final cartPageOrdersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.tertiaryColor,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopNavWidget(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Pickup / Delivery',
                              style: FlutterFlowTheme.title3,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: cartPageOrdersRecord.delivery ?? true,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              final ordersUpdateData =
                                                  createOrdersRecordData(
                                                pickup: true,
                                                delivery: false,
                                              );
                                              await widget.inCartOrder
                                                  .update(ordersUpdateData);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.grey1,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(0),
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Text(
                                                  'PICKUP',
                                                  style: FlutterFlowTheme
                                                      .subtitle2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                'DELIVERY',
                                                style: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 10, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Address',
                                                        style: FlutterFlowTheme
                                                            .subtitle2
                                                            .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                              .tertiaryColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 10, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 100,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                .tertiaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0, 0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        0,
                                                                        10,
                                                                        0),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  textController,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'type in your address',
                                                                hintStyle:
                                                                    FlutterFlowTheme
                                                                        .bodyText1,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                focusedBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: cartPageOrdersRecord.pickup ?? true,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                'PICKUP',
                                                style: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              final ordersUpdateData =
                                                  createOrdersRecordData(
                                                pickup: false,
                                                delivery: true,
                                              );
                                              await widget.inCartOrder
                                                  .update(ordersUpdateData);
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.grey1,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Text(
                                                  'DELIVERY',
                                                  style: FlutterFlowTheme
                                                      .subtitle2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 100,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Free Pickup Point: ',
                                                        style: FlutterFlowTheme
                                                            .subtitle2
                                                            .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                              .tertiaryColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(1,
                                                                      0, 0, 0),
                                                          child: StreamBuilder<
                                                              List<
                                                                  CustomerAppSettingRecord>>(
                                                            stream:
                                                                queryCustomerAppSettingRecord(
                                                              queryBuilder: (customerAppSettingRecord) =>
                                                                  customerAppSettingRecord.where(
                                                                      'name',
                                                                      isEqualTo:
                                                                          'pick_up_location'),
                                                              singleRecord:
                                                                  true,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child:
                                                                        SpinKitRotatingPlain(
                                                                      color: FlutterFlowTheme
                                                                          .primaryColor,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                              List<CustomerAppSettingRecord>
                                                                  dropDownCustomerAppSettingRecordList =
                                                                  snapshot.data;
                                                              // Return an empty Container when the document does not exist.
                                                              if (snapshot.data
                                                                  .isEmpty) {
                                                                return Container();
                                                              }
                                                              final dropDownCustomerAppSettingRecord =
                                                                  dropDownCustomerAppSettingRecordList
                                                                          .isNotEmpty
                                                                      ? dropDownCustomerAppSettingRecordList
                                                                          .first
                                                                      : null;
                                                              return FlutterFlowDropDown(
                                                                options:
                                                                    dropDownCustomerAppSettingRecord
                                                                        .options
                                                                        .toList(),
                                                                onChanged: (val) =>
                                                                    setState(() =>
                                                                        dropDownValue =
                                                                            val),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: 40,
                                                                textStyle:
                                                                    FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                elevation: 0,
                                                                borderColor: Colors
                                                                    .transparent,
                                                                borderWidth: 0,
                                                                borderRadius:
                                                                    10,
                                                                margin:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8,
                                                                            4,
                                                                            8,
                                                                            4),
                                                                hidesUnderline:
                                                                    true,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Text(
                                                        'Pickup Time:',
                                                        style: FlutterFlowTheme
                                                            .subtitle2
                                                            .override(
                                                          fontFamily: 'Roboto',
                                                          color: FlutterFlowTheme
                                                              .tertiaryColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              await DatePicker
                                                                  .showDateTimePicker(
                                                                context,
                                                                showTitleActions:
                                                                    true,
                                                                onConfirm:
                                                                    (date) {
                                                                  setState(() =>
                                                                      datePicked =
                                                                          date);
                                                                },
                                                                currentTime: functions
                                                                    .add15min(
                                                                        getCurrentTimestamp),
                                                                minTime: functions
                                                                    .add15min(
                                                                        getCurrentTimestamp),
                                                              );
                                                            },
                                                            child: Container(
                                                              width: 100,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0, 0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    dateTimeFormat(
                                                                        'Hm',
                                                                        datePicked),
                                                                    '00:00',
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .subtitle2
                                                                      .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Payment Method',
                              style: FlutterFlowTheme.title3,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: cartPageOrdersRecord.cashPayment ?? true,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          final ordersUpdateData =
                                              createOrdersRecordData(
                                            pointPayment: true,
                                            cashPayment: false,
                                          );
                                          await widget.inCartOrder
                                              .update(ordersUpdateData);
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(0),
                                            ),
                                          ),
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.grey1,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                'BRW.POINT',
                                                style:
                                                    FlutterFlowTheme.subtitle2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(10),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'CASH',
                                              style: FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Roboto',
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  cartPageOrdersRecord.pointPayment ?? true,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(0),
                                            ),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'BRW.POINT',
                                              style: FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Roboto',
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          final ordersUpdateData =
                                              createOrdersRecordData(
                                            cashPayment: true,
                                            pointPayment: false,
                                          );
                                          await widget.inCartOrder
                                              .update(ordersUpdateData);
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.grey1,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                'CASH',
                                                style:
                                                    FlutterFlowTheme.subtitle2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Order Summary',
                              style: FlutterFlowTheme.title3,
                            )
                          ],
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final orderItem =
                              cartPageOrdersRecord.items?.toList() ?? [];
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(orderItem.length,
                                (orderItemIndex) {
                              final orderItemItem = orderItem[orderItemIndex];
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: StreamBuilder<OrderItemsRecord>(
                                        stream: OrderItemsRecord.getDocument(
                                            orderItemItem),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: SpinKitRotatingPlain(
                                                  color: FlutterFlowTheme
                                                      .primaryColor,
                                                  size: 20,
                                                ),
                                              ),
                                            );
                                          }
                                          final containerOrderItemsRecord =
                                              snapshot.data;
                                          return Container(
                                            width: 100,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.grey1,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 5, 0),
                                              child: StreamBuilder<
                                                  MenuItemsRecord>(
                                                stream:
                                                    MenuItemsRecord.getDocument(
                                                        containerOrderItemsRecord
                                                            .item),
                                                builder: (context, snapshot) {
                                                  // Customize what your widget looks like when it's loading.
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                      child: SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            SpinKitRotatingPlain(
                                                          color:
                                                              FlutterFlowTheme
                                                                  .primaryColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  final rowMenuItemsRecord =
                                                      snapshot.data;
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(0),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              rowMenuItemsRecord
                                                                  .image,
                                                              width: 100,
                                                              height: 90,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 10, 0),
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            decoration:
                                                                BoxDecoration(),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        rowMenuItemsRecord
                                                                            .name,
                                                                        style: FlutterFlowTheme
                                                                            .subtitle2,
                                                                      ),
                                                                      Text(
                                                                        containerOrderItemsRecord
                                                                            .quantity
                                                                            .toString(),
                                                                        style: FlutterFlowTheme
                                                                            .subtitle1,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            5,
                                                                            0,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Note:',
                                                                          style:
                                                                              FlutterFlowTheme.bodyText1,
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            containerOrderItemsRecord.note,
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                    color: Color(
                                                                        0x00A2A2A2),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return Padding(
                                                                                  padding: MediaQuery.of(context).viewInsets,
                                                                                  child: Container(
                                                                                    height: MediaQuery.of(context).size.height * 0.4,
                                                                                    child: EditItemCompWidget(
                                                                                      orderItemRef: orderItemItem,
                                                                                      itemName: rowMenuItemsRecord.name,
                                                                                      initialQuantity: containerOrderItemsRecord.quantity,
                                                                                      initialNote: containerOrderItemsRecord.note,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Edit item',
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Roboto',
                                                                              color: FlutterFlowTheme.secondaryColor,
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            final ordersUpdateData =
                                                                                {
                                                                              ...createOrdersRecordData(
                                                                                total: functions.addSubstractTotalPrice(rowMenuItemsRecord.price, containerOrderItemsRecord.quantity, cartPageOrdersRecord.total, false),
                                                                                totalQuantity: functions.addSubstractTotalPrice(1, containerOrderItemsRecord.quantity, cartPageOrdersRecord.totalQuantity, false),
                                                                              ),
                                                                              'items': FieldValue.arrayRemove([
                                                                                containerOrderItemsRecord.reference
                                                                              ]),
                                                                            };
                                                                            await widget.inCartOrder.update(ordersUpdateData);
                                                                            await containerOrderItemsRecord.reference.delete();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Delete item',
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Roboto',
                                                                              color: Color(0xFFD83D19),
                                                                              fontStyle: FontStyle.italic,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.tertiaryColor,
                        ),
                        child: Visibility(
                          visible: (cartPageOrdersRecord.totalQuantity) != (0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        cartPageOrdersRecord.totalQuantity
                                            .toString(),
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        child: Text(
                                          'items',
                                          style: FlutterFlowTheme.subtitle1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total: ',
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                      Text(
                                        formatNumber(
                                          cartPageOrdersRecord.total,
                                          formatType: FormatType.decimal,
                                          decimalType:
                                              DecimalType.periodDecimal,
                                        ),
                                        style: FlutterFlowTheme.subtitle1,
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            final ordersUpdateData =
                                                createOrdersRecordData(
                                              inCart: false,
                                              createdTime: getCurrentTimestamp,
                                              pickupAddress: dropDownValue,
                                              deliveryAddress:
                                                  textController.text,
                                              statusProcessing: true,
                                            );
                                            await widget.inCartOrder
                                                .update(ordersUpdateData);

                                            final ordersCreateData =
                                                createOrdersRecordData(
                                              userId: currentUserReference,
                                              total: 0,
                                              inCart: true,
                                              transacted: false,
                                              cashPayment: false,
                                              pointPayment: true,
                                              pickup: true,
                                              delivery: false,
                                              totalQuantity: 0,
                                              statusProcessing: true,
                                              statusReady: false,
                                              statusDone: false,
                                            );
                                            final ordersRecordReference =
                                                OrdersRecord.collection.doc();
                                            await ordersRecordReference
                                                .set(ordersCreateData);
                                            createdorder = OrdersRecord
                                                .getDocumentFromData(
                                                    ordersCreateData,
                                                    ordersRecordReference);

                                            final usersUpdateData = {
                                              ...createUsersRecordData(
                                                inCartOrder:
                                                    createdorder.reference,
                                              ),
                                              'processing_order':
                                                  FieldValue.arrayUnion(
                                                      [widget.inCartOrder]),
                                            };
                                            await currentUserReference
                                                .update(usersUpdateData);
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 200),
                                                reverseDuration:
                                                    Duration(milliseconds: 200),
                                                child: NavBarPage(
                                                    initialPage: 'HomePage'),
                                              ),
                                            );

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Text(
                                              'Place order',
                                              style: FlutterFlowTheme.subtitle1
                                                  .override(
                                                fontFamily: 'Roboto',
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
