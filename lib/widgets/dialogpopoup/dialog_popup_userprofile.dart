import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/screens/medicalrequest_screen/medical_request_screen.dart';

class ShowUserProfileBottomSheet extends StatefulWidget {

  MainUserData user;
   ShowUserProfileBottomSheet(this.user,{Key? key}) : super(key: key);
  @override
  ShowUserProfileBottomSheetClass createState() => ShowUserProfileBottomSheetClass();

}

class ShowUserProfileBottomSheetClass extends State<ShowUserProfileBottomSheet> {


  String mobileNo="";


  final Connectivity connectivity = Connectivity();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child :  Container(child: contentBox(context))
    );


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

                showDialog(context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 250,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Change mobile number',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                        onChanged: (value) {
                                          mobileNo=value;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          floatingLabelAlignment:
                                          FloatingLabelAlignment.start,
                                          labelText: "Add number",
                                          prefixIcon: const Icon(
                                            Icons.numbers, color: Colors.white70,),
                                          border: myInputBorder(),
                                        )
                                    ),
                                  ),

                                  FloatingActionButton.extended(
                                    heroTag: null,
                                    onPressed: () async{
                                      EasyLoading.show(status: 'loading...',maskType: EasyLoadingMaskType.black,dismissOnTap: false,);
                                      try {
                                        var connectivityResult = await connectivity.checkConnectivity();
                                        if (connectivityResult == ConnectivityResult.wifi ||
                                            connectivityResult == ConnectivityResult.mobile) {
                                          RequestRepository requestRepository = RequestRepository(widget.user);
                                          final requestData = await requestRepository.setNewUserMobileNumber(mobileNo,widget.user.employeeData!.userHrCode.toString());
                                          if (requestData.id == 0 || requestData.id == 1) {
                                            EasyLoading.showSuccess("Done");
                                          } else {
                                            EasyLoading.showError("An error occurred",);
                                          }
                                        } else {
                                          EasyLoading.showError("No internet Connection",);
                                        }
                                      } catch (e) {
                                        EasyLoading.showError(e.toString(),);
                                      }
                                    },
                                    icon: const Icon(Icons.send),
                                    label: const Text('SUBMIT'),
                                  ),
                                ],
                              ),
                          ),
                        ),
                      );
                    }
                );


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

