import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteCustomerDetailPageWidget extends StatefulWidget {
  const CompleteCustomerDetailPageWidget({
    Key key,
    this.newUser,
  }) : super(key: key);

  final bool newUser;

  @override
  _CompleteCustomerDetailPageWidgetState createState() =>
      _CompleteCustomerDetailPageWidgetState();
}

class _CompleteCustomerDetailPageWidgetState
    extends State<CompleteCustomerDetailPageWidget> {
  DateTime datePicked;
  TextEditingController firstNameFieldController;
  TextEditingController lastNameFieldController;
  OrdersRecord createdOrder;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    firstNameFieldController =
        TextEditingController(text: currentUserDocument?.firstName);
    lastNameFieldController =
        TextEditingController(text: currentUserDocument?.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last Name:',
                      style: FlutterFlowTheme.subtitle2,
                    ),
                    Container(
                      width: 210,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.grey1,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: AuthUserStreamWidget(
                          child: TextFormField(
                            controller: lastNameFieldController,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              filled: true,
                              fillColor: Color(0x00FFFFFF),
                            ),
                            style: FlutterFlowTheme.bodyText1,
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Field is required';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'First Name:',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      Container(
                        width: 210,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.grey1,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                          child: AuthUserStreamWidget(
                            child: TextFormField(
                              controller: firstNameFieldController,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                filled: true,
                                fillColor: Color(0x00FFFFFF),
                              ),
                              style: FlutterFlowTheme.bodyText1,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Field is required';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date of Birth: ',
                        style: FlutterFlowTheme.subtitle2,
                      ),
                      InkWell(
                        onTap: () async {
                          await DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() => datePicked = date);
                            },
                            currentTime: currentUserDocument?.birth,
                          );
                        },
                        child: Container(
                          width: 210,
                          height: 50,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.grey1,
                            borderRadius: BorderRadius.circular(400),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      dateTimeFormat('d/M/y', datePicked),
                                      '1/1/2000',
                                    ),
                                    style: FlutterFlowTheme.subtitle2,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 20, 0),
                                  child: Icon(
                                    Icons.calendar_today_rounded,
                                    color: FlutterFlowTheme.grey2,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.newUser ?? true)
                        StreamBuilder<List<CustomerAppSettingRecord>>(
                          stream: queryCustomerAppSettingRecord(
                            queryBuilder: (customerAppSettingRecord) =>
                                customerAppSettingRecord.where('name',
                                    isEqualTo: 'new_user_created'),
                            singleRecord: true,
                          ),
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
                            List<CustomerAppSettingRecord>
                                buttonCustomerAppSettingRecordList =
                                snapshot.data;
                            final buttonCustomerAppSettingRecord =
                                buttonCustomerAppSettingRecordList.isNotEmpty
                                    ? buttonCustomerAppSettingRecordList.first
                                    : null;
                            return FFButtonWidget(
                              onPressed: () async {
                                if (!formKey.currentState.validate()) {
                                  return;
                                }
                                final ordersCreateData = createOrdersRecordData(
                                  userId: currentUserReference,
                                  total: 0,
                                  inCart: true,
                                  transacted: false,
                                  cashPayment: false,
                                  pointPayment: true,
                                  pickup: true,
                                  delivery: false,
                                  totalQuantity: 0,
                                  statusProcessing: false,
                                  statusReady: false,
                                  statusDone: false,
                                  createdTime: getCurrentTimestamp,
                                );
                                final ordersRecordReference =
                                    OrdersRecord.collection.doc();
                                await ordersRecordReference
                                    .set(ordersCreateData);
                                createdOrder = OrdersRecord.getDocumentFromData(
                                    ordersCreateData, ordersRecordReference);

                                final usersUpdateData = createUsersRecordData(
                                  lastName: functions
                                      .capitalize(lastNameFieldController.text),
                                  firstName: functions.capitalize(
                                      firstNameFieldController.text),
                                  point: buttonCustomerAppSettingRecord.value,
                                  birth: datePicked,
                                  inCartOrder: createdOrder.reference,
                                  loyaltyCardPoint: 0,
                                  totalTopup: 0,
                                  totalSpent: 0,
                                  totalAppOrder: 0,
                                );
                                await currentUserReference
                                    .update(usersUpdateData);

                                final transactionsCreateData =
                                    createTransactionsRecordData(
                                  time: getCurrentTimestamp,
                                  amount: buttonCustomerAppSettingRecord.value,
                                  customerId: currentUserReference,
                                  receiptUrl: '',
                                  credit: false,
                                );
                                await TransactionsRecord.collection
                                    .doc()
                                    .set(transactionsCreateData);
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 200),
                                    reverseDuration:
                                        Duration(milliseconds: 200),
                                    child: NavBarPage(initialPage: 'HomePage'),
                                  ),
                                );

                                setState(() {});
                              },
                              text: 'Complete',
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
                                borderRadius: 40,
                              ),
                            );
                          },
                        ),
                      if (!(widget.newUser) ?? true)
                        FFButtonWidget(
                          onPressed: () async {
                            if (!formKey.currentState.validate()) {
                              return;
                            }
                            final usersUpdateData = createUsersRecordData(
                              lastName: functions
                                  .capitalize(lastNameFieldController.text),
                              firstName: functions
                                  .capitalize(firstNameFieldController.text),
                              birth: datePicked,
                            );
                            await currentUserReference.update(usersUpdateData);
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 200),
                                reverseDuration: Duration(milliseconds: 200),
                                child: NavBarPage(initialPage: 'HomePage'),
                              ),
                            );
                          },
                          text: 'Update',
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
                            borderRadius: 40,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
