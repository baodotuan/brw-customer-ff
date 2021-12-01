import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/top_nav_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../transaction_detail_page/transaction_detail_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPageWidget extends StatefulWidget {
  const HistoryPageWidget({Key key}) : super(key: key);

  @override
  _HistoryPageWidgetState createState() => _HistoryPageWidgetState();
}

class _HistoryPageWidgetState extends State<HistoryPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TopNavWidget(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'History',
                    style: FlutterFlowTheme.title1,
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: StreamBuilder<List<TransactionsRecord>>(
                  stream: queryTransactionsRecord(
                    queryBuilder: (transactionsRecord) => transactionsRecord
                        .where('customer_id', isEqualTo: currentUserReference)
                        .orderBy('time'),
                    limit: 5,
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
                    List<TransactionsRecord> listViewTransactionsRecordList =
                        snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewTransactionsRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewTransactionsRecord =
                            listViewTransactionsRecordList[listViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 200),
                                    reverseDuration:
                                        Duration(milliseconds: 200),
                                    child: TransactionDetailPageWidget(
                                      url:
                                          listViewTransactionsRecord.receiptUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 200),
                                              reverseDuration:
                                                  Duration(milliseconds: 200),
                                              child:
                                                  TransactionDetailPageWidget(
                                                url: listViewTransactionsRecord
                                                    .receiptUrl,
                                                creditBool:
                                                    listViewTransactionsRecord
                                                        .credit,
                                                amount:
                                                    listViewTransactionsRecord
                                                        .amount,
                                                dateTime:
                                                    listViewTransactionsRecord
                                                        .time,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dateTimeFormat(
                                                  'd/M h:m a',
                                                  listViewTransactionsRecord
                                                      .time),
                                              style: FlutterFlowTheme.subtitle1,
                                            ),
                                            Visibility(
                                              visible:
                                                  !(listViewTransactionsRecord
                                                          .credit) ??
                                                      true,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      '+',
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xFF418714),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 0, 0),
                                                      child: Text(
                                                        listViewTransactionsRecord
                                                            .amount
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xFF418714),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  listViewTransactionsRecord
                                                          .credit ??
                                                      true,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      '- ',
                                                      style: FlutterFlowTheme
                                                          .bodyText1
                                                          .override(
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            Color(0xFFFF0000),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 0, 0),
                                                      child: Text(
                                                        listViewTransactionsRecord
                                                            .amount
                                                            .toString(),
                                                        style: FlutterFlowTheme
                                                            .bodyText1
                                                            .override(
                                                          fontFamily: 'Roboto',
                                                          color:
                                                              Color(0xFFFF0000),
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
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
