import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DialogPopUpUserProfile extends StatefulWidget {

  const DialogPopUpUserProfile({Key? key}) : super(key: key);

  @override
  DialogPopUpUserProfileClass createState() => DialogPopUpUserProfileClass();
}

class DialogPopUpUserProfileClass extends State<DialogPopUpUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(

          padding: const EdgeInsets.only(left: 20, top: 45
              + 20, right: 20, bottom: 20
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(0, 3),
                    blurRadius: 3
                ),
              ]
          ),
          child: Container(
            height: 80,
              margin: const EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();

                  PlatformFile? pickedFile;

                  setState(() {
                    pickedFile = result!.files.first;

                    print(pickedFile!.path.toString()+"----");
                    print(pickedFile!.name.toString()+"----");

                    Navigator.of(context).pop();


                  });

                },
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Text(
                          'Upload Image',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ),

        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: Image.asset("assets/images/logo.png")
            ),
          ),
        ),
      ],
    );
  }
}

