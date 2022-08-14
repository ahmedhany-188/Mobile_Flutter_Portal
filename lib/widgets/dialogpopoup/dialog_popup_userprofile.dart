import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ShowUserProfileBottomSheet extends StatefulWidget {

  const ShowUserProfileBottomSheet({Key? key}) : super(key: key);
  @override
  ShowUserProfileBottomSheetClass createState() => ShowUserProfileBottomSheetClass();

}

class ShowUserProfileBottomSheetClass extends State<ShowUserProfileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(child: contentBox(context));
  }

  contentBox(context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            width: 5, color: Colors.white
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5)),
      ),

      child: Column(
        children: [

           Padding(
            padding: EdgeInsets.all(10.0),
                child:Container(
                  width: double.infinity,
                  child: Text("Edit" , style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),textAlign: TextAlign.left),
                ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles();
                PlatformFile? pickedFile;
                setState(() {
                  pickedFile = result!.files.first;
                  print(pickedFile!.path.toString() + "----");
                  print(pickedFile!.name.toString() + "----");
                  Navigator.of(context).pop();
                });
              },
                child: Container(
                  child: Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Upload Image',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () async {
                final result = await FilePicker.platform.pickFiles();
                PlatformFile? pickedFile;
                setState(() {
                  pickedFile = result!.files.first;
                  print(pickedFile!.path.toString() + "----");
                  print(pickedFile!.name.toString() + "----");
                  Navigator.of(context).pop();
                });
              },
              child: Container(
                  child: Row(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.black54,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Change mobile number',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                  ),
                    ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

