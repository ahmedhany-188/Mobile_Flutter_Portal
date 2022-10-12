import 'package:authentication_repository/authentication_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/data_providers/general_dio/general_dio.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../data/data_providers/requests_data_providers/request_data_providers.dart';

class ShowUserProfileBottomSheet extends StatefulWidget {
  final MainUserData user;
  const ShowUserProfileBottomSheet(this.user, {Key? key}) : super(key: key);
  @override
  ShowUserProfileBottomSheetClass createState() =>
      ShowUserProfileBottomSheetClass();
}

class ShowUserProfileBottomSheetClass
    extends State<ShowUserProfileBottomSheet> {
  String mobileNo = "";

  final Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await EasyLoading.dismiss(animation: true);
          return true;
        },
        child: contentBox(context,widget.user));
  }

  contentBox(context,MainUserData user) {
    return CustomTheme(
      child: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Text("Edit",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  await FilePicker.platform.pickFiles(type: FileType.image,).then((value) {
                    String? fileName = widget.user.employeeData?.userHrCode;
                    String? fileExtension = value?.files.first.extension;
                    GeneralDio(user).uploadUserImage(
                            value!, fileName!, fileExtension!).then((value) {
                              if(value.data != null && value.statusCode == 200){}else{
                                throw RequestFailureApi.fromCode(value.statusCode!);
                              }
                    })
                        .whenComplete(() {
                      DefaultCacheManager manager = DefaultCacheManager();
                      manager.removeFile(
                          "https://portal.hassanallam.com/Apps/images/Profile/${widget.user.employeeData!.imgProfile}");
                      EasyLoading.showSuccess('Image Uploaded Successfully');
                    }).catchError((err) {
                      EasyLoading.showError('Something went wrong');
                      throw err;
                    });
                  }).catchError((err) {
                    EasyLoading.showError('Something went wrong');
                    throw err;
                  });
                },
                child: Row(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Upload Image',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor:
                          ConstantsColors.bottomSheetBackgroundDark,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.75,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Change mobile number',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    mobileNo = value;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.start,
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    // labelText: "Add number",
                                    hintText: "Add number",
                                    prefixIcon: const Icon(
                                      Icons.numbers,
                                      color: Colors.white,
                                    ),
                                    isDense: true,
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white30)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              FloatingActionButton.extended(
                                onPressed: () async {
                                  EasyLoading.show(
                                    status: 'loading...',
                                    maskType: EasyLoadingMaskType.black,
                                    dismissOnTap: false,
                                  );
                                  try {
                                    var connectivityResult =
                                        await connectivity.checkConnectivity();
                                    if (connectivityResult ==
                                            ConnectivityResult.wifi ||
                                        connectivityResult ==
                                            ConnectivityResult.mobile) {
                                      RequestRepository requestRepository =
                                          RequestRepository(widget.user);
                                      final requestData =
                                          await requestRepository
                                              .setNewUserMobileNumber(
                                                  mobileNo,
                                                  widget.user.employeeData!
                                                      .userHrCode
                                                      .toString());
                                      if (requestData.id == 0 ||
                                          requestData.id == 1) {
                                        EasyLoading.showSuccess("Done");
                                      } else {
                                        EasyLoading.showError(
                                          "An error occurred",
                                        );
                                      }
                                    } else {
                                      EasyLoading.showError(
                                        "No internet Connection",
                                      );
                                    }
                                  } catch (e) {
                                    EasyLoading.showError(
                                      e.toString(),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.send),
                                label: const Text('SUBMIT'),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Change mobile number',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
