import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/link.dart';
import 'Teacher.dart';

late String image;
late String name_of_event;
late String description;
late Timestamp date;
late String link;

class DisplayEverything extends StatefulWidget {
  const DisplayEverything({Key? key}) : super(key: key);

  @override
  State<DisplayEverything> createState() => _DisplayEverythingState();
}

class _DisplayEverythingState extends State<DisplayEverything> {
  CollectionReference info = FirebaseFirestore.instance.collection('info');
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    showImage(img) {
      if (img == '') {
        return FadeInRight(
          duration: const Duration(milliseconds: 1500),
          child:Card(
              elevation: 30,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child:Container(
                height:  (MediaQuery.of(context).size.height)*0.7,
                width: (MediaQuery.of(context).size.width),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
        )
      )
        );


      } else {
        return FadeInRight(
          duration: const Duration(milliseconds: 1500),
          child: Card(
          elevation: 30,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
      child: Container(
              height:  (MediaQuery.of(context).size.height)*0.7,
              width: (MediaQuery.of(context).size.width),
      decoration: BoxDecoration(

            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(image: NetworkImage(img),fit: BoxFit.fill)
            ),
              ),
          )

        );
      }
    }
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
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/update');
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    info.doc(id).delete();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/teacher');
                  },
                  icon: const Icon(Icons.delete))
            ]),
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage('https://i.pinimg.com/736x/be/98/9c/be989cda0e5236d62efcd774032ea319.jpg'),fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future:
                    FirebaseFirestore.instance.collection('info').doc(id).get(),
                builder: (BuildContext context, snapshot) {
                  try {
                    if (snapshot.hasData) {
                      image = snapshot.data!['Image'];
                      name_of_event = snapshot.data!['Name Of Event'];
                      description = snapshot.data!['Description'];
                      date = snapshot.data!['Date and Time'];
                      link = snapshot.data!['link'];
                      final Uri _url = Uri.parse(link);
                      DateTime d = date.toDate();
                      String date1 = "${d.year}/${d.month}/${d.day}";
                      String date2 = "${d.hour}:${d.minute}";
                      return  Column(children: [
                          showImage(image),
                          FadeInUpBig(
                            duration: const Duration(milliseconds: 700),
                            delay: const Duration(milliseconds: 100),
                            child: Padding(

                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:Text(name_of_event,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                  FadeInUpBig(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 200),
                    child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                    alignment: Alignment.centerLeft,
                    child:Text(description,style: const TextStyle(fontSize: 20),),
                    )
                    ),
                  ),
                          const SizedBox(
                            height: 20,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(children: [
                            Column(children: [
                              SizedBox(
                                height:35,
                                width: 80,
                                child: Card(
                                  elevation:20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: FadeInUpBig(
                                        duration: const Duration(milliseconds: 800),
                                        delay: const Duration(milliseconds: 250),
                                        child: const Text('Date', textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              FadeInUpBig(duration: const Duration(milliseconds: 800),
                                  delay: const Duration(milliseconds: 300),child: Text(date1,style: const TextStyle(fontSize: 25))),
                            ],),
                            const SizedBox(width: 100,),
                            Column(children: [
                  SizedBox(
                  height:35,
                  width: 80,
                  child: Card(
                  elevation:20,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  ),
                  child:FadeInUpBig(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 250),
                      child: const Text('Time',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)))),
                              const SizedBox(
                                height: 20,
                              ),
                              FadeInUpBig(
                                  duration: const Duration(milliseconds: 800),
                                  delay: const Duration(milliseconds: 300),
                                  child: Text(date2,style: const TextStyle(fontSize: 25))),
                            ],),

                          ],),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                          FadeInUpBig(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 350),
                              child: const Text('Register Now!!!', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 15,),
                          FadeInUpBig(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 400),
                              child: Link(uri: _url, builder: (context, followLink) => ElevatedButton(onPressed: followLink, child: const Text('Open link')))),
                        ]);

                    } else {
                      return const Center(
                          child: Column(children: <Widget>[
                        SizedBox(
                          height: 300,
                        ),
                        CircularProgressIndicator(
                          value: 0.9,
                          color: Colors.blue,
                          backgroundColor: Colors.grey,
                        )
                      ]));
                    }
                  } catch (e) {
                    print(e);
                  }
                  return Container();
                }),
          ),
        ));
  }
}
