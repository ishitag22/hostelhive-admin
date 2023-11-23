import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class notices extends StatefulWidget {
  const notices({super.key});

  @override
  State<notices> createState() => _noticesState();
}

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

Future<String?> uploadPdf(String fileName, File file) async{
  final refrence = FirebaseStorage.instance.ref().child("pdfs/");
  final uploadTask = refrence.putFile(file);
  await uploadTask.whenComplete((){});
  final downloadLink = await refrence.getDownloadURL();
  return downloadLink;
}

void pickFile() async{
  final pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if(pickedFile != null){
    String fileName = pickedFile.files[0].name;
    File file = File(pickedFile.files[0].path!);
    final downloadLink = await uploadPdf(fileName, file);
    await _firebaseFirestore.collection("pdfs").add({
      "name": fileName,
      "link" : downloadLink,

    });

    print("PDF uploaded successfully");
  }
}

String getCurrentDate() {
  final now = DateTime.now();
  final formattedDate = DateFormat('d MMMM').format(
      now);
  return formattedDate;
}
class _noticesState extends State<notices> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(getCurrentDate(), style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.dehaze_outlined),
          color: Colors.black,
          onPressed: (){Scaffold.of(context).openDrawer();},
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      body: GridView.builder(
        itemCount: 2,
        gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     const Image(width:100, height:120, image: AssetImage('asset/images/abode.png',)),
                      Text(
                        "Notice",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          );
        },
      ),
      floatingActionButton: Padding( padding: EdgeInsets.only(bottom: 16.0),
      child: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.upload_file, color: Colors.black,),
        onPressed: pickFile,
      ),
      ),
    );
  }
}
