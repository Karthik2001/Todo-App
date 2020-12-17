import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'size.dart';
import 'package:firebase_database/firebase_database.dart';
import 'options.dart';
import 'authentication.dart';
import 'ViewProfile.dart';
class Build extends StatefulWidget {
  String uid,pkey,image,username,title,blog,liked,cuid,profileurl;
  Build(this.cuid,
      this.uid,
      this.pkey,
      this.image,
      this.blog,
      this.title,
      this.liked,
      this.profileurl,
      this.username);

  @override
  _BuildState createState() => _BuildState();
}

class _BuildState extends State<Build> {

  Options op;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  Future<String> getCurrentUsername()async
  {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  User user = await _firebaseAuth.currentUser;

  return user.displayName;
}
  Future<String> getCurrentUserId()async
  {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  User user = await _firebaseAuth.currentUser;

  return user.uid;
  }


  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,bottom: 3*SizeConfig.blockSizeVertical,
          left:1.38*SizeConfig.blockSizeHorizontal,right:
         1.38*SizeConfig.blockSizeHorizontal),
      height: 70*SizeConfig.blockSizeVertical,
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
                      padding: EdgeInsets.only(left: 1.8*SizeConfig.blockSizeVertical,top: 1.25*SizeConfig.blockSizeHorizontal,right: 0,bottom: 0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.profileurl),
                        radius : 3.2*SizeConfig.blockSizeVertical ,
                        backgroundColor: Colors.black12,
                      ),
                    ),

                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ViewProfile(widget.uid)));
                      },
                      child: Text(widget.username,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 4.1*SizeConfig.blockSizeHorizontal,
                            fontWeight: FontWeight.w600,   fontFamily: 'NunitoSans',
                            //fontFamily:'Courgette',
                            color:Colors.black87),
                      ),
                    ),

                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                  IconButton(
                    // padding:EdgeInsets.only(left: 145),
                    icon: Icon(Icons.flash_on, color: Color(0XFF00857C).withBlue(2446),size: 6.94*SizeConfig.blockSizeHorizontal,),
                    color: Colors.white,
                    onPressed:()  async {
                      String Username = await getCurrentUsername();
                      String uid= await getCurrentUserId();

                      int count =0;
                      DatabaseReference dbref = FirebaseDatabase.instance.reference();
                      print(widget.pkey);
                      print(uid+"ndkfns");

                      dbref.child("Post").child(widget.pkey).child("likedby").child(widget.uid).child(Username).set('yes');
                      dbref.child("Users").child(widget.uid).child("Post").child(widget.pkey).child('likedby').child(widget.uid).child(Username).set('yes');
                      DatabaseReference img= FirebaseDatabase.instance.reference().child("Post").child(widget.pkey).child('likedby');
                      img.once().then((DataSnapshot snap){
                        var Keys = snap.value.keys;
                        print(Keys);
                        var Data=snap.value;
                        print(Data);

                        for(var individualKeys in Keys)

                        {
                          ++count;


                          print(individualKeys);

                        }
                        dbref.child("Post").child(widget.pkey).child('liked').set(count.toString());
                        dbref.child("Users").child(widget.uid).child("Post").child(widget.pkey).child('liked').set(count.toString());
                        print(Keys);

                      }).whenComplete(() {
                        setState(()  {
                          widget.liked= count.toString();


                        });
                      });








                      // widget.auth.signOut();
                    },
                  ),
                  Text(widget.liked,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 3.3*SizeConfig.blockSizeHorizontal,
                        fontWeight: FontWeight.bold,   fontFamily: 'NunitoSans',
                        //fontFamily:'Courgette',
                        color:Colors.black87),),
                  IconButton(
                    // padding:EdgeInsets.only(left: 145),
                    icon: Icon(Icons.more_horiz, color: Colors.black54,size: 6.94*SizeConfig.blockSizeHorizontal),
                    color: Colors.white,
                    onPressed:(){
                      setState(() {
                        op = Options(widget.username,widget.pkey);
                      });
                      op.options(context);// widget.auth.signOut();
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(

              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.68*SizeConfig.blockSizeVertical),
                child: Image.network(widget.image,fit: BoxFit.contain,),
              ),
              margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,
                  //left:1.38*SizeConfig.blockSizeHorizontal,
                  //right: 1.38*SizeConfig.blockSizeHorizontal
                ),
              height: 40*SizeConfig.blockSizeVertical,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                    topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
                    bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                    bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
                ),
                color: Colors.white70,


              ),),
          ),
          Container(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
              padding:  EdgeInsets.fromLTRB(3*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
              child: Text(widget.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 4.72*SizeConfig.blockSizeHorizontal,
                    fontWeight: FontWeight.w500,   fontFamily: 'NunitoSans',
                    //fontFamily:'Courgette',
                    color:Colors.black87),
              ),
            ),
              Padding(
                padding:  EdgeInsets.fromLTRB(3*SizeConfig.blockSizeHorizontal,0.5*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                child: Text( widget.blog,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 3.83*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w500,
                      //fontFamily:'Courgette',
                      color:Colors.black87),
                ),
              ),],
          ),),

        ],
      ),
    );
  }
}
