import 'pages/search.dart';
import 'pages/profile.dart';
import 'pages/notification.dart';
import 'package:flutter/material.dart';
import 'pages/editprofile.dart';
import 'pages/login.dart';
import 'pages/uploadImage.dart';
import 'pages/mapping.dart';
import 'pages/size.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}
class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
        builder: (context,constraints){

          return OrientationBuilder(
              builder: (context,orientation){
                SizeConfig().init(constraints, orientation);
                return  MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home :  MappingPage(),
                    color: Color(0XFF00857C).withBlue(24460),
                    routes:{

                      '/search':(context)=>Search(),
                      '/profile':(context)=>Profile(),
                      '/notification':(context)=> Notification1(),
                      '/login':(context)=>Login(),
                      '/uploadImage':(context)=>UploadPost(),
                      '/editprofile': (context)=>EditProfile(),

                    }
                );
              }
          );
        }
    );
  }
}