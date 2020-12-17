

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'size.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'authentication.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'home.dart';
import 'loading.dart';
import 'package:uuid/uuid.dart';



    class UploadPost extends StatefulWidget {
      final Auth auth = Auth();


      @override
      _UploadPostState createState() => _UploadPostState();
    }

    class _UploadPostState extends State<UploadPost> {

      bool loading = false;
      File sampleImage;
      String _myvalue,_blog;
      String _url;
      String Username='';
      String Uid='';


      final formKey = GlobalKey<FormState>();
      Future getImage()async{

        var tempimage =await ImagePicker.pickImage(source:ImageSource.gallery,imageQuality: 50);
        setState(() {
          sampleImage=tempimage;
        });
      }
       bool validateAndSave(){
        final form= formKey.currentState;
        if(form.validate()){
          form.save();
          return true;
        }
        else{
          return false;
        }
       }
       void uploadImage() async{
        if(validateAndSave())
          {



            final StorageReference postImageRef= FirebaseStorage.instance.ref().child("Post Images");
            var timekey = DateTime.now();
            final StorageUploadTask uploadTask =postImageRef.child(timekey.toString()+".jpg").putFile(sampleImage);
            var Imageurl = await (await uploadTask.onComplete).ref.getDownloadURL();
            _url = Imageurl.toString();
            saveToDatabase(_url);


          }
       }

       void gotoHome(){
         Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>Home()));
         Fluttertoast.showToast(
           msg: "Blog Uploaded",
           //backgroundColor: Colors.black87,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 3,
         );
       }

      Future<String> getCurrentUsername()async
      {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
        User user = await _firebaseAuth.currentUser;

        return user.displayName;
      }
      Future<String> getCurrentUserid()async
      {final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
      User user = await _firebaseAuth.currentUser;

      return user.uid;
      }
       void saveToDatabase(url){
         var dbTimeKey = DateTime.now();
         var formatDate= DateFormat('MMM d,yyyy');
         var formatTime= DateFormat('EEEE, hh:mm aaa');
         String date=formatDate.format(dbTimeKey);
         String time=formatTime.format(dbTimeKey);
         String uuid = Uuid().v4();
         String uname;
         String profileurl;
         DatabaseReference dbref = FirebaseDatabase.instance.reference();
          dbref.child("Users").child(Uid).child("userdetails").once().then((DataSnapshot snap) async {
           var Keys = snap.value.keys;
           print(Keys);
           var Data = snap.value;
           print(Data);
              uname =Data["name"];
              profileurl=Data["profileurl"];
              print(uname);
              //  print(url);
             //print(individualKeys);



           //print(Keys);

         }).whenComplete(() {

            var data={
              "username":uname,
              "image":url,
              "uid":Uid,
              "title":_myvalue,
              "blog":_blog,
              "date":date,
              "time":time,
              "liked": 0.toString(),
              "id":uuid,
              "profileurl":profileurl,

            };
            dbref.child("Post").child(uuid).set(data).whenComplete((){

              setState(() {
                loading= false;

              });
              dbref.child("Users").child(Uid).child("Post").child(uuid).set(data);

              gotoHome();
            });

          });



       }

      @override
      Widget build(BuildContext context) {
        return loading?Loading():Scaffold(
          resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color(0XFF00857C).withBlue(2446),
            body: Column(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.fromLTRB(5.5*SizeConfig.blockSizeHorizontal,3.3*SizeConfig.blockSizeVertical,2.7*SizeConfig.blockSizeHorizontal,1*SizeConfig.blockSizeVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                            'New ',
                            style: TextStyle(
                                wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                                fontFamily: 'NunitoSans',
                                fontSize: 5.9*SizeConfig.blockSizeHorizontal,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
                        Text(
                            'Blog',
                            style: TextStyle(
                                wordSpacing: 1.6*SizeConfig.blockSizeHorizontal,
                                fontFamily: 'NunitoSans',
                                fontSize: 5.9*SizeConfig.blockSizeHorizontal,
                               // fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5*SizeConfig.blockSizeHorizontal)),
                      ],),

                      IconButton(

                        icon: Icon(Icons.near_me, color: Colors.white,size: 7.3*SizeConfig.blockSizeHorizontal,),
                        color: Colors.white,
                        onPressed:() async {
                          String Uid1 = await getCurrentUserid();
                          setState(()  {
                            Uid=Uid1;
                            loading =true;
                          });
                          uploadImage();


                         // widget.auth.signOut();
                        },
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child:
                  Expanded(
                    child: Container(
                      // height: MediaQuery.of(context).size.height -74,
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(3.6*SizeConfig.blockSizeVertical),topRight: Radius.circular(3.6*SizeConfig.blockSizeVertical)),
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
                            height: 34*SizeConfig.blockSizeVertical,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                                  topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
                                  bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                                  bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
                              ),
                              color: Colors.white70,


                            ),
                            child: sampleImage==null?selectImage():Padding(
                              padding:  EdgeInsets.fromLTRB(0,3.2*SizeConfig.blockSizeVertical,0,3.2*SizeConfig.blockSizeVertical),
                              child: Image.file(sampleImage,height: 34*SizeConfig.blockSizeVertical,width:100*SizeConfig.blockSizeHorizontal,fit: BoxFit.scaleDown),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 1.8*SizeConfig.blockSizeVertical,left:2.7*SizeConfig.blockSizeHorizontal,right:2.7*SizeConfig.blockSizeHorizontal),
                            // height:10 ,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.6*SizeConfig.blockSizeVertical),
                                  topRight:Radius.circular(3.6*SizeConfig.blockSizeVertical),
                                  bottomLeft: Radius.circular(3.6*SizeConfig.blockSizeVertical),
                                  bottomRight: Radius.circular(3.6*SizeConfig.blockSizeVertical)
                              ),
                              color: Colors.grey[300].withOpacity(0.7),
                            ),
                            child:  Material(
                              borderRadius: BorderRadius.circular(2.7*SizeConfig.blockSizeVertical),
                              color: Colors.grey[200].withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                                child: TextFormField(
                                  validator: (value){
                                    return value.isEmpty?'Title is required':null;
                                  },
                                  onSaved: (value){
                                    return _myvalue=value;

                                  },
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v){
                                    FocusScope.of(context).nextFocus(); // move focus to next
                                  },
                                  maxLengthEnforced:false ,
                                  // maxLines: 3,
                                  autocorrect: true,
                                  autofocus: true,
                                  decoration: InputDecoration(hintText: ' Title',
                                  ),
                                ),
                              ),
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.only(top: 1.8*SizeConfig.blockSizeVertical,left:2.7*SizeConfig.blockSizeHorizontal,right:2.7*SizeConfig.blockSizeHorizontal),

                            height: 20.454*SizeConfig.blockSizeVertical,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.6*SizeConfig.blockSizeVertical),
                                  topRight:Radius.circular(3.6*SizeConfig.blockSizeVertical),
                                  bottomLeft: Radius.circular(3.6*SizeConfig.blockSizeVertical),
                                  bottomRight: Radius.circular(3.6*SizeConfig.blockSizeVertical)
                              ),
                              color: Colors.grey[300].withOpacity(0.7),
                            ),
                            child:  Material(
                              borderRadius: BorderRadius.circular(2.7*SizeConfig.blockSizeVertical),
                              color: Colors.grey[200].withOpacity(0.4),
                              elevation: 0.0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                                child: TextFormField(
                                  validator: (value){
                                    return value.isEmpty?'Blog Content is required':null;
                                  },
                                  onSaved: (value){
                                    return _blog=value;

                                  },
                                  maxLengthEnforced:true ,
                                 maxLines: 5,
                                  autocorrect: true,
                                  autofocus: true,
                                  decoration: InputDecoration(hintText: '  Blog Content',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:109*SizeConfig.blockSizeVertical),
                        ],
                      ),
                    ),
                  ),

                ),


              ],
            ),


        );
      }

      Widget selectImage(){
        return Container(
          margin: EdgeInsets.only(top: 2*SizeConfig.blockSizeVertical,left:1.38*SizeConfig.blockSizeHorizontal,right: 1.38*SizeConfig.blockSizeHorizontal),
          height: 34*SizeConfig.blockSizeVertical,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                topRight:Radius.circular(1.68*SizeConfig.blockSizeVertical),
                bottomLeft: Radius.circular(1.68*SizeConfig.blockSizeVertical),
                bottomRight: Radius.circular(1.68*SizeConfig.blockSizeVertical)
            ),
            color: Colors.white70,

          ),
        child: Center(
          child:   FlatButton(
            child:Text(' Tap to Select Image ',style :TextStyle(fontFamily:'NunitoSans',fontSize:5.88*SizeConfig.blockSizeHorizontal,color:Colors.black87)),
            color:Colors.white,
            onPressed: getImage,
          ),
        ),);

      }

    }