import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/data_providers/general_dio/general_dio.dart';
import 'package:hassanallamportalflutter/data/repositories/items_catalog_repositories/items_catalog_getall_repository.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/items_catalog_history_requests_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/items_catalog_history_respond_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/new_request_Screen.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';
import 'item_catalog_search_widget.dart';

class ItemsCatalogGetAllScreen extends StatefulWidget {
  static const routeName = '/itemscatalog-getall-list-screen';

  const ItemsCatalogGetAllScreen({Key? key}) : super(key: key);

  @override
  State<ItemsCatalogGetAllScreen> createState() =>
      ItemsCatalogGetAllScreenStateClass();
}

class ItemsCatalogGetAllScreenStateClass
    extends State<ItemsCatalogGetAllScreen> {
  TextEditingController textController = TextEditingController();
  FocusNode textFoucus = FocusNode();

  @override
  Widget build(BuildContext context) {
    MainUserData user = BlocProvider
        .of<AppBloc>(context)
        .state
        .userData;

    return BlocProvider<ItemCatalogSearchCubit>(
      create: (context) =>
      ItemCatalogSearchCubit(
          GeneralDio(BlocProvider
              .of<AppBloc>(context)
              .state
              .userData),
          ItemsCatalogGetAllRepository(user))
        ..getFavoriteItems(userHrCode: user.employeeData?.userHrCode ?? "")
        ..getCartItems(userHrCode: user.employeeData?.userHrCode ?? ""),
      child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocConsumer<ItemCatalogSearchCubit, ItemCatalogSearchState>(
            listener: (context, state) {
              if (state.itemCatalogSearchEnumStates ==
                  ItemCatalogSearchEnumStates.success) {
                EasyLoading.dismiss();
              } else if (state.itemCatalogSearchEnumStates ==
                  ItemCatalogSearchEnumStates.noConnection) {
                EasyLoading.showError("No Internet Connection");
              } else if (state.itemCatalogSearchEnumStates ==
                  ItemCatalogSearchEnumStates.failed) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("error"),),
                );
              }else if (state.itemCatalogSearchEnumStates ==
                  ItemCatalogSearchEnumStates.noDataFound) {
                EasyLoading.showError("No Data Found");
              }
            },
            builder: (context, state) {
              return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(150.0),
                    child: Hero(
                      tag: 'hero1',
                      child: AppBar(
                        title: const Text('Catalog'),
                        elevation: 0,
                        leading: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.clear),
                        ),
                        backgroundColor: ConstantsColors
                            .bottomSheetBackgroundDark,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0.0),
                          child:
                          SingleChildScrollView(
                            // physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      BlocBuilder<
                                          ItemCatalogSearchCubit,
                                          ItemCatalogSearchState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                    FavoriteScreen.routeName);
                                              },
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.white,
                                                size: 25,));
                                        },
                                      ),
                                      BlocBuilder<
                                          ItemCatalogSearchCubit,
                                          ItemCatalogSearchState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                    CartScreen.routeName);
                                              },
                                              icon: const Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: 25,));
                                        },
                                      ),

                                      BlocBuilder<
                                          ItemCatalogSearchCubit,
                                          ItemCatalogSearchState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              onPressed: () async {
                                                if (state.mainCategories
                                                    .isNotEmpty) {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                      NewRequestCatalogScreen
                                                          .routeName,
                                                      arguments: {
                                                        NewRequestCatalogScreen
                                                            .itemsGetAllTree: state
                                                            .mainCategories,
                                                        NewRequestCatalogScreen
                                                            .itemsGetAllTreeID: state
                                                            .mainCategoriesID
                                                      });
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.add, color: Colors.white,
                                                size: 25,));
                                        },
                                      ),

                                      BlocBuilder<
                                          ItemCatalogSearchCubit,
                                          ItemCatalogSearchState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                    CatalogHistoryRequestScreen
                                                        .routeName,
                                                    arguments: {
                                                      CatalogHistoryRequestScreen
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.list, color: Colors.white,
                                                size: 25,));
                                        },
                                      ),

                                      BlocBuilder<
                                          ItemCatalogSearchCubit,
                                          ItemCatalogSearchState>(
                                        builder: (context, state) {
                                          return IconButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                    CatalogHistoryRespondScreen
                                                        .routeName);
                                              },
                                              icon: const Icon(
                                                Icons.pending_actions,
                                                color: Colors.white,
                                                size: 25,));
                                        },
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 40, bottom: 20),
                                  child: BlocBuilder<ItemCatalogSearchCubit,
                                      ItemCatalogSearchState>(
                                    builder: (ctx, state) {
                                      if (state.itemsGetAllTree == [] ||
                                          state.itemsGetAllTree.isEmpty) {
                                        ItemCatalogSearchCubit.get(ctx)
                                            .getAllItemsCatalog(
                                            user.employeeData?.userHrCode ??
                                                "");
                                      }

                                      return TextFormField(
                                        focusNode: textFoucus,
                                        // key: uniqueKey,
                                        controller: textController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (text) {
                                          ItemCatalogSearchCubit.get(ctx)
                                              .setSearchString(text);
                                          if (text.isEmpty) {
                                            ItemCatalogSearchCubit.get(ctx)
                                                .clearData();
                                            ItemCatalogSearchCubit.get(ctx)
                                                .getAllItemsCatalog(
                                                user.employeeData?.userHrCode ??
                                                    "");
                                          }
                                        },
                                        decoration: InputDecoration(
                                            contentPadding: const EdgeInsets
                                                .all(10),
                                            filled: true,
                                            focusColor: Colors.white,
                                            fillColor: Colors.grey.shade400
                                                .withOpacity(0.4),
                                            // labelText: "Search contact",
                                            hintText: 'Item Name',
                                            suffixIcon: (textController.text
                                                .isNotEmpty ||
                                                textController.text != "")
                                                ? IconButton(
                                              icon: const Icon(Icons.clear),
                                              color: Colors.red,
                                              onPressed: () {
                                                ItemCatalogSearchCubit.get(ctx)
                                                    .clearData();
                                                ItemCatalogSearchCubit.get(ctx)
                                                    .getAllItemsCatalog(
                                                    user.employeeData
                                                        ?.userHrCode ??
                                                        "");
                                                textController.clear();
                                                textFoucus.unfocus();
                                              },
                                            )
                                                : null,
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            prefixIcon:
                                            const Icon(
                                                Icons.search,
                                                color: Colors.white),
                                            border: const OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                borderSide: BorderSide.none)),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        centerTitle: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                      ),
                    ),
                  ),
                  body: itemCatalogSearchWidget(
                      user.employeeData?.userHrCode ?? "")
              );
            },
          )

      ),
    );
  }


}
