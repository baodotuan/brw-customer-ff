import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../cart_page/cart_page_widget.dart';
import '../complete_customer_detail_page/complete_customer_detail_page_widget.dart';
import '../components/menu_bottom_sheet_comp_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrderPageWidget extends StatefulWidget {
  const OrderPageWidget({Key key}) : super(key: key);

  @override
  _OrderPageWidgetState createState() => _OrderPageWidgetState();
}

class _OrderPageWidgetState extends State<OrderPageWidget> {
  PageController pageViewController;
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
          floatingActionButton: Visibility(
            visible: !(functions.missingData(orderPageUsersRecord)) ?? true,
            child: StreamBuilder<OrdersRecord>(
              stream:
                  OrdersRecord.getDocument(orderPageUsersRecord.inCartOrder),
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
                  elevation: 4,
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
                                  (floatingActionButtonOrdersRecord.total) !=
                                      (0),
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
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
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
                        visible:
                            (floatingActionButtonOrdersRecord.total) != (0),
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
                                floatingActionButtonOrdersRecord.total
                                    .toString(),
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
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional(0, 1),
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 5),
                                  child: StreamBuilder<List<NewsRecord>>(
                                    stream: queryNewsRecord(
                                      queryBuilder: (newsRecord) =>
                                          newsRecord.orderBy('index'),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SpinKitRotatingPlain(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        );
                                      }
                                      List<NewsRecord> pageViewNewsRecordList =
                                          snapshot.data;
                                      return Container(
                                        width: double.infinity,
                                        height: 230,
                                        child: Stack(
                                          children: [
                                            PageView.builder(
                                              controller: pageViewController ??=
                                                  PageController(
                                                      initialPage: min(
                                                          0,
                                                          pageViewNewsRecordList
                                                                  .length -
                                                              1)),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  pageViewNewsRecordList.length,
                                              itemBuilder:
                                                  (context, pageViewIndex) {
                                                final pageViewNewsRecord =
                                                    pageViewNewsRecordList[
                                                        pageViewIndex];
                                                return Image.network(
                                                  pageViewNewsRecord.url,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 1),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 25),
                                                child: SmoothPageIndicator(
                                                  controller: pageViewController ??=
                                                      PageController(
                                                          initialPage: min(
                                                              0,
                                                              pageViewNewsRecordList
                                                                      .length -
                                                                  1)),
                                                  count: pageViewNewsRecordList
                                                      .length,
                                                  axisDirection:
                                                      Axis.horizontal,
                                                  onDotClicked: (i) {
                                                    pageViewController
                                                        .animateToPage(
                                                      i,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                  },
                                                  effect: ExpandingDotsEffect(
                                                    expansionFactor: 2,
                                                    spacing: 5,
                                                    radius: 10,
                                                    dotWidth: 5,
                                                    dotHeight: 3,
                                                    dotColor: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    activeDotColor:
                                                        FlutterFlowTheme
                                                            .tertiaryColor,
                                                    paintStyle:
                                                        PaintingStyle.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 100,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.tertiaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
                      Visibility(
                        visible:
                            functions.missingData(orderPageUsersRecord) ?? true,
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.grey1,
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Complete your profile to start!',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.title3,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                await Navigator
                                                    .pushAndRemoveUntil(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    reverseDuration: Duration(
                                                        milliseconds: 200),
                                                    child:
                                                        CompleteCustomerDetailPageWidget(
                                                      newUser: true,
                                                    ),
                                                  ),
                                                  (r) => false,
                                                );
                                              },
                                              text: 'Complete Now ',
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 40,
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.white,
                                                ),
                                                elevation: 3,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 40,
                                              ),
                                            ),
                                          )
                                        ],
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
                            !(functions.missingData(orderPageUsersRecord)) ??
                                true,
                        child: StreamBuilder<List<MenuCategoriesRecord>>(
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
                                            0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Text(
                                                menuColumnMenuCategoriesRecord
                                                    .name,
                                                style: FlutterFlowTheme
                                                    .subtitle1
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      StreamBuilder<List<MenuItemsRecord>>(
                                        stream: queryMenuItemsRecord(
                                          queryBuilder: (menuItemsRecord) =>
                                              menuItemsRecord
                                                  .where('category',
                                                      isEqualTo:
                                                          menuColumnMenuCategoriesRecord
                                                              .reference)
                                                  .orderBy('index'),
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
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 1, 0, 0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: Color(0x00CECECE),
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
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
                                                                inCartOrder:
                                                                    orderPageUsersRecord
                                                                        .inCartOrder,
                                                                itemName:
                                                                    columnMenuItemsRecord
                                                                        .name,
                                                                itemPrice:
                                                                    columnMenuItemsRecord
                                                                        .price,
                                                                menuItemRef:
                                                                    columnMenuItemsRecord
                                                                        .reference,
                                                                newOrderItem:
                                                                    true,
                                                                initialQuantity:
                                                                    1,
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
                                                                  .fromSTEB(10,
                                                                      5, 0, 5),
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
                                                              Text(
                                                                columnMenuItemsRecord
                                                                    .name,
                                                                style: FlutterFlowTheme
                                                                    .subtitle2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Text(
                                                                  formatNumber(
                                                                    columnMenuItemsRecord
                                                                        .price,
                                                                    formatType:
                                                                        FormatType
                                                                            .decimal,
                                                                    decimalType:
                                                                        DecimalType
                                                                            .commaDecimal,
                                                                  ),
                                                                  style: FlutterFlowTheme
                                                                      .bodyText1,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
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
                        ),
                      )
                    ],
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
