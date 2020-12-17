
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrec_appp/pages/loading.dart';
import 'SearchService.dart';
import 'ViewProfile.dart';
import 'size.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var queryResultSet=[];
  var tempSearchStore=[];
  var temp=[];
  var uidList=[];
  initiateSearch(value)  {
    if(value.length==0)
   setState(() {
     queryResultSet=[];
     tempSearchStore=[];
     temp=[];
   });
else{
      var capitalizedValue = value.substring(0,1).toUpperCase()+ value.substring(1);

      if(queryResultSet.length==0 && value.length ==1)
      {

        SearchService().searchByName(value).then((QuerySnapshot docs) {
         // print(docs);
          for(int i=0; i<docs.docs.length;i++)
          { print(docs.docs[i].data());
          print("here");

          queryResultSet.add(docs.docs[i].data());

          }
          if (docs.docs.length >0)
            {
             setState(() {
               queryResultSet.forEach((element) {
                 print(capitalizedValue);
                 if(element['name'].startsWith(capitalizedValue)){
                   setState(() {
                     print("sjsj");
                     temp.add(element['name']);
                     uidList.add(element['uid']);
                   });
                 }});

              });
            }
        });

      }
      else{
        tempSearchStore=[];

        queryResultSet.forEach((element) {
          print(capitalizedValue);
          if(element['name'].startsWith(capitalizedValue)){
            setState(() {
              print("sjsj");
              tempSearchStore.add(element['name']);
              uidList.add(element['uid']);
            });
          }});
        setState(() {
          temp= tempSearchStore.map((e) {
            return e['name'];
          }).toList();
        });


        print(tempSearchStore);

      }

    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.only(top: 3*SizeConfig.blockSizeVertical,left:2.7*(SizeConfig.blockSizeHorizontal),right:2.7*(SizeConfig.blockSizeHorizontal)),
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
          child:
          ListView(
            shrinkWrap: true,
            children :<Widget>[ Material(
              borderRadius: BorderRadius.circular(2.7*SizeConfig.blockSizeVertical),

              color: Colors.grey[200].withOpacity(0.4),

              elevation: 0.0,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical,2.2*SizeConfig.blockSizeHorizontal,1.45*SizeConfig.blockSizeVertical),
                child: TextFormField(

                  onChanged: (value){
                    initiateSearch(value);


                  },
                  maxLengthEnforced:false ,
                  // maxLines: 3,
                  autocorrect: true,
                 // autofocus: true,
                  decoration: InputDecoration(hintText: ' Search',
                    icon:Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.9*SizeConfig.blockSizeVertical),
      ListView.builder(
        shrinkWrap: true,
          itemCount: temp.length,
          itemBuilder:  (context, index) {


            return ListTile(

              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ViewProfile(uidList[index])));
              },
              title: Text(temp[index]),
            );
          },)

            ]),
          ),
        );


  }

}
