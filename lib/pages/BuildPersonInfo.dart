import 'package:flutter/material.dart';

import 'size.dart';

class BuildPersonInfo extends StatefulWidget {
  String tag,info;
  BuildPersonInfo(this.tag,this.info);
  @override
  _BuildPersonInfoState createState() => _BuildPersonInfoState();
}

class _BuildPersonInfoState extends State<BuildPersonInfo> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
      height: 15*SizeConfig.blockSizeVertical,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
            topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
            bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
            bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
        ),
        color: Colors.grey[200],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 1.818*SizeConfig.blockSizeHorizontal,top: 0.81*SizeConfig.blockSizeVertical,right: 1.94*SizeConfig.blockSizeHorizontal,bottom: 0),
                      child: CircleAvatar(
                        // backgroundImage: NetworkImage(url),
                        radius : 3.45*SizeConfig.blockSizeVertical,
                        backgroundColor: Colors.black12,
                      ),
                    ),

                    Text(widget.tag,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 3.88*SizeConfig.blockSizeHorizontal,
                          fontWeight: FontWeight.w700, fontFamily: 'NunitoSans',
                          //fontFamily:'Courgette',
                          color:Colors.black87),
                    ),

                  ]
              ),
            ],
          ),
          Text(widget.info,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 3.88*SizeConfig.blockSizeHorizontal,
                fontWeight: FontWeight.w700, fontFamily: 'NunitoSans',
                //fontFamily:'Courgette',
                color:Colors.black87),
          ),
        ],

      ),
    );
  }
}
