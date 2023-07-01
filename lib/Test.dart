import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

bool showSpinner = false;

display_image() {
  if (imageUrl == '') {
    return Center(
      child: ProfilePicture(
        name: "nnn",
        radius: 60,
        fontsize: 30,
        img: 'https://t4.ftcdn.net/jpg/04/81/13/43/360_F_481134373_0W4kg2yKeBRHNEklk4F9UXtGHdub3tYk.jpg',
      ),
    );
  }
  else {
    return Center(
      child: ProfilePicture(
        name: "nnn",
        radius: 30,
        fontsize: 30,
        img: imageUrl,
      ),
    );
  }
}

late String imageUrl='';

class _TestState extends State<Test> {


  @override
  void initState() {
    imageUrl;
    display_image();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImagePicker imagePicker = ImagePicker();

    return ModalProgressHUD(inAsyncCall: showSpinner,
    child:Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Column (
            children:[
              display_image(),
              IconButton(onPressed:() async{
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
              }
              setState(() {
                showSpinner = false;
              });
            }, icon:  const Icon(Icons.camera_alt)),
              const Text('Name of Event',textAlign: TextAlign.right, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,  )
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value){

                },
              ),
      ]
          ),
        )
    )

    ;
  }
}
