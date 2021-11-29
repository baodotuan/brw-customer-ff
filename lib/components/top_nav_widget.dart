import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TopNavWidget extends StatefulWidget {
  TopNavWidget({Key key}) : super(key: key);

  @override
  _TopNavWidgetState createState() => _TopNavWidgetState();
}

class _TopNavWidgetState extends State<TopNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0x00EEEEEE),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 24,
            ),
          ),
        )
      ],
    );
  }
}
