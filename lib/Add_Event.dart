import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'Teacher.dart';


class add_Event extends StatefulWidget {
  const add_Event({Key? key}) : super(key: key);

  @override
  State<add_Event> createState() => _add_Event();
}

class _add_Event extends State<add_Event> {

  late String desc;
  late String imageUrl='';
  late String nameofEvent = '';
  late String description = '';
  late String link = '';
  bool showSpinner = false;
  CollectionReference info = FirebaseFirestore.instance.collection('info');
  DateTime dateTime = DateTime(2023,12,24,5,30);

  // @override
  // void initState() {
  //   imageUrl;
  //   display_image();
  //   super.initState();
  // }


  display_image() {
    if (imageUrl == '') {
      return Center(
        child: Container(
          height:  (MediaQuery.of(context).size.height)*0.6,
          width: (MediaQuery.of(context).size.width),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: NetworkImage('https://t4.ftcdn.net/jpg/04/81/13/43/360_F_481134373_0W4kg2yKeBRHNEklk4F9UXtGHdub3tYk.jpg'),fit: BoxFit.fill)),
        )
      );
    }
    else {
    return Center(
        child: Container(
          height:  (MediaQuery.of(context).size.height)*0.6,
          width: (MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.fill)),
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
                Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Teacher()))
              }),
          backgroundColor: Colors.transparent,
          title: const Text('Add Event'),
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
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  }
                  catch (error){
                    print('Error with Image');
                  }
                  setState(() {
                    showSpinner = false;
                  });
                }, icon:  Icon(Icons.camera_alt)),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('Name of Event',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
              ),

              TextField(
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
                  nameofEvent = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('Description',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
              ),
              TextField(

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
                style: const TextStyle(fontSize: 25),
                maxLines: 50,
                minLines: 2,
                onChanged: (value){
                  description = value;
                  print(description);
                },
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('Add Google form link',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
              ),

              TextField(
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
              const SizedBox(
                height: 40,
              ),
                 Row(children: [
                   const Text('Select Date: ',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
                   ),
                   SizedBox( width: 20,),
                   ElevatedButton(
                     child: Text('${dateTime.year}/${dateTime.month}/${dateTime.day}'),
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
                     }, style: ElevatedButton.styleFrom(
                     primary: Color(0xFF006D77),
                   ),
                   ),
                 ],),
              const SizedBox(
                height: 40,
              ),
              Row(children: [
                const Text('Select Time: ',textAlign: TextAlign.right, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,  )
                ),
                SizedBox( width: 20,),
                ElevatedButton(
                  child:Text('$hours:$minutes'),
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
                  primary: Color(0xFF006D77),
                ),
                ),
              ],),

              const SizedBox(
                height: 40,
              ),
      SizedBox(
        height:40 ,
        width: 130,
        child: ElevatedButton(
            child: Text('Submit'),
            onPressed: () async{
              Navigator.pop(context);
              Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context) => (Teacher())));
               String id = DateTime.now().millisecondsSinceEpoch.toString();
               await info.doc(id).set({
                 'Name Of Event' : nameofEvent,
                 'Description' : description,
                 'Image' : imageUrl,
                 'Date and Time' : dateTime,
                 'Id' : id,
                 'link' : link,

                  }).then((value){

               });

             },style: ElevatedButton.styleFrom(
          primary: Color(0xFF0096C7),),
        ),
      ),
SizedBox(height: 10,)
            ]


          ),
        ),
        ),
        );
      }

          Future<DateTime?> pickDate() => showDatePicker(context: context, initialDate: dateTime, firstDate:DateTime(1900), lastDate: DateTime(2100),);

    Future<TimeOfDay?> pickTime() => showTimePicker(context: context, initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),);
  }
