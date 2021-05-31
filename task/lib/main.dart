import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/Bloc/measurement_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  bool show = false;
  Future<void> uploadImage() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('Please wait..'),
                ],
              ),
            ));
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("userData")
        .child("${getRandomString(5)}.jpg");

    final UploadTask task = firebaseStorageRef.putFile(_image!);

    var imageUrl;
    await task.whenComplete(() async {
      try {
        imageUrl = await firebaseStorageRef.getDownloadURL();
      } catch (onError) {
        print("Error");
      }

      print(imageUrl);
      measurementBloc.getResponse(context, imageUrl);
    });

    Navigator.pop(context);
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;

    if (gallery) {
      pickedFile = (await picker.getImage(
        source: ImageSource.gallery,
      ))!;
    } else {
      pickedFile = (await picker.getImage(
        source: ImageSource.camera,
      ))!;
    }
    setState(() {
      _image = File(pickedFile.path);
      show = true;
      Fluttertoast.showToast(
          msg: "Selected successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          // backgroundColor: Color(0xff1c304f),
          // textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: show
          ? _image != null
              ? Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: FileImage(_image!))),
                )
              : SizedBox()
          : Center(
              child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11.0),
                            topRight: Radius.circular(11.0))),
                    context: context,
                    builder: (context) => Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    getImage(false);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Take Photo",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    getImage(true);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Upload Photo",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
              },
              child: Text(
                "Upload Image",
                style: TextStyle(color: Colors.white),
              ),
            )),
      floatingActionButton: show
          ? FloatingActionButton(
              onPressed: () {
                uploadImage();
              },
              child: Icon(Icons.done),
            )
          : SizedBox(),
    );
  }
}
