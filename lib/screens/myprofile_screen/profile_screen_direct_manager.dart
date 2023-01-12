import 'package:authentication_repository/authentication_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/profile_manager_screen_bloc/profile_manager_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../constants/url_links.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/dialogpopoup/dialog_popup_profile_call.dart';
import '../../data/models/contacts_related_models/contacts_data_from_api.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class DirectManagerProfileScreen extends StatefulWidget {
  static const routeName = "/direct-manager-profile-screen";
  static const String employeeHrCode = "managerHrCode";
  static const ContactsDataFromApi selectedContactDataAsMap =
      ContactsDataFromApi();

  const DirectManagerProfileScreen({Key? key, this.requestData})
      : super(key: key);

  final dynamic requestData;

  @override
  State<DirectManagerProfileScreen> createState() =>
      DirectManagerProfileScreenClass();
}

class DirectManagerProfileScreenClass
    extends State<DirectManagerProfileScreen> {
  ScrollController scrollController = ScrollController();

  VCard vCard = VCard();

  @override
  Widget build(BuildContext context) {
    ///Create a new vCard

    final currentRequestData = widget.requestData;

    final user = context.select((AppBloc bloc) => bloc.state.userData);
    // var imageProfile = "";

    return CustomBackground(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.qr_code,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: QrImage(
                              data: vCard.getFormattedString(),
                              // state is BlocGetManagerDataSuccessState?vCard.getFormattedString():"",

                              version: QrVersions.auto,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        );
                      });
                },
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: BlocProvider<ProfileManagerCubit>(
              create: (context) =>
              currentRequestData[
              DirectManagerProfileScreen.employeeHrCode] !=
                  "0"
                  ? (ProfileManagerCubit()
                ..getManagerData(currentRequestData[
                DirectManagerProfileScreen.employeeHrCode],
                    user.user?.token ?? ""))
                  : (ProfileManagerCubit()
                ..getUserOffline(currentRequestData[
                DirectManagerProfileScreen.selectedContactDataAsMap])),
              child: BlocConsumer<ProfileManagerCubit, ProfileManagerState>(
                  listener: (context, state) {
                    if (state is BlocGetManagerDataSuccessState) {

                      ///Set properties
                      vCard.firstName = state.managerData.name.toString();
                      vCard.organization = state.managerData.companyName ?? "";
                      // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
                      vCard.jobTitle = state.managerData.titleName ?? "";
                      vCard.email = state.managerData.email ?? "No email found";
                      vCard.url = "https://hassanallam.com";
                      vCard.workPhone = state.managerData.deskPhone;
                      vCard.cellPhone = getMobile(state);

                      // imageProfile = state.managerData.imgProfile ?? "";
                    }

                    if (state is BlocGetManagerDataErrorState) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("error"),
                        ),
                      );
                    }
                  }, builder: (context, state) {
                return (state is BlocGetManagerDataSuccessState)
                    ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: (state.managerData.imgProfile != "") ? CachedNetworkImage(
                              imageUrl: getUserProfilePicture(
                                  state.managerData
                                      .imgProfile ??
                                      ''),
                              imageBuilder:
                                  (context, imageProvider) =>
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                              placeholder: (context, url) =>
                                  Assets.images.logo
                                      .image(height: 80),
                              errorWidget:
                                  (context, url, error) =>
                                  Assets.images.logo
                                      .image(height: 80),
                            ):Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Assets.images.logo.image(height: 80),
                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,

                                  color: Colors.white.withOpacity(0.1)),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(20)),
                              color: Colors.grey.shade400.withOpacity(0.2),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    state.managerData.name?.toTitleCase() ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              getFirstSection(
                                state.managerData.titleName ?? "",
                              ),
                              getFirstSection(
                                'HRCode: ${state.managerData.userHrCode ?? ""}',
                              ),
                            ]),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: Colors.white.withOpacity(0.1)
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),

                                  color: Colors.grey.shade400.withOpacity(0.2),
                                ),
                                child: Column(children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      'My Info',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color: Colors.white38,
                                  ),
                                  getHead("Department:", false),
                                  getLine(state.managerData.projectName ?? ""),
                                  getHead("Job Title:", false),
                                  getLine(state.managerData.titleName ?? ""),
                                  SizedBox(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          url_launcher.launchUrl(Uri.parse(
                                              'mailto:${getEmail(state)}'));
                                        },
                                        onLongPress: () async {
                                          await Clipboard.setData(ClipboardData(text: getEmail(state)));
                                          showToast("Mail copied");
                                        },
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 6,
                                              child: Column(children: [
                                                getHead("Email:", false),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15,
                                                      right: 3,
                                                      top: 3,
                                                      bottom: 3),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: getLineTwo(
                                                        state.managerData
                                                            .email ?? "No email found"),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            const Flexible(
                                              flex: 1,
                                              child: Icon(
                                                Icons.mail, color: Colors.white,
                                                size: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          scrollController.animateTo(
                                              scrollController.position
                                                  .minScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease);
                                          BlocProvider.of<
                                              ProfileManagerCubit>(
                                              context)
                                              .getManagerData(state
                                              .managerData
                                              .managerCode ?? "",
                                              user.user?.token ?? "");
                                        },
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 6,
                                              child: Column(children: [
                                                getHead(
                                                    "Direct Manager:", false),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      left: 15,
                                                      right: 3,
                                                      top: 3,
                                                      bottom: 3),
                                                  child: SizedBox(
                                                      width:
                                                      double.infinity,

                                                      // child:getManagerCodeText(state is BlocGetManagerDataSuccessState?state.managerData.managerName.toString():"not Found")
                                                      child:
                                                      getManagerCodeText(
                                                          state)),
                                                ),
                                              ]),
                                            ),
                                            const Flexible(
                                              flex: 1,
                                              child: Icon(
                                                Icons.next_plan,
                                                color: Colors.white,
                                                size: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          // url_launcher.launchUrl(Uri.parse(
                                          //     'tel:+${getMobile(state)}'));
                                          showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return  DialogProfileCallBottomSheet(
                                                    type: "phoneNumber",
                                                    value: getMobile(state),
                                                    );
                                              });
                                        },
                                        onLongPress: () async {
                                          await Clipboard.setData(ClipboardData(text: getMobile(state)));
                                          showToast("Mobile copied");
                                        },
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 5,
                                              child: Column(children: [
                                                getHead(
                                                    "Mobile Number:", false),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 15,
                                                      right: 3,
                                                      top: 3,
                                                      bottom: 3),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: getLineTwo(
                                                        getMobile(state)),),
                                                ),
                                              ]),
                                            ),

                                            // const Flexible(
                                            //   flex: 1,
                                            //   child: Text(
                                            //     "ZOOM",
                                            //     style: TextStyle(color: Colors.lightBlue,
                                            //       fontSize: 14,
                                            //       fontFamily: 'Nunito',),
                                            //   ),
                                            // ),
                                            const Flexible(
                                              flex: 1,
                                              child: Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                                size: 25.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                      width: double.infinity,
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return  DialogProfileCallBottomSheet(
                                                  type: "phoneExt",
                                                  value:getExt(state),
                                                );
                                              });
                                        },
                                        onLongPress: () async {
                                          await Clipboard.setData(ClipboardData(text: getExt(state)));
                                          showToast("Ext copied");
                                        },
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 5,
                                              child: Column(children: [
                                                getHead("Ext:", false),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(left: 15, right: 3, top: 3, bottom: 3),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: getLineTwo(getExt(state)),),
                                                ),
                                              ]),
                                            ),
                                            // const Flexible(
                                            //   flex: 1,
                                            //   child: Text(
                                            //     "ZOOM",
                                            //     style: TextStyle(color: Colors.lightBlue,
                                            //       fontSize: 14,
                                            //       fontFamily: 'Nunito',),
                                            //   ),
                                            // ),

                                          ],
                                        ),
                                      )),
                                  getQRData(state),
                                ]))),
                      ],
                    ),
                  ),
                )
                    : const Center(child: CircularProgressIndicator());
              }))),
    );
  }

  Container getQRData(ProfileManagerState state) {
    if (state is BlocGetManagerDataSuccessState) {
      vCard.firstName = state.managerData.name.toString();
      vCard.organization = state.managerData.companyName ?? "";
      // vCard.photo.attachFromUrl('/path/to/image/file.png', 'PNG');
      vCard.jobTitle = state.managerData.titleName ?? "";
      vCard.email = state.managerData.email ?? "";
      vCard.url = "https://hassanallam.com";
      vCard.workPhone = state.managerData.deskPhone;
      vCard.cellPhone = getMobile(state);
    }

    return Container();
  }

  String getEmail(ProfileManagerState state) {
    if (state is BlocGetManagerDataSuccessState) {
      if (state.managerData.email == null) {
        return "No mail found";
      } else {
        return state.managerData.email ?? "No mail found";
      }
    } else {
      return "No mail found";
    }
  }


  String getMobile(ProfileManagerState state) {
    String mobile="";
    if (state is BlocGetManagerDataSuccessState) {
      if (state.managerData.mainFunction == "Top Management") {
        return "No mobile found";
      } else {
        mobile= state.managerData.mobile ?? "No mobile found";
        if(mobile.isEmpty){
          return "No mobile found";
        }else{
          return mobile;
        }
      }
    }
    else {
      return "No mobile found";
    }
  }

  String getExt(ProfileManagerState state) {
    String ext="";
    if (state is BlocGetManagerDataSuccessState) {
      ext=state.managerData.deskPhone ?? "No ext found";
      if (ext.isEmpty) {
        return "No ext found";
      } else {
        return ext;
      }
    } else {
      return "No ext found";
    }
  }

  Padding getFirstSection(String line) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          line,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Nunito',
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Padding getHead(String head, bool icon) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: icon ? null : double.infinity,
        child: Text(
          head,
          style: const TextStyle(
            // color: Colors.white,
            color: ConstantsColors.appraisalColor3,

            fontSize: 17,
            fontFamily: 'Nunito',
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Text getManagerCodeText(ProfileManagerState state) {
    String managerCode = "Not found";
    if (state is BlocGetManagerDataSuccessState) {
      if (state.managerData.managerName.toString() != "null") {
        managerCode = state.managerData.managerName.toString();
        managerCode = managerCode.toTitleCase();
      } else {
        managerCode = state.managerData.managerCode.toString();
      }
    }
    return Text(managerCode,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Nunito',
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.left);
  }

  Text getLineTwo(String line) {
    return Text(
          line,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Nunito',

          ),
          textAlign: TextAlign.left,
    );
  }

  Padding getLine(String line) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 3, top: 3, bottom: 3),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          line,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Nunito',
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }



}
