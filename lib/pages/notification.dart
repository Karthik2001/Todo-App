import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:url_launcher/url_launcher.dart';
import 'size.dart';
import 'loading.dart';
import 'package:firebase_database/firebase_database.dart';
import 'BuildNotification.dart';
class Notification1 extends StatefulWidget {
  String uid;
  Notification1({this.uid});

  Auth auth = Auth();
  @override
  _Notification1State createState() => _Notification1State();
}


class _Notification1State extends State<Notification1> {
  int liked=0;
  bool loading =true;
  BuildNotification buildNotification ;
  List<String> likedbylist =[];
  List<String> imageList=[];
  List<String> titleList=[];
  List<String> uidList=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.uid+'aslx;s');

    DatabaseReference IDsref =  FirebaseDatabase.instance.reference().child("Users").child(widget.uid).child("Post");
    DatabaseReference user =  FirebaseDatabase.instance.reference().child("Users");
    IDsref.once().then((DataSnapshot snap) async {
      var Keys = snap.value.keys;
      var Data=snap.value;

      print(Keys);
      likedbylist.clear();

      titleList.clear();

      for(var individualKeys in Keys)
      { //print(individualKeys);
      var title=Data[individualKeys]["title"];
      print(title);


     print("here");
     await IDsref.child(individualKeys).child("likedby").once().then((DataSnapshot data) async {print("scszc");

          var uid = data.value.keys;


          for(var id in uid)
            {

              await user.child(id).once().then((DataSnapshot s)  async {
              print(s.value.keys);
              var d= s.value;
              print(d['userdetails']['profileurl']);
                imageList.add(d['userdetails']['profileurl']);
                likedbylist.add(d['userdetails']['name']);
              uidList.add(id);
              print(imageList);
            });


           titleList.add(title);

           // print(person);
//            print(likedbylist.length.toString()+"bshdaj");
            }
        });
      }
      print(titleList);
    }).whenComplete(() {
      print(likedbylist);
      print(imageList.length);
      print('fsd');
      setState(() {
if(imageList.length==likedbylist.length)
        loading=false;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return loading==true?Loading():Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
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
                    Navigator.pushNamed(context,'/uploadImage');
                  },
                ),
              ],

            ),

            SliverList(
                delegate: SliverChildListDelegate(

                    List.generate(likedbylist.length, (index)
                {
                  buildNotification= BuildNotification(likedbylist[index],titleList[index],imageList[index],uidList[index]);
                  return buildNotification;})
            ))
          ]),


      drawer:Drawer(
        child: Container(
          color: Colors.white10,
          child: ListView(
            children: <Widget>[
              Padding(

                padding:  EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal,3.6*SizeConfig.blockSizeVertical,5.5*SizeConfig.blockSizeHorizontal,3.6*SizeConfig.blockSizeVertical),
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

