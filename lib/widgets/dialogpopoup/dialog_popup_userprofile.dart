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
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        border: Border.all(
            width: 5, color: Colors.white
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5)),
      ),

      child: RaisedButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles();

          PlatformFile? pickedFile;

          setState(() {
            pickedFile = result!.files.first;
            print(pickedFile!.path.toString() + "----");
            print(pickedFile!.name.toString() + "----");
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
    );
  }
}

