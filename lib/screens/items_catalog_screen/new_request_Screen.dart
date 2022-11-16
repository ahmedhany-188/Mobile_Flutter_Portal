import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_state.dart';
import 'package:hassanallamportalflutter/data/repositories/request_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';


class NewRequestCatalogScreen extends StatefulWidget {

  static const routeName = "/new-request-screen";
  const NewRequestCatalogScreen({Key? key,this.requestData}) : super(key: key);
  final dynamic requestData;

  @override
  State<NewRequestCatalogScreen> createState() => NewRequestCatalogScreenClass();
}

class NewRequestCatalogScreenClass extends State<NewRequestCatalogScreen> {


  final GlobalKey<DropdownSearchState<String>> catalogCategoriesFormKey =
  GlobalKey();

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    final currentRequestData = widget.requestData;
    final exampleList=["a","b","c","d"];

    final requestRepository=RequestRepository(user);

    return BlocProvider<NewRequestCatalogCubit>(
        create: (embassyContext) =>
        (NewRequestCatalogCubit(RequestRepository(user))
          ..newFunctionForTest()),

        child: BlocBuilder<NewRequestCatalogCubit, NewRequestCatalogInitial>(
          builder: (context, state) {
            return WillPopScope(
                onWillPop: () async {
                  await EasyLoading.dismiss(animation: true);
                  return true;
                },
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                    elevation: 0,
                    title: const Text('New Request'),
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // do something
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // do something
                        },
                      )
                    ],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),
                  floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      FloatingActionButton.extended(
                        heroTag: null,

                        onPressed: () {
                          // context.read<EmbassyLetterCubit>()
                          //     .submitEmbassyLetter();
                        },
                        // formBloc.state.status.isValidated
                        //       ? () => formBloc.submitPermissionRequest()
                        //       : null,
                        // formBloc.submitPermissionRequest();

                        icon: const Icon(Icons.send),
                        label: const Text('SUBMIT'),
                      ),
                    ],
                  ),
                  body: BlocListener<
                      NewRequestCatalogCubit,
                      NewRequestCatalogInitial>(
                      listener: (context, state) {
                        if (state.newRequestCatalogEnumState ==
                            NewRequestCatalogEnumState.success) {
                          // LoadingDialog.hide(context);
                          EasyLoading.dismiss(animation: true);

                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (_) =>
                          //         SuccessScreen(text: state.successMessage ??
                          //             "Error Number",routName: NewRequestCatalogScreen.routeName, requestName: 'Embassy Letter',)));

                        }
                        else if (state.newRequestCatalogEnumState ==
                            NewRequestCatalogEnumState.loading) {
                          EasyLoading.show(status: 'loading...',
                            maskType: EasyLoadingMaskType.black,
                            dismissOnTap: false,);
                        }
                        else if (state.newRequestCatalogEnumState ==
                            NewRequestCatalogEnumState.failed) {
                          // EasyLoading.showError(state.errorMessage.toString(),);
                        }
                        // else if (state.status.isValid) {
                        //   EasyLoading.dismiss(animation: true);
                        // }
                      },

                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                          child: Form(
                              child: SingleChildScrollView(
                                  child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            style: TextStyle(
                                              color: ConstantsColors
                                                  .bottomSheetBackgroundDark,),
                                            initialValue: state.newRequestDate
                                                .value,
                                            key: UniqueKey(),
                                            readOnly: true,
                                            enabled: false,
                                            decoration: const InputDecoration(
                                              iconColor: ConstantsColors.bottomSheetBackgroundDark,
                                              floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                              labelText: 'Request Date',
                                              prefixIcon: Icon(
                                                  Icons.calendar_today),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BlocBuilder<
                                              NewRequestCatalogCubit,
                                              NewRequestCatalogInitial>(
                                              builder: (context, state) {
                                                return TextFormField(
                                                    initialValue: state.catalogNewRequests?.itemName??"",
                                                    // initialValue:state.passportNumber.value,
                                                    keyboardType: TextInputType.text,
                                                    onChanged: (value) {
                                                      // context.read<NewRequestCatalogCubit>()
                                                      //     .passportNo(value);
                                                    },
                                                    decoration: InputDecoration(
                                                      floatingLabelAlignment:
                                                      FloatingLabelAlignment.start,
                                                      labelText: "Item Name",
                                                      prefixIcon: const Icon(Icons.drive_file_rename_outline,color: ConstantsColors.bottomSheetBackgroundDark,),
                                                      // errorText: state.passportNumber.invalid
                                                      //     ? 'invalid Passport NO'
                                                      //     : null,
                                                    )
                                                );
                                              }
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BlocBuilder<
                                              NewRequestCatalogCubit,
                                              NewRequestCatalogInitial>(
                                              builder: (context, state) {
                                                return TextFormField(
                                                    initialValue: state.catalogNewRequests?.itemDesc??"",
                                                    // initialValue:state.passportNumber.value,
                                                    keyboardType: TextInputType.text,
                                                    onChanged: (value) {
                                                      // context.read<NewRequestCatalogCubit>()
                                                      //     .passportNo(value);
                                                    },
                                                    decoration: InputDecoration(
                                                      floatingLabelAlignment:
                                                      FloatingLabelAlignment.start,
                                                      labelText: "Item Description",
                                                      prefixIcon: const Icon(Icons.drive_file_rename_outline,color: ConstantsColors.bottomSheetBackgroundDark,),
                                                      // errorText: state.passportNumber.invalid
                                                      //     ? 'invalid Passport NO'
                                                      //     : null,
                                                    )
                                                );
                                              }
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: BlocBuilder<NewRequestCatalogCubit, NewRequestCatalogInitial>(
                                            builder: (context, state) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownSearch<String>(
                                                  key: catalogCategoriesFormKey,
                                                  items: exampleList,
                                                  itemAsString: (categoryItem) => categoryItem,
                                                  // onChanged: (item) => NewRequestCatalogCubit(requestRepository).get(context)
                                                  //         .validateForm(
                                                  //          exampleList:
                                                  //         (item!.toString().isEmpty)
                                                  //             ? FormzStatus.invalid
                                                  //             : FormzStatus.pure),
                                                  selectedItem: (state.catalogNewRequests?.catID.toString()??""),
                                                  dropdownButtonProps:
                                                  const DropdownButtonProps(
                                                      color: ConstantsColors.bottomSheetBackgroundDark),
                                                  dropdownDecoratorProps:
                                                  DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                    InputDecoration(
                                                      labelText: 'Category',
                                                      floatingLabelAlignment:
                                                      FloatingLabelAlignment.start,
                                                      // errorText: (state..isInvalid)
                                                      //     ? 'Required'
                                                      //     : null,
                                                    ),
                                                  ),
                                                  popupProps: PopupProps.modalBottomSheet(
                                                    showSearchBox: true,
                                                    constraints: BoxConstraints(
                                                        maxHeight: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.75),
                                                    interceptCallBacks: true,
                                                    searchDelay: Duration.zero,
                                                    title: AppBar(
                                                        title: const Text('Category'),
                                                        centerTitle: true,
                                                        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                                                        elevation: 0),
                                                    listViewProps: const ListViewProps(
                                                        padding: EdgeInsets.zero,
                                                        physics: BouncingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        keyboardDismissBehavior:
                                                        ScrollViewKeyboardDismissBehavior
                                                            .onDrag),
                                                    searchFieldProps: const TextFieldProps(
                                                      padding: EdgeInsets.all(20),
                                                      decoration: InputDecoration(
                                                        contentPadding: EdgeInsets.all(10),
                                                        filled: true,
                                                        hintText: "Search by name",
                                                        prefixIcon: Icon(Icons.search,
                                                            color: ConstantsColors.bottomSheetBackgroundDark),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),

                                      ]
                                  )
                              )
                          )
                      )
                  ),
                )
            );
          },
        ),
      );
  }
}

