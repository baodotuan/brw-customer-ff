import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CongratPageWidget extends StatefulWidget {
  const CongratPageWidget({Key key}) : super(key: key);

  @override
  _CongratPageWidgetState createState() => _CongratPageWidgetState();
}

class _CongratPageWidgetState extends State<CongratPageWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CustomerAppSettingRecord>>(
      stream: queryCustomerAppSettingRecord(
        queryBuilder: (customerAppSettingRecord) =>
            customerAppSettingRecord.where('name', isEqualTo: 'loyalty_reward'),
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
        List<CustomerAppSettingRecord> congratPageCustomerAppSettingRecordList =
            snapshot.data;
        // Return an empty Container when the document does not exist.
        if (snapshot.data.isEmpty) {
          return Container();
        }
        final congratPageCustomerAppSettingRecord =
            congratPageCustomerAppSettingRecordList.isNotEmpty
                ? congratPageCustomerAppSettingRecordList.first
                : null;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.tertiaryColor,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 0),
                            child: Text(
                              'Congrats!',
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.primaryColor,
                              ),
                            ).animated(
                                [animationsMap['textOnPageLoadAnimation1']]),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You just got your ${formatNumber(
                                congratPageCustomerAppSettingRecord.value,
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.commaDecimal,
                              )} points!',
                              style: FlutterFlowTheme.title2.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.primaryColor,
                              ),
                            ).animated(
                                [animationsMap['textOnPageLoadAnimation2']]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/gift1.jpeg',
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if ((currentUserDocument?.loyaltyCardPoint) >= (10)) {
                            final usersUpdateData = createUsersRecordData(
                              loyaltyCardPoint: 0,
                              point: functions.addOrSubstractTwoInterger(
                                  currentUserDocument?.point,
                                  congratPageCustomerAppSettingRecord.value,
                                  true),
                            );
                            await currentUserReference.update(usersUpdateData);
                          }
                          if ((currentUserDocument?.loyaltyCardPoint) >= (10)) {
                            final transactionsCreateData =
                                createTransactionsRecordData(
                              time: getCurrentTimestamp,
                              amount: congratPageCustomerAppSettingRecord.value,
                              customerId: currentUserReference,
                              receiptUrl: '',
                              credit: false,
                            );
                            await TransactionsRecord.collection
                                .doc()
                                .set(transactionsCreateData);
                          }
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
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Confirm',
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.tertiaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
