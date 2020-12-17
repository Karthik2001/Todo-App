import 'package:flutter/material.dart';
import 'size.dart';
import 'ViewProfile.dart';

class BuildNotification extends StatefulWidget {
  String person;
  String title;
  String image;
  String uid;
  BuildNotification(this.person,this.title,this.image,this.uid);
  @override
  _BuildNotificationState createState() => _BuildNotificationState();
}

class _BuildNotificationState extends State<BuildNotification> {
  @override
  Widget build(BuildContext context) {


      return Container(
        margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
       height: 10*SizeConfig.blockSizeVertical,
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
          children: <Widget>[
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 2.7*SizeConfig.blockSizeHorizontal,top: 1.25*SizeConfig.blockSizeVertical,right: 1.9*SizeConfig.blockSizeHorizontal,bottom: 0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget.image),
                                radius : 3.45*SizeConfig.blockSizeVertical,
                                backgroundColor: Colors.black12,
                              ),
                            ),
                            Flexible(
                              child: FlatButton(
                                onPressed: (){
                                  print(widget.uid);
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ViewProfile(widget.uid)));
                                },
                                child: Text( widget.person +" liked your post titled "+ widget.title,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 4*SizeConfig.blockSizeHorizontal,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'NunitoSans',
                                      //fontFamily:'Courgette',
                                      color:Colors.black87),
                                ),
                              ),
                            ),


                          ]
                      ),
                  ),

                ],
              ),
            ),
          ],
        ),
      );

  }
}

