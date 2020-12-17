
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'feeds.dart';
import 'search.dart';
import 'profile.dart';
import 'notification.dart';
import 'size.dart';
import 'authentication.dart';
class Home extends StatefulWidget {
  Home({
   this.auth,
   this.onSignedOut
});
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentTab=0;

  Future<String> getCurrentUserId()async
  {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
  User user = await _firebaseAuth.currentUser;

  return user.uid;
  }

  Widget currentScreen =Feeds();
   final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        backgroundColor: Colors.white,
        body:PageStorage(
          child : currentScreen,
          bucket :bucket,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 40,
          child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.fromLTRB(1.38*SizeConfig.blockSizeHorizontal,0.9*SizeConfig.blockSizeVertical,1.38*SizeConfig.blockSizeHorizontal,0.9*SizeConfig.blockSizeVertical,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1*SizeConfig.blockSizeVertical),
                  topRight: Radius.circular(1*SizeConfig.blockSizeVertical)
              ),
              color:Color(0XFF00857C).withBlue(24460),
            ),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      onPressed:() async {
                        String uid = await getCurrentUserId();
                        setState(()  {

                          print(uid+"this is a uid maaaaaaaaaaaaaaaaaaaaaaan");
                          if(currentTab!=0)
                          currentScreen=Feeds();

                          currentTab=0;
                        }
                        );
                        },
                      icon: Icon(
                          Icons.home,
                          color: currentTab==0?Colors.white:Colors.white70,
                          size:currentTab==0? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      color: Colors.white,
                      onPressed:(){
                        setState(() {
                          if(currentTab!=1)
                          currentScreen=Search();
                          currentTab=1;
                        });
                      },
                      icon: Icon(
                          Icons.search,
                          color: currentTab==1?Colors.white:Colors.white70,
                          size:currentTab==1? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      color: Colors.white,
                      onPressed:() async {
                        String uid = await getCurrentUserId();
                        print(uid+"nooooooooooo");
                        setState(() {
                         if(currentTab!=2)
                          currentScreen=Notification1(uid: uid);

                          currentTab=2;
                        });
                      },
                      icon: Icon(
                          Icons.notifications_none,
                          color: currentTab==2?Colors.white:Colors.white70,
                          size:currentTab==2? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: IconButton(
                      color: Colors.white,
                      onPressed:() async {
                        String uid = await getCurrentUserId();
                        if(currentTab!=3)
                        setState(() {

                          currentScreen=Profile(uid: uid);
                          currentTab=3;
                        });
                      },
                      icon: Icon(Icons.person_outline,
                          color: currentTab==3?Colors.white:Colors.white70,
                          size:currentTab==3? 9*SizeConfig.blockSizeHorizontal:5.5*SizeConfig.blockSizeHorizontal
                      )
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
