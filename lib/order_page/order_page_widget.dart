import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../cart_page/cart_page_widget.dart';
import '../components/menu_bottom_sheet_comp_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPageWidget extends StatefulWidget {
  const OrderPageWidget({Key key}) : super(key: key);

  @override
  _OrderPageWidgetState createState() => _OrderPageWidgetState();
}

class _OrderPageWidgetState extends State<OrderPageWidget> {
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
        final orderPageUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.tertiaryColor,
          floatingActionButton: StreamBuilder<OrdersRecord>(
            stream: OrdersRecord.getDocument(orderPageUsersRecord.inCartOrder),
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
              final floatingActionButtonOrdersRecord = snapshot.data;
              return FloatingActionButton.extended(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 200),
                      reverseDuration: Duration(milliseconds: 200),
                      child: CartPageWidget(
                        inCartOrder: orderPageUsersRecord.inCartOrder,
                      ),
                    ),
                  );
                },
                backgroundColor: FlutterFlowTheme.primaryColor,
                elevation: 8,
                label: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Stack(
                        children: [
                          Visibility(
                            visible:
                                (floatingActionButtonOrdersRecord.total) != (0),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0x00EEEEEE),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(1, -1),
                              child: Visibility(
                                visible: (floatingActionButtonOrdersRecord
                                        .totalQuantity) !=
                                    (0),
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.tertiaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Text(
                                    floatingActionButtonOrdersRecord
                                        .totalQuantity
                                        .toString(),
                                    style: FlutterFlowTheme.subtitle2.override(
                                      fontFamily: 'Roboto',
                                      color: FlutterFlowTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0x00EEEEEE),
                              shape: BoxShape.circle,
                            ),
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.shopping_cart,
                              color: FlutterFlowTheme.tertiaryColor,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (floatingActionButtonOrdersRecord.total) != (0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              ' - ',
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.tertiaryColor,
                              ),
                            ),
                            Text(
                              floatingActionButtonOrdersRecord.total.toString(),
                              style: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Roboto',
                                color: FlutterFlowTheme.tertiaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order now',
                                style: FlutterFlowTheme.title1,
                              )
                            ],
                          ),
                        ),
                        StreamBuilder<List<MenuCategoriesRecord>>(
                          stream: queryMenuCategoriesRecord(
                            queryBuilder: (menuCategoriesRecord) =>
                                menuCategoriesRecord.orderBy('index'),
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
                            List<MenuCategoriesRecord>
                                menuColumnMenuCategoriesRecordList =
                                snapshot.data;
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  menuColumnMenuCategoriesRecordList.length,
                                  (menuColumnIndex) {
                                final menuColumnMenuCategoriesRecord =
                                    menuColumnMenuCategoriesRecordList[
                                        menuColumnIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 10),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                menuColumnMenuCategoriesRecord
                                                    .name,
                                                style:
                                                    FlutterFlowTheme.subtitle1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      StreamBuilder<List<MenuItemsRecord>>(
                                        stream: queryMenuItemsRecord(
                                          queryBuilder: (menuItemsRecord) =>
                                              menuItemsRecord.where('category',
                                                  isEqualTo:
                                                      menuColumnMenuCategoriesRecord
                                                          .reference),
                                        ),
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
                                          List<MenuItemsRecord>
                                              columnMenuItemsRecordList =
                                              snapshot.data;
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                columnMenuItemsRecordList
                                                    .length, (columnIndex) {
                                              final columnMenuItemsRecord =
                                                  columnMenuItemsRecordList[
                                                      columnIndex];
                                              return Container(
                                                width: double.infinity,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.grey1,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Color(0x00CECECE),
                                                  ),
                                                ),
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.4,
                                                            child:
                                                                MenuBottomSheetCompWidget(
                                                              itemRef:
                                                                  columnMenuItemsRecord
                                                                      .reference,
                                                              inCartOrder:
                                                                  orderPageUsersRecord
                                                                      .inCartOrder,
                                                              itemName:
                                                                  columnMenuItemsRecord
                                                                      .name,
                                                              itemDes:
                                                                  columnMenuItemsRecord
                                                                      .description,
                                                              itemPrice:
                                                                  columnMenuItemsRecord
                                                                      .price,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10, 0,
                                                                    0, 0),
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
                                                            Text(
                                                              columnMenuItemsRecord
                                                                  .name,
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .subtitle2,
                                                            ),
                                                            Text(
                                                              columnMenuItemsRecord
                                                                  .price
                                                                  .toString(),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText1,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          columnMenuItemsRecord
                                                              .image,
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                        )
                      ],
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
