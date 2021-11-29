import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateCustomerDetailPageWidget extends StatefulWidget {
  UpdateCustomerDetailPageWidget({Key key}) : super(key: key);

  @override
  _UpdateCustomerDetailPageWidgetState createState() =>
      _UpdateCustomerDetailPageWidgetState();
}

class _UpdateCustomerDetailPageWidgetState
    extends State<UpdateCustomerDetailPageWidget> {
  TextEditingController dayFieldController;
  TextEditingController monthFieldController;
  TextEditingController yearFieldController;
  TextEditingController firstNameFieldController;
  TextEditingController lastNameFieldController;
  bool _loadingButton = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dayFieldController = TextEditingController();
    monthFieldController = TextEditingController();
    yearFieldController = TextEditingController();
    firstNameFieldController = TextEditingController();
    lastNameFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Last name:',
                      style: FlutterFlowTheme.subtitle2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 5),
                        child: TextFormField(
                          controller: lastNameFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: FlutterFlowTheme.bodyText1,
                            hintText: '[Some hint text...]',
                            hintStyle: FlutterFlowTheme.bodyText1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.tertiaryColor,
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
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'First name:',
                      style: FlutterFlowTheme.subtitle2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 5, 0, 5),
                        child: TextFormField(
                          controller: firstNameFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: FlutterFlowTheme.bodyText1,
                            hintText: '[Some hint text...]',
                            hintStyle: FlutterFlowTheme.bodyText1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.tertiaryColor,
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
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Birth: ',
                      style: FlutterFlowTheme.subtitle2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: TextFormField(
                          controller: dayFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Day',
                            labelStyle: FlutterFlowTheme.bodyText1,
                            hintText: '[Some hint text...]',
                            hintStyle: FlutterFlowTheme.bodyText1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.tertiaryColor,
                          ),
                          style: FlutterFlowTheme.bodyText1,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field is required';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    Text(
                      '/',
                      style: FlutterFlowTheme.subtitle1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        child: TextFormField(
                          controller: monthFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Month',
                            labelStyle: FlutterFlowTheme.bodyText1,
                            hintText: '[Some hint text...]',
                            hintStyle: FlutterFlowTheme.bodyText1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.tertiaryColor,
                          ),
                          style: FlutterFlowTheme.bodyText1,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Field is required';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    Text(
                      '/',
                      style: FlutterFlowTheme.subtitle1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 5),
                        child: TextFormField(
                          controller: yearFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Year',
                            labelStyle: FlutterFlowTheme.bodyText1,
                            hintText: '[Some hint text...]',
                            hintStyle: FlutterFlowTheme.bodyText1,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.tertiaryColor,
                          ),
                          style: FlutterFlowTheme.bodyText1,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'error';
                            }
                            if (val.length < 4) {
                              return '5';
                            }
                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                  child: FFButtonWidget(
                    onPressed: () async {
                      setState(() => _loadingButton = true);
                      try {
                        if (!formKey.currentState.validate()) {
                          return;
                        }
                        final usersUpdateData = createUsersRecordData(
                          lastName: lastNameFieldController.text,
                          firstName: firstNameFieldController.text,
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
                      } finally {
                        setState(() => _loadingButton = false);
                      }
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
                      borderRadius: 12,
                    ),
                    loading: _loadingButton,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
