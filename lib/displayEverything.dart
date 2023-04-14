import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import 'Teacher.dart';
import 'UpdateEvent.dart';

class DisplayEverything extends StatefulWidget {
  const DisplayEverything({Key? key}) : super(key: key);

  @override
  State<DisplayEverything> createState() => _DisplayEverythingState();
}
showImage(img) {
  if (img == ''){
    return Center (
      child: ProfilePicture(
        name: nameofEvent ,
        radius: 80,
        fontsize: 45,
      ),
    );
  }
  else{
    ;        return Center (
      child: ProfilePicture(
        name: nameofEvent,
        radius: 80,
        fontsize: 45,
        img: image,
      ),
    );
  }
}

class _DisplayEverythingState extends State<DisplayEverything> {

  CollectionReference info = FirebaseFirestore.instance.collection('info');

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
            leading: BackButton(
                onPressed: () => {

                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Teacher()))
                }),

            backgroundColor: Color(0xFFF8AD9D),
         title: Text("About Event"),
          actions: <Widget>[
           IconButton(onPressed: (){

             Navigator.pop(context);
             Navigator.pushNamed(context, '/update');


           }, icon: Icon(Icons.edit)),
            IconButton(onPressed: (){
              info.doc(id).delete();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/teacher');



            }, icon: Icon(Icons.delete))

]
        ),

        body: SingleChildScrollView (
        child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget> [
                 const SizedBox(
                 height: 20,
                 ),
          showImage(image),
          const SizedBox(
            height: 50,
          ),
                     Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                         child:Text("Name of Event: " + nameofEvent, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
                         ),textAlign: TextAlign.start
                         )
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                     Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                         child:Text("About Event: ", style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                         ),textAlign: TextAlign.start

                         )

                     ),
                     Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                         child:Text(description, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                         ),textAlign: TextAlign.start

                         )

                     ),

                     const SizedBox(
                       height: 20,
                     ),

                     Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                         child:Text("Date and Time of Event: " + datetime, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold,

                         ),textAlign: TextAlign.start

                         )

                     ),




          ]

                 ),
        )
        );
  }
}
