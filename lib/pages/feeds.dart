
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'uploadImage.dart';
import 'authentication.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'blog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Buidpost.dart';
import 'loading.dart';
class Feeds extends StatefulWidget {
String uid;
Feeds({this.uid});

  Auth auth = Auth();

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  Future<String> getCurrentUserId()async
  {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  User user = await _firebaseAuth.currentUser;

  return user.uid;
  }

bool loading =true;
  Build buildpost;


  List<Blog> bloglist =[];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    DatabaseReference postsref =  FirebaseDatabase.instance.reference().child("Post");
    postsref.once().then((DataSnapshot snap) async{
      var Keys = snap.value.keys;
      print(Keys);
      var Data=snap.value;
      print(Data);
      bloglist.clear();
      for(var individualKeys in Keys)
        {
         Blog blogs = Blog(
           Data[individualKeys]['uid'],
           individualKeys,
           Data[individualKeys]['image'],
           Data[individualKeys]['blog'],
           Data[individualKeys]['title'],
         Data[individualKeys]['liked'],
           Data[individualKeys]['profileurl'],
             Data[individualKeys]['username']);
         bloglist.add(blogs);
        }
      print(bloglist.length);



    }).whenComplete(() {
      setState(() {
        loading= false;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return loading ==true?Loading():Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
      SliverAppBar(
        floating:true  ,
        pinned:false,
        snap: true,
        title:Text(
              'Mrec Alumni',
              style: TextStyle(
                  wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                  fontFamily: 'NunitoSans',
                  fontSize: 6.9*SizeConfig.blockSizeHorizontal,

                  color: Colors.white,
                  letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
       centerTitle: true,
        shape:ContinuousRectangleBorder(
          borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(2*SizeConfig.blockSizeVertical),
              bottomRight: Radius.circular(2*SizeConfig.blockSizeVertical)
          ),
        ),
        backgroundColor: Color(0XFF00857C).withBlue(24460),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, color: Colors.white,size: 9.1*SizeConfig.blockSizeHorizontal,),
            color: Colors.white,
            onPressed:() {
              print(bloglist.length);
              Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>UploadPost()));
            },
          ),
        ],

    ),
            SliverList(delegate: SliverChildListDelegate(
                List<Build>.generate(bloglist.length, (index)
                {
                  print(bloglist[index].uid);
                 // print(widget.uid+"this is the user id maaaaaaaaaaaaaaaaaaaaaaaanhahah");
                  buildpost= Build(widget.uid,bloglist[index].uid,bloglist[index].key,bloglist[index].image,bloglist[index].blog,bloglist[index].title,bloglist[index].liked,bloglist[index].profileurl,bloglist[index].username);
                  return buildpost;})
                )
            )


          ]),


      drawer:Drawer(
    child: Container(
    color: Colors.white10,
      child: ListView(
        children: <Widget>[
          Padding(

            padding:  EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal,3.63*SizeConfig.blockSizeVertical,5.5*SizeConfig.blockSizeVertical,3.63*SizeConfig.blockSizeVertical),
            child: Text(
                'Mrec Alumni',
                style: TextStyle(
                    wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                    fontFamily: 'NunitoSans',
                    fontSize: 8*SizeConfig.blockSizeHorizontal,
                    fontWeight: FontWeight.w800,
                    color: Color(0XFF00857C).withBlue(24460),
                    letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
          ),
          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Mrec website',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.web,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/Placement_Details.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Announcements',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.record_voice_over,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: ()async {


              const url = 'hhttps://mrecexamcell.com/Login.aspx?ReturnUrl=%2f';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Results',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.library_books,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/Placement_Details.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Placements',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.outlined_flag,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,),
            ),
          ),

          InkWell(
            onTap: ()async {
              const url = 'http://www.mrec.ac.in/photogallery.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Events',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.account_balance,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap:()async {
              const url = 'http://www.mrec.ac.in/sac.html';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ListTile(
              title: Text(
                  'Clubs',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.music_note,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,),
            ),
          ),
          InkWell(
            onTap: (){

              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              widget.auth.signOut();
            },
            child: ListTile(
              title: Text(
                  'Log Out',
                  style: TextStyle(
                      wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                      fontFamily: 'NunitoSans',
                      fontSize: 5*SizeConfig.blockSizeHorizontal,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF00857C).withBlue(24460),
                      letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
              leading : Icon(Icons.devices_other,color: Color(0XFF00857C).withBlue(24460),size: 7*SizeConfig.blockSizeHorizontal,)
            ),
          ),
        ],
      ),
    ),
    ),

    );
  }


}