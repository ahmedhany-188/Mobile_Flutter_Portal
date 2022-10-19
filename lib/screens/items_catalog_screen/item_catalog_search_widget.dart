import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_detail_screen.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';

Widget itemCatalogSearchWidget() {
  bool checkList(List<ItemsCatalogTreeModel>? data) {
    if (data == null || data.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
    builder: (context, state) {
      if (state.searchString != "") {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  bottom: 15,
                  top: 10,
                ),
                child: Text(
                  'Search Result',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: (state.searchResult.isNotEmpty &&
                    state.searchString.isNotEmpty)
                    ? ListView.builder(
                  shrinkWrap: true,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                      .onDrag,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.searchResult.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20),
                      child: InkWell(
                        onTap: () async {
                          Navigator.of(context).pushNamed(
                              ItemDetailScreen.routeName,
                              arguments: state.searchResult[index]);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.zero,
                            color: Colors.grey.shade300,
                            child: Row(
                              children: [
                                Image.network(
                                  getCatalogPhotos(
                                      state.searchResult[index].itemPhoto ??
                                          ""),
                                  width: 100,
                                  height: 100,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Assets.images.favicon.image(
                                        width: 100,
                                        height: 100,
                                      ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(state.searchResult[index].itemName ??
                                          "NOt defined",
                                          style: const TextStyle(
                                            fontSize: 18,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0),
                                        child: Text(
                                            state.searchResult[index]
                                                .itemDesc ??
                                                "No description",
                                            style: const TextStyle(
                                                fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const Icon(Icons.arrow_forward_ios,
                                      size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ) : const Center(child: Text("No data found")),),
            ]
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                bottom: 15,
                top: 10,
              ),
              child: Text(
                state.treeDirection,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: checkList(state
                    .itemsGetAllTree) //(state.getAllItemsCatalogList.data.isNotEmpty)
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.itemsGetAllTree.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          if (state.itemsGetAllTree[index].items != null) {
                            ItemCatalogSearchCubit.get(context).getSubTree(
                                state.itemsGetAllTree[index].items,
                                state.itemsGetAllTree[index].text);
                          } else {

                          }
                          // print(state.getAllItemsCatalogList.data?[index].items?[index].text);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.zero,
                            color: Colors.grey.shade300,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(state.itemsGetAllTree[index].text ??
                                          "NOt defined",
                                          style: const TextStyle(
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const Icon(Icons.arrow_forward_ios,
                                      size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ) : const Center(child: Text("No data found"))
            )
          ],
        );
      }
    },
  );
}
