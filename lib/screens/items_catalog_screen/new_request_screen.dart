import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_image_model.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/cart_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/favorite_screen.dart';
import 'package:hassanallamportalflutter/widgets/success/success_request_widget.dart';
import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/auth_app_status_bloc/app_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_new_request/item_catalog_new_request_state.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'items_catalog_screen_getall.dart';

class NewRequestCatalogScreen extends StatefulWidget {

  static const routeName = "/new-catalog-request-screen";
  static const  itemsGetAllTree = "treeListStructure";

  const NewRequestCatalogScreen({Key? key,this.requestData}) : super(key: key);
  final dynamic requestData;

  @override
  State<NewRequestCatalogScreen> createState() => NewRequestCatalogScreenClass();
}

class NewRequestCatalogScreenClass extends State<NewRequestCatalogScreen> {

  final GlobalKey<
      DropdownSearchState<String>> catalogCategoriesFormKey = GlobalKey();
  List<String> categoriesList = [];

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.userData);

    final currentRequestData = widget.requestData;

    if (currentRequestData[NewRequestCatalogScreen.itemsGetAllTree] == null) {
      Navigator.pop(context);
    }

    List<
        ItemsCatalogTreeModel> itemsGetAllTree = currentRequestData[NewRequestCatalogScreen
        .itemsGetAllTree];

    for (int i = 0; i < itemsGetAllTree.length; i++) {
      categoriesList.add(itemsGetAllTree[i].text.toString());
    }

    return WillPopScope(
      onWillPop: () async {
        await EasyLoading.dismiss(animation: true);
        return true;
      },
      child: BlocProvider<NewRequestCatalogCubit>(
          create: (context) =>
              NewRequestCatalogCubit(ItemsCatalogGetAllRepository(user)),
          //  //TODO the value of the tree depends on the internet connection
          //  ..checkTheValueOfTree()),
          child:
          BlocConsumer<
              NewRequestCatalogCubit,
              NewRequestCatalogInitial>(
              listener: (context, state) {
                if (state.newRequestCatalogEnumState ==
                    NewRequestCatalogEnumState.success) {
                  EasyLoading.dismiss(animation: true);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) =>
                          SuccessScreen(text: state.errorMessage,
                            routName: NewRequestCatalogScreen.routeName,
                            requestName: 'Catalog item',)));
                }
                else if (state.newRequestCatalogEnumState ==
                    NewRequestCatalogEnumState.loading) {
                  EasyLoading.show(status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: false,);
                }
                else if (state.newRequestCatalogEnumState ==
                    NewRequestCatalogEnumState.failed) {
                  EasyLoading.showError(state.errorMessage);
                } else if (state.newRequestCatalogEnumState ==
                    NewRequestCatalogEnumState.valid) {
                  EasyLoading.dismiss(animation: true);
                }
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: Hero(
                      tag: 'hero',
                      child: AppBar(
                        backgroundColor: ConstantsColors
                            .bottomSheetBackgroundDark,
                        elevation: 0,
                        leading: InkWell(onTap: () =>
                            Navigator.of(context)
                                .pushReplacementNamed(ItemsCatalogGetAllScreen
                                .routeName), child: const Icon(Icons.home)),
                        title: const Text('New Request'),
                        centerTitle: true,
                        actions: <Widget>[
                         IconButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .pushReplacementNamed(FavoriteScreen.routeName);
                                  },
                                  icon: const Icon(Icons.favorite)),
                         IconButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .pushReplacementNamed(CartScreen.routeName);
                                  },
                                  icon: const Icon(Icons.shopping_cart)),
                        ],
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                    ),
                  ),
                  floatingActionButton: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          context.read<NewRequestCatalogCubit>()
                              .submitCatalogNewRequest(
                              user.employeeData?.userHrCode ?? "");
                        },
                        icon: const Icon(Icons.send),
                        label: const Text('SUBMIT'),
                      ),

                    ],
                  ),
                  body: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                      child: Form(
                          child: SingleChildScrollView(
                              child: Column(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          initialValue: state
                                              .itemName.value,
                                          keyboardType: TextInputType
                                              .text,
                                          onChanged: (value) {
                                            context.read<
                                                NewRequestCatalogCubit>()
                                                .addItemName(
                                                value.toString()
                                                    .trim());
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: "Item Name",
                                            prefixIcon: const Icon(
                                              Icons
                                                  .drive_file_rename_outline,
                                              color: ConstantsColors
                                                  .bottomSheetBackgroundDark,),
                                            errorText: state
                                                .itemName
                                                .invalid
                                                ? 'invalid Name'
                                                : null,
                                          )
                                      ),

                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          initialValue: state
                                              .itemDescription
                                              .value,
                                          keyboardType: TextInputType
                                              .text,
                                          onChanged: (value) {
                                            context.read<
                                                NewRequestCatalogCubit>()
                                                .addItemDescription(
                                                value.toString()
                                                    .trim());
                                          },
                                          decoration: InputDecoration(
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            labelText: "Item Description",
                                            prefixIcon: const Icon(
                                              Icons
                                                  .drive_file_rename_outline,
                                              color: ConstantsColors
                                                  .bottomSheetBackgroundDark,),
                                            errorText: state
                                                .itemDescription
                                                .invalid
                                                ? 'invalid Description'
                                                : null,
                                          )

                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: DropdownSearch<String>(
                                        key: catalogCategoriesFormKey,
                                        items: categoriesList,
                                        itemAsString: (
                                            categoryItem) => categoryItem,
                                        onChanged: (item) =>
                                        {
                                          for (int i = 0; i <
                                              itemsGetAllTree
                                                  .length; i++) {
                                            if(item ==
                                                itemsGetAllTree[i]
                                                    .text){
                                              context.read<
                                                  NewRequestCatalogCubit>()
                                                  .addSelectedCategoryItem(
                                                  itemsGetAllTree[i]
                                                      .id
                                                      .toString()),
                                            }
                                          }
                                        },
                                        // selectedItem: ("state.selectedCategory.value"),
                                        dropdownButtonProps:
                                        const DropdownButtonProps(
                                            color: ConstantsColors
                                                .bottomSheetBackgroundDark),
                                        dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                          InputDecoration(
                                            labelText: 'Choose category',
                                            floatingLabelAlignment:
                                            FloatingLabelAlignment
                                                .start,
                                            errorText: state
                                                .selectedCategory
                                                .invalid
                                                ? 'Required'
                                                : null,
                                          ),
                                        ),
                                        popupProps: PopupProps
                                            .modalBottomSheet(
                                          showSearchBox: true,
                                          constraints: BoxConstraints(
                                              maxHeight: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.75),
                                          interceptCallBacks: true,
                                          searchDelay: Duration
                                              .zero,
                                          title: AppBar(
                                              title: const Text(
                                                  'Category'),
                                              centerTitle: true,
                                              backgroundColor: ConstantsColors
                                                  .bottomSheetBackgroundDark,
                                              elevation: 0),
                                          listViewProps: const ListViewProps(
                                              padding: EdgeInsets
                                                  .zero,
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              keyboardDismissBehavior:
                                              ScrollViewKeyboardDismissBehavior
                                                  .onDrag),
                                          searchFieldProps: const TextFieldProps(
                                            padding: EdgeInsets.all(
                                                20),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets
                                                  .all(10),
                                              filled: true,
                                              hintText: "Search by name",
                                              prefixIcon: Icon(
                                                  Icons.search,
                                                  color: ConstantsColors
                                                      .bottomSheetBackgroundDark),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: BlocBuilder<
                                          NewRequestCatalogCubit,
                                          NewRequestCatalogInitial>(
                                          builder: (context, state) {
                                            if (state.itemAttach
                                                .isEmpty) {
                                              return const SizedBox(
                                                width: double.infinity,
                                                height: 50,
                                                child: Text(
                                                    "Attach File\nPlease upload file...",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: ConstantsColors
                                                            .bottomSheetBackgroundDark)),);
                                            } else {
                                              return addListOfImages(
                                                  state.itemAttach);
                                            }
                                          }
                                      ),
                                    ),

                                    ElevatedButton.icon(
                                      onPressed: () {
                                        NewRequestCatalogCubit
                                            .get(
                                            context)
                                            .addChosenImageName();
                                      },
                                      label: const Text(
                                          'Upload image',
                                          style: TextStyle(
                                              color: Colors
                                                  .white)),
                                      icon: const Icon(
                                          Icons
                                              .cloud_upload_sharp,
                                          color: Colors.white),
                                    ),

                                  ]
                              )
                          )
                      )
                  ),

                );
              }
          )
      ),
    );
  }

  SafeArea addListOfImages(List<ItemImageCatalogModel> stateList) {
    return SafeArea(
      // maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: stateList.isNotEmpty,
        builder: (context) =>
            GridView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                    .onDrag,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // childAspectRatio: (1 / .4),
                  mainAxisExtent: 90,
                  // here set custom Height You Want
                  // width between items
                  crossAxisSpacing: 2,
                  // height between items
                  mainAxisSpacing: 2,
                ),
                itemCount: stateList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      context.read<
                          NewRequestCatalogCubit>()
                          .changeMainImage(index);
                    },
                    child: SizedBox(
                        width: double
                            .infinity,
                        height: 60,
                        child: Stack(
                            children: [
                              Image
                                  .file(
                                File(
                                    stateList[index]
                                        .image
                                        .paths[0]
                                        .toString()),
                                width: double
                                    .infinity,),
                              Icon(
                                  stateList[index]
                                      .isMain ==
                                      true
                                      ? Icons
                                      .flag
                                      : null,
                                  color: ConstantsColors
                                      .bottomSheetBackgroundDark),
                            ]
                        )

                    ),
                  );
                }
            ),
        fallback: null, //(context) => const Center(child: LinearProgressIndicator()),
      ),
    );
  }

}

