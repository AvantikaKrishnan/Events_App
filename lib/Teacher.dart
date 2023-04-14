import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Add_Event.dart';
import 'package:project/displayEverything.dart';
import 'login.dart';



class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

late String nameofEvent = '';
late String doc = '';
late String datetime ='';
late String description ='';
late String image = '';
late String id = '';
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

    print(docIds);

    setState(() {
      allresults = data.docs;
    });
    searchResultList();
  }

  // Future getDocIds() async{
  //   await FirebaseFirestore.instance.collection('info').get().then((snapshot) => snapshot.docs.forEach((document) {
  //     print(document.reference);
  //     docIds.add(document.reference.id);
  //   }),
  //   );
  // }
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
        backgroundColor: Color(0xFFFFCFD2),
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
          padding: EdgeInsets.all(15.0),
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
              color: (index % 2 == 0) ? Color(0xFFF9DCC4): Color(0xFFFCD5CE),
              child:ListTile(
            hoverColor: Color(0xFFADE8F4),
            //  tileColor: Color(0xFFADE8F4),
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0) ,
              onTap: (){
                nameofEvent = resultList[index]['Name Of Event'];
                description = resultList[index]['Description'];
                image = resultList[index]['Image'];
                datetime = resultList[index]['Date and Time'].toDate().toString();
                id = resultList[index]['Id'].toString();




                Navigator.pushNamed(context, '/displayeverything');


              },

              title: Text(resultList[index]['Name Of Event']),
              subtitle: Text(resultList[index]['Date and Time'].toDate().toString()),
              trailing:  Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0),




              )
        );
    },
      )
      )
    ]
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => (add_Event())));
        },
        child: const Icon(Icons.add),
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