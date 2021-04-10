import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class MediumScreenInput extends StatefulWidget {
  @override
  _MediumScreenInputState createState() => _MediumScreenInputState();
}

class _MediumScreenInputState extends State<MediumScreenInput> {
  @override
  Widget build(BuildContext context) {
    File myMediumImage;
    final picker = ImagePicker();

    // Function to open a camera
    Future openCamera() async {
      var cameraImage = await picker.getImage(source: ImageSource.camera);
      setState(() {
        myMediumImage = File(cameraImage.path);
      });
    }

    // Function to open a local gallery
    Future openGallery() async {
      var galleryImage = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        myMediumImage = File(galleryImage.path);
      });
    }

    uploadImageToServer(File imageFile, String id) async {
      print("attempting to connect to server......");
      var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      print(length);

      var uri = Uri.parse('http://4044a8a99ce9.ngrok.io/post_image');
      print("connection established.");
      var request = new http.MultipartRequest("POST", uri);
      //request.fields['ID']=id;
      var multipartFile = new http.MultipartFile('file', stream, length,
          filename: basename(imageFile.path));

      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      request.fields['ID'] = '2';
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      setState(() {
        Navigator.pop(this.context);
      });

      Future<void> openDialogBox() async {
        return showDialog<void>(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(),
              backgroundColor: Colors.blue,
              title: Text(
                'Choose options',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.black,
                      child: Text(
                        "Open Camera",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        openCamera();
                      },
                    ),
                    MaterialButton(
                      color: Colors.blue[900],
                      child: Text(
                        "Open Gallery",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        openGallery();
                      },
                    ),
                    MaterialButton(
                      color: Colors.blue[900],
                      child: Text(
                        "upload",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        //print(widget.dress.ID);
                        uploadImageToServer(myMediumImage, '2');
                        print("button pressed");
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Garment Size: M"),
          ),
          body: Container(
            child: myMediumImage == null
                ? Center(
              child: Text(
                "click or upload a picture",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
                : Image.file(myMediumImage),
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              openDialogBox();
              //loadSize();
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.add_a_photo),
          ),
        );
      }
    }
  }
}

showDialog(
context: context,
builder: (context) {
Future.delayed(Duration(seconds: 5), () {
Navigator.of(context).pop(true);
});
return AlertDialog(
title: Text('Title'),
);
});
