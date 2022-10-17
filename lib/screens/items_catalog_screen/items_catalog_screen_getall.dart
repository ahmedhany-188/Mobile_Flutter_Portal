import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../data/data_providers/general_dio/general_dio.dart';
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
    return BlocProvider<ItemCatalogSearchCubit>(
      create: (context) => ItemCatalogSearchCubit(GeneralDio(
          BlocProvider.of<AppBloc>(context).state.userData)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: AppBar(
            title: const Text('Item Catalog'),
            elevation: 0,
            backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40.0, right: 40, bottom: 20),
                child: BlocBuilder<ItemCatalogSearchCubit,
                    ItemCatalogSearchInitial>(
                  builder: (ctx, state) {
                    return TextFormField(
                      focusNode: textFoucus,
                      // key: uniqueKey,
                      controller: textController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (text) {
                        ItemCatalogSearchCubit.get(ctx).setSearchString(text);
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          filled: true,
                          focusColor: Colors.white,
                          fillColor: Colors.grey.shade400.withOpacity(0.4),
                          // labelText: "Search contact",
                          hintText: 'Item Name',
                          suffixIcon: (textController.text.isNotEmpty ||
                              textController.text != "")
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            color: Colors.red,
                            onPressed: () {
                              textController.clear();
                              textFoucus.unfocus();
                            },
                          )
                              : null,
                          hintStyle: const TextStyle(color: Colors.white),
                          prefixIcon:
                          const Icon(Icons.search, color: Colors.white),
                          border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none)),
                    );
                  },
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
        body: BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchInitial>(
          buildWhen: (pre, curr) => pre.searchResult != curr.searchResult,
          builder: (context, state) {
            return itemCatalogSearchWidget(
                state.searchResult);
          },
        ),
      ),
    );
  }
}
