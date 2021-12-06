import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_count_controller.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuBottomSheetCompWidget extends StatefulWidget {
  const MenuBottomSheetCompWidget({
    Key key,
    this.menuItemRef,
    this.inCartOrder,
    this.itemName,
    this.itemPrice,
    this.newOrderItem,
    this.orderItemRef,
    this.initialNote,
    this.initialQuantity,
    this.initialTotal,
    this.initialAmount,
    this.initialTotalQuantity,
  }) : super(key: key);

  final DocumentReference menuItemRef;
  final DocumentReference inCartOrder;
  final String itemName;
  final int itemPrice;
  final bool newOrderItem;
  final DocumentReference orderItemRef;
  final String initialNote;
  final int initialQuantity;
  final int initialTotal;
  final int initialAmount;
  final int initialTotalQuantity;

  @override
  _MenuBottomSheetCompWidgetState createState() =>
      _MenuBottomSheetCompWidgetState();
}

class _MenuBottomSheetCompWidgetState extends State<MenuBottomSheetCompWidget> {
  OrderItemsRecord createdItem;
  TextEditingController textController;
  int countControllerValue;

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
        final columnOrdersRecord = snapshot.data;
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Row(
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0x009E9E9E),
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
                        color: enabled
                            ? FlutterFlowTheme.primaryColor
                            : Color(0xFFEEEEEE),
                        size: 20,
                      ),
                      countBuilder: (count) => Text(
                        count.toString(),
                        style: FlutterFlowTheme.title3,
                      ),
                      count: countControllerValue ??= widget.initialQuantity,
                      updateCount: (count) =>
                          setState(() => countControllerValue = count),
                      stepSize: 1,
                      minimum: 1,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.tertiaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
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
                Visibility(
                  visible: widget.newOrderItem ?? true,
                  child: Expanded(
                    child: InkWell(
                      onTap: () async {
                        final orderItemsCreateData = createOrderItemsRecordData(
                          item: widget.menuItemRef,
                          quantity: countControllerValue,
                          note: textController.text,
                          createdTime: getCurrentTimestamp,
                          amount: functions.multiplyTwoInterger(
                              widget.itemPrice, countControllerValue),
                        );
                        final orderItemsRecordReference =
                            OrderItemsRecord.collection.doc();
                        await orderItemsRecordReference
                            .set(orderItemsCreateData);
                        createdItem = OrderItemsRecord.getDocumentFromData(
                            orderItemsCreateData, orderItemsRecordReference);

                        final ordersUpdateData = {
                          ...createOrdersRecordData(
                            total: functions.addOrSubstractTwoInterger(
                                createdItem.amount,
                                columnOrdersRecord.total,
                                true),
                            totalQuantity: functions.addOrSubstractTwoInterger(
                                createdItem.quantity,
                                columnOrdersRecord.totalQuantity,
                                true),
                          ),
                          'items':
                              FieldValue.arrayUnion([createdItem.reference]),
                        };
                        await widget.inCartOrder.update(ordersUpdateData);
                        Navigator.pop(context);

                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.primaryColor,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Text(
                            'Add to cart',
                            style: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !(widget.newOrderItem) ?? true,
                  child: Expanded(
                    child: InkWell(
                      onTap: () async {
                        final orderItemsUpdateData = createOrderItemsRecordData(
                          quantity: countControllerValue,
                          note: textController.text,
                          amount: functions.multiplyTwoInterger(
                              widget.itemPrice, countControllerValue),
                        );
                        await widget.orderItemRef.update(orderItemsUpdateData);

                        final ordersUpdateData = createOrdersRecordData(
                          totalQuantity: functions.addOrSubstractTwoInterger(
                              functions.addOrSubstractTwoInterger(
                                  widget.initialTotalQuantity,
                                  widget.initialQuantity,
                                  false),
                              countControllerValue,
                              true),
                          total: functions.addOrSubstractTwoInterger(
                              functions.addOrSubstractTwoInterger(
                                  widget.initialTotal,
                                  widget.initialAmount,
                                  false),
                              functions.multiplyTwoInterger(
                                  widget.itemPrice, countControllerValue),
                              true),
                        );
                        await widget.inCartOrder.update(ordersUpdateData);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.primaryColor,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Text(
                            'Update',
                            style: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
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
        );
      },
    );
  }
}
