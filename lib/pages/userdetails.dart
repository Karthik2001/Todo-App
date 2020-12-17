import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreUser {
  String name;
  StoreUser(String name){
    this.name =name;
  }

String  storeUserDetails(User  user ,String email, String name ,String branch,String phoneNumber,String state,String schoolname,String skills,String worksat )
 {
   var data={
     'email':user.email,
     'uid':user.uid,
     'name':name.substring(0,1).toUpperCase()+ name.substring(1),
     'searchKey': name.substring(0,1).toUpperCase(),
     'branch':branch,
     'phone_number':phoneNumber,
     'state':state,
     "schoolname":schoolname,
     "skills":skills,
     "worksat":worksat,
   };
   try{ FirebaseFirestore.instance.collection('/userDetails').doc(name).set(data);
   return user.uid;
   }
   catch(e)
   {
     return null;
   }
 }
}