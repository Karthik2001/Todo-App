import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService{
  searchByName(String searchFeild) {
    print(searchFeild);
    return  FirebaseFirestore.instance.collection('userDetails').where('searchKey',isEqualTo: searchFeild.substring(0,1).toUpperCase()).get();
  }
}