import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class notices extends StatefulWidget {
  const notices({Key? key}) : super(key: key);

  @override
  State<notices> createState() => _noticesState();
}

class _noticesState extends State<notices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          getCurrentDate(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.dehaze_outlined),
          color: Colors.black,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      body: GridView.builder(
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(
                      width: 100,
                      height: 120,
                      image: AssetImage('asset/images/abode.png'),
                    ),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(Icons.upload_file, color: Colors.black),
          onPressed: pickFileAndUpload,
        ),
      ),
    );
  }

  void pickFileAndUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      uploadPdf(file);
      Fluttertoast.showToast(
          msg: "Uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    } else {
      print("File picking canceled.");
    }
  }

  Future<void> uploadPdf(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
    FirebaseStorage.instance.ref().child('pdfs/$fileName.pdf');

    UploadTask uploadTask = storageReference.putFile(file);

    await uploadTask.whenComplete(() async {
      // Get the download URL for the uploaded file
      String downloadURL = await storageReference.getDownloadURL();

      // Add the file details to Firestore (replace 'pdfs' with your collection name)
      await FirebaseFirestore.instance.collection('pdfs').add({
        'name': fileName,
        'link': downloadURL,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('PDF uploaded successfully.');
    });
  }

  String getCurrentDate() {
    final now = DateTime.now();
    final formattedDate = DateFormat('d MMMM').format(now);
    return formattedDate;
  }
}
