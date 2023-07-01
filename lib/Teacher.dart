import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Add_Event.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});
  @override
  State<Teacher> createState() => _TeacherState();
}
var year;
var month;
var day;
var hour;
var min;
String id = '';
String nameOfEvent = '';
String img = '';
String desc = '';
String ln = '';
late Timestamp Dt;
late Timestamp t ;

class _TeacherState extends State<Teacher> {
  final myController = TextEditingController();
  List allresults = [];
  List resultList = [];
  List<String> docIds = [];

  getInfoStream () async{
    var data = await FirebaseFirestore.instance.collection('info').orderBy('Description').get();
    for (var ids in data.docs){
      docIds.add(ids.reference.id);
    }
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
    myController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    getInfoStream();
    super.didChangeDependencies();
  }

  void _printLatestValue() {
    searchResultList();
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

       if(t.contains(myController.text.toLowerCase()))
      {
         showResults.add(InfoSnapshot);
       }
        if(desc.contains(myController.text.toLowerCase()))
        {
          showResults.add(InfoSnapshot);
        }
        if(img.contains(myController.text.toLowerCase()))
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
                Navigator.popUntil(context, ModalRoute.withName('/welcome'))
        ),
        backgroundColor: Colors.transparent,
        title: const Text("Teacher"),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0) ,
              onTap: (){
                id = resultList[index]['Id'].toString();
                nameOfEvent = resultList[index]['Name Of Event'].toString();
                desc = resultList[index]['Description'].toString();
                img = resultList[index]['Image'].toString();
                ln = resultList[index]['link'].toString();
                Dt = resultList[index]['Date and Time'];
                DateTime d = Dt.toDate();
                 year = d.year;
                 month= d.month;
                 day = d.day;
                 hour = d.hour;
                 min = d.minute;
                Navigator.pushNamed(context, '/displayeverything');
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => (const add_Event())));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),),);
    Navigator.popUntil(context, ModalRoute.withName("/"));
  }
}