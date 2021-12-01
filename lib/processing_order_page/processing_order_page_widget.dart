import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/top_nav_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ProcessingOrderPageWidget extends StatefulWidget {
  const ProcessingOrderPageWidget({Key key}) : super(key: key);

  @override
  _ProcessingOrderPageWidgetState createState() =>
      _ProcessingOrderPageWidgetState();
}

class _ProcessingOrderPageWidgetState extends State<ProcessingOrderPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
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
        final processingOrderPageUsersRecord = snapshot.data;
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
                        'Your order',
                        style: FlutterFlowTheme.title1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Builder(
                      builder: (context) {
                        final order = processingOrderPageUsersRecord
                                .processingOrder
                                ?.toList() ??
                            [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: order.length,
                          itemBuilder: (context, orderIndex) {
                            final orderItem = order[orderIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: StreamBuilder<OrdersRecord>(
                                stream: OrdersRecord.getDocument(orderItem),
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
                                  final containerOrdersRecord = snapshot.data;
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 0, 10, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              dateTimeFormat(
                                                                  'd/M H:m',
                                                                  containerOrdersRecord
                                                                      .createdTime),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle1
                                                                      .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              containerOrdersRecord
                                                                  .items.length
                                                                  .toString(),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle1
                                                                      .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              containerOrdersRecord
                                                                  .total
                                                                  .toString(),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle1
                                                                      .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
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
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        FlutterFlowTheme.grey1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 0, 10),
                                                    child: Builder(
                                                      builder: (context) {
                                                        final item =
                                                            containerOrdersRecord
                                                                    .items
                                                                    ?.toList() ??
                                                                [];
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children:
                                                              List.generate(
                                                                  item.length,
                                                                  (itemIndex) {
                                                            final itemItem =
                                                                item[itemIndex];
                                                            return StreamBuilder<
                                                                OrderItemsRecord>(
                                                              stream: OrderItemsRecord
                                                                  .getDocument(
                                                                      itemItem),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      child:
                                                                          SpinKitRotatingPlain(
                                                                        color: FlutterFlowTheme
                                                                            .primaryColor,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                final rowOrderItemsRecord =
                                                                    snapshot
                                                                        .data;
                                                                return Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            StreamBuilder<MenuItemsRecord>(
                                                                              stream: MenuItemsRecord.getDocument(rowOrderItemsRecord.item),
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
                                                                                final rowMenuItemsRecord = snapshot.data;
                                                                                return Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      rowMenuItemsRecord.name,
                                                                                      style: FlutterFlowTheme.bodyText1,
                                                                                    ),
                                                                                    Text(
                                                                                      rowOrderItemsRecord.quantity.toString(),
                                                                                      style: FlutterFlowTheme.bodyText1,
                                                                                    )
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    rowOrderItemsRecord.note,
                                                                                    style: FlutterFlowTheme.bodyText1,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          }),
                                                        );
                                                      },
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
      },
    );
  }
}
