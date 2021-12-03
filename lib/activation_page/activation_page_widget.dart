import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login_page/login_page_widget.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivationPageWidget extends StatefulWidget {
  const ActivationPageWidget({Key key}) : super(key: key);

  @override
  _ActivationPageWidgetState createState() => _ActivationPageWidgetState();
}

class _ActivationPageWidgetState extends State<ActivationPageWidget> {
  TextEditingController otpFieldController;
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    otpFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                      child: TextFormField(
                        controller: otpFieldController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter 6 digit code',
                          hintStyle: FlutterFlowTheme.subtitle2,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.tertiaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.tertiaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.grey1,
                        ),
                        style: FlutterFlowTheme.subtitle2,
                        keyboardType: TextInputType.number,
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
                      if (otpFieldController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enter SMS verification code.'),
                          ),
                        );
                        return;
                      }
                      final phoneVerifiedUser = await verifySmsCode(
                        context: context,
                        smsCode: otpFieldController.text,
                      );
                      if (phoneVerifiedUser == null) {
                        return;
                      }
                      await Navigator.pushAndRemoveUntil(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 200),
                          reverseDuration: Duration(milliseconds: 200),
                          child: NavBarPage(initialPage: 'HomePage'),
                        ),
                        (r) => false,
                      );
                    } finally {
                      setState(() => _loadingButton = false);
                    }
                  },
                  text: 'Login',
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.primaryColor,
                    textStyle: FlutterFlowTheme.subtitle2.override(
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
                  loading: _loadingButton,
                ),
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 200),
                      reverseDuration: Duration(milliseconds: 200),
                      child: LoginPageWidget(),
                    ),
                  );
                },
                child: Text(
                  'cancel',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Roboto',
                    color: FlutterFlowTheme.secondaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
