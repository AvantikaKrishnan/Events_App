import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'Teacher.dart';
import 'displayEverything.dart';

class updateEvent extends StatefulWidget {
  const updateEvent({Key? key}) : super(key: key);

  @override
  State<updateEvent> createState() => _updateEvent();
}

class _updateEvent extends State<updateEvent> {

  bool showSpinner = false;
  CollectionReference info = FirebaseFirestore.instance.collection('info');
  DateTime dateTime = DateTime(year,month,day,hour,min);

  display_image() {
    if (image == '') {
      return Card(
        elevation: 50,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        child: Center(
            child: Container(
              height:  (MediaQuery.of(context).size.height)*0.6,
              width: (MediaQuery.of(context).size.width),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(image: NetworkImage('https://t4.ftcdn.net/jpg/04/81/13/43/360_F_481134373_0W4kg2yKeBRHNEklk4F9UXtGHdub3tYk.jpg'),fit: BoxFit.fill)),
            )
        ),
      );
    }
    else {
      return Center(
          child: Card(
            elevation: 30,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              height:  (MediaQuery.of(context).size.height)*0.6,
              width: (MediaQuery.of(context).size.width),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fill)),
            ),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2,'0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    ImagePicker imagePicker = ImagePicker();

    return ModalProgressHUD (
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => {
                 Navigator.popUntil(context, ModalRoute.withName('/teacher'))
                  }),
          backgroundColor: Colors.transparent,
          title: const Text('Update Event'),
        ),
        body: SingleChildScrollView (
          child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                display_image(),
                Center (
                  child: IconButton(onPressed:() async{
                    XFile? file = await imagePicker.pickImage(source:ImageSource.gallery);
                    print('${file?.path}');
                    if(file == null) {
                      print ('DID NOT WORK');
                      return;
                    }

                    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                    Reference referanceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = referanceRoot.child('images');
                    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                    setState(() {
                      showSpinner = true;
                    });

                    try{
                      await referenceImageToUpload.putFile(File(file!.path));
                      image = await referenceImageToUpload.getDownloadURL();
                    }
                    catch (error){

                    }
                    setState(() {
                      showSpinner = false;
                    });

                  }, icon:  const Icon(Icons.camera_alt)),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Name of Event',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
                ),

                TextField(
                  controller:
                  TextEditingController(text: name_of_event),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color:Color(0xFF006D77),),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFF0096C7)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value){
                    name_of_event = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Description',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
                ),
                TextField(
                  controller:
                  TextEditingController(text: description),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFF006D77)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color(0xFF0096C7)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 15),
                  maxLines: 50,
                  minLines: 2,
                  onChanged: (value){
                    description = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Link',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
                ),
                TextField(
                  controller:
                  TextEditingController(text: link),
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color(0xFF006D77)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color(0xFF0096C7)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value){
                    link = value;
                  },
                ),
                const SizedBox(height: 20,),
                Row(children: [
                  const Text('Select Date: ',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )

                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () async{
                      final date = await pickDate();
                      if(date == null)
                        return;
                      final newDateTime = DateTime(
                        date.year,
                        date.month,
                        date.day,
                        dateTime.hour,
                        dateTime.minute,
                      );

                      setState(() {
                        dateTime = newDateTime;
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF006D77),),
                    child: Text('${dateTime.year}/${dateTime.month}/${dateTime.day}'),
                  ),
                ],),

                const SizedBox(
                  height: 40,
                ),
                Row(children: [
                  const Text('Select Time: ',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () async{


                      final time = await pickTime();
                      if(time == null)
                        return;
                      final newDateTime = DateTime(
                        dateTime.year,
                        dateTime.month,
                        dateTime.day,
                        time.hour,
                        time.minute,
                      );
                      setState(() {
                        dateTime = newDateTime;
                      });
                    }, style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF006D77),),
                    child: Text('$hours:$minutes'),
                  ),
                ],),

                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () async{



                  await info.doc(id).update({
                    'Name Of Event' : name_of_event,
                    'Description' : description,
                    'Image' : image,
                    'Date and Time' : dateTime,
                    'Id' : id,

                  }).then((value){
                    const snackBar = SnackBar(
                        content: Text('Updated'),
                    );

                  });

                  Navigator.pop(context);
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Teacher()));

                //  Navigator.popUntil(context, ModalRoute.withName('/teacher'));
                },style: ElevatedButton.styleFrom(
                primary: Color(0xFF0096C7),),
                    child: Text('Submit'),
                ),
              ]


          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(context: context, initialDate: dateTime, firstDate:DateTime(1900), lastDate: DateTime(2100),);

  Future<TimeOfDay?> pickTime() => showTimePicker(context: context, initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),);
}
