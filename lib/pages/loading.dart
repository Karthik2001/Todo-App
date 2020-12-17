import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import'size.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child:SpinKitRing(
        color:Color(0XFF00857C).withBlue(24460),
        size: 10*SizeConfig.blockSizeVertical,
      )
    );
  }
}
