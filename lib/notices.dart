import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Notices extends StatefulWidget {
  const Notices({Key? key}) : super(key: key);

  @override
  State<Notices> createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {
  File? image;

  String getCurrentDate() {
    final now = DateTime.now();
    final formattedDate = DateFormat('d MMMM').format(now);
    return formattedDate;
  }
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
        itemCount: 4,
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
                    image != null
                        ? Image.file(
                      image!,
                      width: 100,
                      height: 120,
                    )
                        : const Image(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.amber,
              child: Icon(Icons.camera, color: Colors.black),
              onPressed: pickImage,
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.amber,
              child: Icon(Icons.upload_file, color: Colors.black),
              onPressed: pickFileAndUpload,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> pickFileAndUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png','pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      uploadFile(file);
      Fluttertoast.showToast(
        msg: "Uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      print("File picking canceled.");
    }
  }

  Future<void> uploadFile(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
    FirebaseStorage.instance.ref().child('pdfs/$fileName.jpg');
    UploadTask uploadTask = storageReference.putFile(file);

    await uploadTask.whenComplete(() async {
      String downloadURL = await storageReference.getDownloadURL();
      await FirebaseFirestore.instance.collection('pdfs').add({
        'name': fileName,
        'link': downloadURL,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }
}
