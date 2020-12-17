import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'size.dart';

class Options{
  String username,key;
  Options(String username,String key){
    this.username=username;
    this.key=key;

  }
  options(BuildContext context) {
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: ()  async {
                  DatabaseReference userref = FirebaseDatabase.instance.reference();

                  userref.child("Users").child(username).child("Saved").child(key).set({"saved yes":'a'});
                },
                child:  Text('Save',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 5*SizeConfig.blockSizeHorizontal,fontFamily:'NunitoSans',color:Colors.black87),),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child:  Text('Share',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 5*SizeConfig.blockSizeHorizontal,fontFamily:'NunitoSans',color:Colors.black87),),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: Text('Report',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 5*SizeConfig.blockSizeHorizontal,fontFamily:'NunitoSans',color:Colors.black87),),
              ),



            ],
          );
        });
  }
}