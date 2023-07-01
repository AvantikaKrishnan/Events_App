import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}
late String nameofEvent = '';
late String doc = '';
late String datetime ='';
late String description ='';
late String image = '';
late String id = '';
late Timestamp t ;


class _StudentState extends State<Student> {
  final myController = TextEditingController();
  List allresults = [];
  List resultList = [];


  List<String> docIds = [];

  getInfoStream () async{
    var data = await FirebaseFirestore.instance.collection('info').orderBy('Description').get();
    for (var ids in data.docs){
      docIds.add(ids.reference.id);
    }

    print(docIds);

    setState(() {
      allresults = data.docs;
    });
    searchResultList();
  }
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies(){
    getInfoStream();
    super.didChangeDependencies();
  }
  void _printLatestValue() {
    print('Second text field: ${myController.text}');
    searchResultList();
  }
  display2(){
    var showResults = [] ;
  }

  searchResultList(){
    var showResults = [] ;
    if(myController.text != "")
    {
      for(var InfoSnapshot in allresults)
      {
        var name = InfoSnapshot['Name Of Event'].toString().toLowerCase();
        var desc = InfoSnapshot['Description'].toString().toLowerCase();
        var t = InfoSnapshot['Date and Time'].toDate().toString().toLowerCase();
        var img = InfoSnapshot['Image'].toString().toLowerCase();

        if(name.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);
        }
        else if(t.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);
        }
        else if(desc.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);
        }
        else if(img.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);
        }
      }
    }
    else
    {
      showResults = List.from(allresults);
    }
    setState(() {
      resultList = showResults;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName('/welcome_student'))
        ),
        backgroundColor: Colors.transparent,
        title: const Text("Student"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Column(

          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              child:CupertinoSearchTextField(
                controller: myController,
              ),
            ),
            Expanded (
                child: ListView.builder(
                  itemCount: resultList.length,
                  itemBuilder: (context,index)
                  {
                    return  Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 1.0,
                            color: (index % 2 == 0) ? const Color(0xFF184E77): const Color(0xFF168AAD),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child:ListTile(
                          hoverColor: const Color(0xFFADE8F4),
                          //  tileColor: Color(0xFFADE8F4),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0) ,
                          onTap: (){
                            nameofEvent = resultList[index]['Name Of Event'];
                            description = resultList[index]['Description'];
                            image = resultList[index]['Image'];
                            datetime = resultList[index]['Date and Time'].toDate().toString();
                            id = resultList[index]['Id'].toString();

                            Navigator.pushNamed(context, '/display_student');
                          },
                          title: Text(resultList[index]['Name Of Event']),
                          subtitle: Text("${resultList[index]['Date and Time'].toDate().day}/${resultList[index]['Date and Time'].toDate().month}/${resultList[index]['Date and Time'].toDate().year}"),
                          trailing:  const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),




                        )
                    );
                  },
                )
            )
          ]
      ),

    );



  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}