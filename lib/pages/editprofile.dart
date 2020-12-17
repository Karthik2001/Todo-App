
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'size.dart';

import 'home.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'loading.dart';
class EditProfile extends StatefulWidget {

  String uid,school,name,skills,company,status,branch,url,email,phoneNUmber;

  EditProfile({this.uid,this.school,this.name,this.url,this.phoneNUmber,this.email,this.skills,this.company,this.status,this.branch});
  @override
  _EditProfileState createState() => _EditProfileState();
}
enum Branch1{
  CSE,ECE,MECH,CIVIL,IT,EEE
}

enum Status{
  Student,
  Alumni,
  Faculty,
}


class _EditProfileState extends State<EditProfile> {
  final formKey1= GlobalKey<FormState>();
  File sampleImage;
  String email="";
  String _url="";
  String password ="";
  String name ="";
  String branch ="CSE";
  String state ="Student";
  String phoneNumber="" ,schoolname="",skills="",worksat="";

  bool loading =false;
  Future getImage()async{

    final tempimage =await ImagePicker().getImage(source:ImageSource.gallery,imageQuality: 30);
    setState(() {
      sampleImage=File(tempimage.path);
    });
  }
  bool validateAndSave(){
    final form= formKey1.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }
  void gotoHome(){
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>Home()));
    Fluttertoast.showToast(
      msg: "Profile Updated",
      //backgroundColor: Colors.black87,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
    );
  }
  void uploadImage(String Username) async{
    if(validateAndSave())
    {  if (sampleImage!=null){
      final StorageReference postImageRef= await FirebaseStorage.instance.ref().child("Profilepics");

      final StorageUploadTask uploadTask = await postImageRef.child(Username+".jpg").putFile(sampleImage);
      var Imageurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      _url = Imageurl.toString();}
      saveToDatabase(sampleImage!=null?_url:widget.url);
      print("Done");



    }
  }
  Future<void> saveToDatabase(url) async {


    DatabaseReference dbref =  FirebaseDatabase.instance.reference();
    dbref.child("Users").child(widget.uid).once().then((DataSnapshot snap) {
      var Keys = snap.value.keys;
      print(Keys);
      var Data=snap.value;

        email= Data['userdetails']['email'];

    });

    var data={
      "name":name,
      "branch":branch,
      "phoneNumber":phoneNumber,
      "state":state,
      "email":widget.email,
      "profileurl":url,
      "schoolname":schoolname,
      "skills":skills,
      "worksat":worksat,

    };

    dbref.child("Users").child(widget.uid).child("userdetails").set(data).whenComplete(() {
      setState(() {
        loading=false;
        gotoHome();
      });
    });




  }

  @override
  Widget build(BuildContext context) {
    return loading==true?Loading():Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(4.16*SizeConfig.blockSizeHorizontal,2.7*SizeConfig.blockSizeVertical,4.16*SizeConfig.blockSizeHorizontal,2.7*SizeConfig.blockSizeVertical ),
        child: Form(
          key:formKey1,
          child: ListView(
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                SizedBox(height: 8.3*SizeConfig.blockSizeVertical),

                Text('Mrec Alumini ',textAlign: TextAlign.center,style: TextStyle(fontSize: 8.33*SizeConfig.blockSizeHorizontal,fontFamily:'NunitoSans',color:Colors.black87),),

                SizedBox(height: 2.72*SizeConfig.blockSizeVertical),
              FlatButton(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 10*SizeConfig.blockSizeVertical,
                  backgroundImage:sampleImage==null? NetworkImage(widget.url):FileImage(sampleImage),
                  //sampleImage==null? Image.asset('images/mrec_logo.jpg'):Image.file(sampleImage),
                ),
                onPressed: getImage,
              ),
              SizedBox(height: 2.72*SizeConfig.blockSizeVertical),

              TextFormField(
                decoration:InputDecoration(labelText:'Name'),
               initialValue: widget.name,
                textInputAction: TextInputAction.next,
               onFieldSubmitted: (v){
                 FocusScope.of(context).nextFocus(); // move focus to next
               },
               // autocorrect: true,
                validator: (value) {
                  return value.isEmpty?'Please enter your name ':null;
                },
                onSaved: (value) {
                  setState(() {
                    name=value;
                  });

                },
              ),

                SizedBox(height:0.9*SizeConfig.blockSizeVertical),








                TextFormField(
                  decoration:InputDecoration(labelText:'Phone Number'),
                 // autocorrect: true,
                  initialValue: widget.phoneNUmber,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v){
                    FocusScope.of(context).nextFocus(); // move focus to next
                  },
                  validator: (value) {
                    return value.length==10?null:'Phone number  is required ';
                  },
                  onSaved: (value) {
                    setState(() {
                      phoneNumber=value;
                    });

                  },
                ),

                SizedBox(height:0.9*SizeConfig.blockSizeVertical),


              TextFormField(
                decoration:InputDecoration(labelText:'School Name'),
                initialValue: widget.school,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v){
                  FocusScope.of(context).nextFocus(); // move focus to next
                },
                //autocorrect: true,
                validator: (value) {
                  return value.isEmpty?'Please enter your school name ':null;
                },
                onSaved: (value) {
                  setState(() {
                    schoolname=value;
                  });

                },
              ),


              SizedBox(height:0.9*SizeConfig.blockSizeVertical),


              TextFormField(
                decoration:InputDecoration(labelText:'Skills'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v){
                  FocusScope.of(context).nextFocus(); // move focus to next
                },
                initialValue: widget.skills,
                //autocorrect: true,
                validator: (value) {
                  return value.isEmpty?'Please enter your Skills ':null;
                },
                onSaved: (value) {
                  setState(() {
                    skills=value;
                  });

                },
              ),
              SizedBox(height:0.9*SizeConfig.blockSizeVertical),


              TextFormField(
                decoration:InputDecoration(labelText:'Company Name /College Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v){
                  FocusScope.of(context).nextFocus(); // move focus to next
                },
                initialValue: widget.company,
                //autocorrect: true,
                validator: (value) {
                  return value.isEmpty?'Please enter your Comapny name ':null;
                },
                onSaved: (value) {
                  setState(() {
                    worksat=value;
                  });

                },
              ),

              SizedBox(height:0.9*SizeConfig.blockSizeVertical),
              TextFormField(
                decoration:InputDecoration(labelText:'Student/Passed Out/Faculty'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v){
                  FocusScope.of(context).nextFocus(); // move focus to next
                },
               initialValue: widget.status,
               // autocorrect: true,
                validator: (value) {

                  return value.isEmpty?'Please enter your role ':value=='Student'||value=='Passed Out'||value=='Faculty'?null:'Please Enter either Student/Passed Out/Faculty';

                },
                onSaved: (value) {
                  setState(() {
                    state=value;
                  });

                },
              ),
              TextFormField(
                decoration:InputDecoration(labelText:'CSE/IT/ECE/EEE/MECH/CIVIL'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v){
                    setState(() {
                      uploadImage(widget.uid);
                    });// move focus to next
                },
               initialValue: widget.branch,
               // autocorrect: true,
                validator: (value) {

                  return value.isEmpty?'Please enter your branch ':value=='CSE'||value=='IT'||value=='ECE'||value=='EEE'||value=='MECH'||value=='CIVIL'?null:'Please Enter either Student/Passed Out/Faculty';

                },
                onSaved: (value) {
                  setState(() {
                    branch=value;
                  });

                },
              ),




              Padding(
                padding:  EdgeInsets.fromLTRB(2.22*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.22*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                child: RaisedButton(
                  child:Text('Update profile',style :TextStyle(fontSize:3.8*SizeConfig.blockSizeHorizontal,color:Colors.white)),
                  color:Colors.blueAccent,
                  onPressed: ((){

                    setState(() {
                      loading =true;
                      uploadImage(widget.uid);
                    });


                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

