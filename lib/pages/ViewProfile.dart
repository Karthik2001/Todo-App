import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'size.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'myblogs.dart';
import 'loading.dart';

class ViewProfile extends StatefulWidget {
  String uid;

  var status='a',url='a',branch='a',skills='a',email='a',schoolname='a',worksat='a',username='a';
  int liked=0,blogcount=0;
 ViewProfile(this.uid);
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String username='';
  String url;

  bool loading=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference img=   FirebaseDatabase.instance.reference().child("Users").child(widget.uid);
    img.once().then((DataSnapshot snap) async{
      var Keys = snap.value.keys;
      print(Keys);
      var Data=snap.value;
      setState(() {
        widget.url=Data['userdetails']['profileurl'];
        widget.status=Data['userdetails']['state'];
        widget.email=Data['userdetails']['email'];
        widget.skills=Data['userdetails']['skills'];
        widget.branch=Data['userdetails']['branch'];
        widget.username=Data['userdetails']['name'];
        widget.schoolname=Data['userdetails']['schoolname'];
        widget.worksat=Data['userdetails']['worksat'];//print(Keys);
      });
      print(Data);


    }).whenComplete(() {

    });
    DatabaseReference userref =  FirebaseDatabase.instance.reference().child("Users").child(widget.uid).child('Post');
    userref.once().then((DataSnapshot snap) async {
      var Keys = snap.value.keys;
      var Data=snap.value;
      setState(() {
        //widget.url=url;
        for(var individualKeys in Keys)
        {
          ++widget.blogcount;
          widget.liked = widget.liked +int.parse(Data[individualKeys]['liked']);
        }
      });
    }).whenComplete(() {
      setState(() {
        //widget.url=url;
        loading=false;
      });
    });


  }

  Future<String> getCurrentUserId()async
  {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  User user = await _firebaseAuth.currentUser;
  return user.uid;
  }
  @override
  Widget build(BuildContext context) {
    return loading==true?Loading():Scaffold(
      backgroundColor: Color(0XFF00857C).withBlue(2446),

      body:ListView(
        children: <Widget>[
          Container(
            height :32*SizeConfig.blockSizeVertical,
            child: Column(
                children:<Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal, 3.09*SizeConfig.blockSizeVertical, 0, 0),
                    child: Row(


                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.url),
                            radius : 7.27*SizeConfig.blockSizeVertical,
                            backgroundColor: Colors.white70,
                          ),
                          Container(
                            margin:  EdgeInsets.fromLTRB(2.77*SizeConfig.blockSizeHorizontal,3.63*SizeConfig.blockSizeVertical,0,0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.username,
                                  style: TextStyle(
                                      fontSize: 5.5*SizeConfig.blockSizeHorizontal,
                                      fontFamily: 'NunitoSans',


                                      color:Colors.white
                                  ),
                                ),
                                Text(widget.status,
                                  style: TextStyle(
                                      fontSize: 3.6*SizeConfig.blockSizeHorizontal,
                                      fontFamily: 'NunitoSans',
                                      fontWeight: FontWeight.bold,

                                      color:Colors.white70
                                  ),
                                ),
                              ],
                            ),
                          ),]),
                  ),
                  FlatButton(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal, 3.63*SizeConfig.blockSizeVertical, 5.5*SizeConfig.blockSizeHorizontal, 0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(

                            children: <Widget>[
                              Text((widget.blogcount).toString(),
                                style: TextStyle(
                                  fontSize: 6.9*SizeConfig.blockSizeHorizontal,
                                  color:Colors.white,
                                  fontFamily: 'NunitoSans',
                                ),
                              ),

                              Text('Posts',
                                style: TextStyle(
                                    fontSize: 4.16*SizeConfig.blockSizeHorizontal,
                                    fontFamily: 'NunitoSans',
                                    color:Colors.white70
                                ),
                              ),

                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text((widget.liked).toString(),
                                style: TextStyle(
                                  fontSize:  6.9*SizeConfig.blockSizeHorizontal,
                                  color:Colors.white,
                                  fontFamily: 'NunitoSans',
                                ),
                              ),
                              Text('Likes',
                                style: TextStyle(
                                    fontSize: 4.16*SizeConfig.blockSizeHorizontal,
                                    fontFamily: 'NunitoSans',
                                    color:Colors.white70
                                ),
                              ),

                            ],
                          ),
                          Container(
                            margin:  EdgeInsets.only(left:16.6*SizeConfig.blockSizeHorizontal,top: 0.9*SizeConfig.blockSizeVertical),
                            child: FlatButton(

                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(2.18*SizeConfig.blockSizeVertical),
                                  side: BorderSide(color:Color(0XFF00857C).withBlue(2446),)
                              ),
                              // color: Color(0XFF00857C),
                              child: Text('Edit Profile',
                                style: TextStyle(
                                    fontSize: 3.3*SizeConfig.blockSizeHorizontal,
                                    fontFamily: 'NunitoSans',
                                    fontWeight: FontWeight.bold,
                                    color:Color(0XFF00857C).withBlue(2446),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed:((){
                      String uid;
                      setState(() {
                        uid= widget.uid;
                      });
                      {Navigator.of(context).push(new MaterialPageRoute(builder: (context) => MyBlogs(uid: uid,)));};
                    }),

                  ),


                ]
            ),
          ),

          //User_information(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(5.5*SizeConfig.blockSizeHorizontal),topLeft:Radius.circular(5.5*SizeConfig.blockSizeHorizontal))
            ),
            padding: EdgeInsets.all(1.0),
            height:70*SizeConfig.blockSizeVertical,
            //constraints: BoxConstraints.expand(),
            margin: EdgeInsets.fromLTRB(0,1.8*SizeConfig.blockSizeVertical,0,0),
            child: SizedBox(
              // height:40,
              child: Container(

                child: ListView(
                  //  semanticChildCount: 2,
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    // User_information(),
                    SizedBox(height: 1.8*SizeConfig.blockSizeVertical,),
                    _buidContainer("Status",widget.status,widget.url),
                    _buidContainer("Skills",widget.skills,widget.url),
                    _buidContainer("Branch",widget.branch,widget.url ),
                    _buidContainer("Contact Info",widget.email,widget.url),
                    SizedBox(height: 36.3*SizeConfig.blockSizeVertical,),




                  ],
                ),
              ),
            ),
          ),
          // UserDetails(),

        ],
      ),
    );
  }

}





Widget _buidContainer(String Tag,String Info,String url) {

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
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 2.7*SizeConfig.blockSizeHorizontal,top: 4.5,right: 1.94*SizeConfig.blockSizeHorizontal,bottom: 1.8*SizeConfig.blockSizeVertical),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url),
                      radius : 15 ,
                      backgroundColor: Colors.black54,
                    ),
                  ),

                  Text(Tag,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 3.8*SizeConfig.blockSizeHorizontal,
                        fontWeight: FontWeight.w700, fontFamily: 'NunitoSans',
                        //fontFamily:'Courgette',
                        color:Colors.black87),
                  ),

                ]
            ),
          ],
        ),
        Padding(
          padding:  EdgeInsets.fromLTRB(3.88*SizeConfig.blockSizeHorizontal, 1.45*SizeConfig.blockSizeVertical, 2.22*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical ),
          child: Text(Info,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 4.1*SizeConfig.blockSizeHorizontal,
                fontWeight: FontWeight.w700, fontFamily: 'NunitoSans',
                //fontFamily:'Courgette',
                color:Colors.black87),
          ),
        ),
      ],

    ),
  );
}