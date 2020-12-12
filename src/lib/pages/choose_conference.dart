import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hello/authenticate/firestoreService.dart';
import 'package:hello/authenticate/locator.dart';
import 'package:hello/classes/conference.dart';

class ChooseConference extends StatefulWidget {
   

  @override
  _ChooseConference createState() => _ChooseConference();
}

class _ChooseConference extends State<ChooseConference> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Conferences'),
          centerTitle: true,
        ),
        body: ListPage(),
          
         
        );
  }
}



class ListPage extends StatefulWidget {
   
  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  Future<void> getConferences() async {
    var dbref=FirebaseFirestore.instance;
    QuerySnapshot queryConfs= await dbref.collection("conference").get();
    return queryConfs.docs;
  }


  navigateToDetail(DocumentSnapshot conference){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>ConferencePage(conference:conference) ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getConferences(),
        builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: Text("Loading..."),);
        }else{
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder:(_,index){
              return ListTile(
                title:Text(snapshot.data[index]["name"]),
                onTap: (){ 
                  locator<FirestoreService>().setUserConference(snapshot.data[index].documentID,FirebaseAuth.instance.currentUser.uid );
                  sleep(Duration(milliseconds: 500));
                  Navigator.pop(context);
                });
            } ,);
        }
      }),);
  }

}

 

class ConferencePage extends StatefulWidget {
   
  final DocumentSnapshot conference;
  ConferencePage({this.conference});

  @override
  _ConferencePage createState() => _ConferencePage();
}

class _ConferencePage extends State<ConferencePage> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.conference["name"]),
          centerTitle: true,
        ),
        body: 
         Column(
           children: [
             Padding(
              padding: EdgeInsets.all(16.0),
              child:
              Text(
                'Talks',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[300]),
                textScaleFactor: 1.4, 
              )
             )
             ,
              ListTalks(conference: widget.conference)],
           
         )
         
        );
  }
  
}




class ListTalks extends StatefulWidget {
  final DocumentSnapshot conference;
   ListTalks({this.conference});
  @override
  _ListTalks createState() => _ListTalks();
}

class _ListTalks extends State<ListTalks> {
  Future<void> getTalks() async {
    var dbref=FirebaseFirestore.instance;
    QuerySnapshot queryTalks= await dbref.collection("talks")/*.where('conference', isEqualTo: ('conference/'+widget.conference.id ))*/.get();
    
    return queryTalks.docs;
  }


  navigateToDetail(DocumentSnapshot conference){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>ConferencePage(conference:conference) ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getTalks(),
        builder: (_,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: Text("Loading..."),);
        }else{
          print('hello');
          return ListView.builder(
            itemCount: snapshot.data.length,

            itemBuilder:(_,index){
              return ListTile(
                
                title:Text(snapshot.data[index]["name"]));
                //onTap: ()=> navigateToDetail(snapshot.data[index]));
            } ,);
        }
      }),);
  }
}
 