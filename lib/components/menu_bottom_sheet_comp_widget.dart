import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_count_controller.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuBottomSheetCompWidget extends StatefulWidget {
  MenuBottomSheetCompWidget({
    Key key,
    this.itemRef,
    this.inCartOrder,
    this.itemName,
    this.itemDes,
    this.itemPrice,
  }) : super(key: key);

  final DocumentReference itemRef;
  final DocumentReference inCartOrder;
  final String itemName;
  final String itemDes;
  final int itemPrice;

  @override
  _MenuBottomSheetCompWidgetState createState() =>
      _MenuBottomSheetCompWidgetState();
}

class _MenuBottomSheetCompWidgetState extends State<MenuBottomSheetCompWidget> {
  OrderItemsRecord createdOrderItem;
  bool _loadingButton = false;
  TextEditingController textController;
  int countControllerValue;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: StreamBuilder<OrdersRecord>(
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
          final columnOrdersRecord = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          widget.itemName,
                          style: FlutterFlowTheme.title1,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.itemDes,
                          style: FlutterFlowTheme.bodyText1,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFF9E9E9E),
                        width: 1,
                      ),
                    ),
                    child: FlutterFlowCountController(
                      decrementIconBuilder: (enabled) => FaIcon(
                        FontAwesomeIcons.minus,
                        color: enabled ? Color(0xDD000000) : Color(0xFFEEEEEE),
                        size: 20,
                      ),
                      incrementIconBuilder: (enabled) => FaIcon(
                        FontAwesomeIcons.plus,
                        color: enabled ? Colors.blue : Color(0xFFEEEEEE),
                        size: 20,
                      ),
                      countBuilder: (count) => Text(
                        count.toString(),
                        style: GoogleFonts.getFont(
                          'Roboto',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      count: countControllerValue ??= 1,
                      updateCount: (count) =>
                          setState(() => countControllerValue = count),
                      stepSize: 1,
                      minimum: 1,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'NOTE:',
                        style: FlutterFlowTheme.bodyText1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: TextFormField(
                            controller: textController,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'note here',
                              hintStyle: FlutterFlowTheme.bodyText1,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton = true);
                      try {
                        final orderItemsCreateData = createOrderItemsRecordData(
                          item: widget.itemRef,
                          quantity: countControllerValue,
                          note: textController.text,
                          createdTime: getCurrentTimestamp,
                        );
                        final orderItemsRecordReference =
                            OrderItemsRecord.collection.doc();
                        await orderItemsRecordReference
                            .set(orderItemsCreateData);
                        createdOrderItem = OrderItemsRecord.getDocumentFromData(
                            orderItemsCreateData, orderItemsRecordReference);

                        final ordersUpdateData = {
                          ...createOrdersRecordData(
                            total: functions.addSubstractTotalPrice(
                                widget.itemPrice,
                                countControllerValue,
                                columnOrdersRecord.total,
                                true),
                            totalQuantity: functions.addSubstractTotalPrice(
                                1,
                                countControllerValue,
                                columnOrdersRecord.totalQuantity,
                                true),
                          ),
                          'items': FieldValue.arrayUnion(
                              [createdOrderItem.reference]),
                        };
                        await widget.inCartOrder.update(ordersUpdateData);
                        Navigator.pop(context);

                        setState(() {});
                      } finally {
                        setState(() => _loadingButton = false);
                      }
                    },
                    text: 'Add to cart',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                    loading: _loadingButton,
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
