import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helloworld/appConfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';

class LearnFlutterPage extends StatefulWidget {
  LearnFlutterPage({Key? key}) : super(key: key);

  @override
  _LearnFlutterPageState createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  File? file;
  final ImagePicker imagePicker = ImagePicker();
  bool isLoading = false;
  bool isPressed = false;
  var imageUrl = '';
  var filePath = '';
  var fileName = 'No file selected';
  final cloudinary = new Cloudinary(
      "337256166956859", "3xW2DzEkkXQKeQ10gwyhTqTW518", "dnjzv3tpx");

  String result = '';
  String dbOutput = '';
  String dbOutput1 = '';
  String htmlData = '';

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await cloudinary.uploadFile(
        filePath: filePath,
        resourceType: CloudinaryResourceType.auto,
        folder: 'notes',
      );
      print(response.secureUrl);

      setState(() {
        imageUrl = response.secureUrl.toString();
        getResult();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Null> getResult() async {
    final response = await http.post(
      Uri.parse('http://192.168.8.143:8000'),
      body: imageUrl,
    );
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        result = response.body;
        isLoading = false;
        String trimmedResult = result.trim();

        if (trimmedResult == 'Grape_Black_rot') {
          htmlData = appConfig.Grape1;
        } else if (trimmedResult == 'Grape_Esca(Black_Measles)') {
          htmlData = appConfig.Grape2;
        } else if (trimmedResult == 'Grape_Leaf_blight(Isariopsis_Leaf_Spot)') {
          htmlData = appConfig.Grape3;
        } else if (trimmedResult == 'Grape_healthy') {
          htmlData = appConfig.Grape4;
        } else if (trimmedResult ==
            'Corn_(maize)__Cercospora_leaf_spot Gray_leaf_spot') {
          htmlData = appConfig.Corn1;
        } else if (trimmedResult == 'Corn(maize)__Common_rust') {
          htmlData = appConfig.Corn2;
        } else if (trimmedResult == 'Corn_(maize)__Northern_Leaf_Blight') {
          htmlData = appConfig.Corn3;
        } else if (trimmedResult == 'Corn(maize)__healthy') {
          htmlData = appConfig.Corn4;
        } else if (trimmedResult == 'Potato_Early_blight') {
          htmlData = appConfig.Potato1;
        } else if (trimmedResult == 'Potato_Late_blight') {
          htmlData = appConfig.Potato2;
        } else if (trimmedResult == 'Potato_healthy') {
          htmlData = appConfig.Potato3;
        } else if (trimmedResult == 'Strawberry_Leaf_scorch') {
          htmlData = appConfig.Strawberry1;
        } else if (trimmedResult == 'Strawberry_healthy') {
          htmlData = appConfig.Strawberry2;
        } else if (trimmedResult == 'Tomato_Bacterial_spot') {
          htmlData = appConfig.Tomato1;
        } else if (trimmedResult == 'Tomato_Early_blight') {
          htmlData = appConfig.Tomato2;
        } else if (trimmedResult == 'Tomato_Late_blight') {
          htmlData = appConfig.Tomato3;
        } else if (trimmedResult == 'Tomato_Leaf_Mold') {
          htmlData = appConfig.Tomato4;
        } else if (trimmedResult == 'Tomato_Septoria_leaf_spot') {
          htmlData = appConfig.Tomato5;
        } else if (trimmedResult == 'Tomato_Tomato_Yellow_Leaf_Curl_Virus') {
          htmlData = appConfig.Tomato6;
        } else if (trimmedResult == 'Tomato_Tomato_mosaic_virus') {
          htmlData = appConfig.Tomato7;
        } else if (trimmedResult == 'Tomato__healthy') {
          htmlData = appConfig.Tomato8;
        } else {
          dbOutput =
              ' Grape or Corn or Potato or Strawberry or Tomato images are only allowed';
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text("Picture page"),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        width: 180,
                        color: Colors.black12,
                        child: file == null
                            ? Icon(
                                Icons.image,
                                size: 50,
                              )
                            : Image.file(
                                file!,
                                fit: BoxFit.fill,
                              ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          getFromGallery();
                        },
                        color: Colors.blue[900],
                        child: Text(
                          "Take from gallery",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          getFromCamera();
                        },
                        color: Colors.blue[900],
                        child: Text(
                          "Take from camera",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          Text(
                            "Disease : " + result,
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Text("Solution : " + dbOutput,
                              style: TextStyle(fontSize: 25.0)),
                          Html(data: htmlData)
                        ],
                      )
                    ],
                  ),
                ),
              ),
      );
    } catch (e) {
      print("Error: $e");
      return Scaffold(
        body: Center(
          child: Text("An error occurred"),
        ),
      );
    }
  }

  getFromCamera() async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        file = File(pickedImage.path);
      });
    }
  }

  getFromGallery() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        file = File(pickedImage.path);
        filePath = file!.path;
      });
      uploadFile();
    }
  }
}
