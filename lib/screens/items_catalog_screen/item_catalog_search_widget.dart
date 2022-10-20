import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_search_model.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_detail_screen.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'package:flutter/gestures.dart';

Widget itemCatalogSearchWidget(hrcode) {


  getShimmer() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
          child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 20),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Colors.grey.shade100,
                              padding: EdgeInsets.zero,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(20.0),
                                    child: const Icon(Icons.arrow_forward_ios, size: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      );
                    },
                  ),
                )
            ),
      ),
    );
  }




  bool checkList(List<ItemsCatalogTreeModel>? data) {
    if(data != null){
      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }else{
      return false;
    }

  }

  ItemCatalogSearchData getSearchObject(
      ItemCategorygetAllData itemCategorygetAllData) {
    return ItemCatalogSearchData(itemCode: itemCategorygetAllData.itemCode,
      itemPhoto: itemCategorygetAllData.itemPhoto,
      itemName: itemCategorygetAllData.itemName,
      itemDesc: itemCategorygetAllData.itemDesc,);
  }

  Padding buildDivider() {
    return const Padding(
      padding:  EdgeInsets.only(bottom: 15.0),
      child: Divider(
        thickness: 1,
        indent: 15,
        endIndent: 15,
        color: ConstantsColors.bottomSheetBackgroundDark,
      ),
    );
  }


  Padding checkItemsList(List<ItemCategorygetAllData> itemCategoryGetAllData, String treeDirection) {
    if (itemCategoryGetAllData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: itemCategoryGetAllData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      ItemDetailScreen.routeName,
                      arguments: getSearchObject(
                          itemCategoryGetAllData[index]));
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
                              itemCategoryGetAllData[index].itemPhoto ??
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
                              Text(itemCategoryGetAllData[index].itemName ??
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
        ),
      );
    } else {

      if(treeDirection.isNotEmpty){
        EasyLoading.showInfo('No data found');
      }
      return  getShimmer();
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
                ) :  getShimmer(),),
            ]
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 5,
                top: 10,
              ),

              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Home",
                        style: const TextStyle(
                            color: ConstantsColors.backgroundEndColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ItemCatalogSearchCubit.get(context)
                                .setInitialization();
                          }),
                    TextSpan(text: state.treeDirection,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            buildDivider(),
            Expanded(child: checkList(state
                .itemsGetAllTree) //(state.getAllItemsCatalogList.data.isNotEmpty)
                ?
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.itemsGetAllTree.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 20),
                  child: InkWell(
                    onTap: () {
                      if (state.itemsGetAllTree[index].items != null) {
                        if (state.itemsGetAllTree[index].items!.isNotEmpty) {
                          ItemCatalogSearchCubit.get(context).getSubTree(
                              state.itemsGetAllTree[index].items);
                          ItemCatalogSearchCubit.get(context).setTreeDirection(
                              state.itemsGetAllTree[index].text);
                        } else {
                          ItemCatalogSearchCubit.get(context)
                              .getCategoryDataWithId(
                              hrcode, state.itemsGetAllTree[index].id);
                          ItemCatalogSearchCubit.get(context).setTreeDirection(
                              state.itemsGetAllTree[index].text);
                        }
                      } else {
                        ItemCatalogSearchCubit.get(context)
                            .getCategoryDataWithId(
                            hrcode, state.itemsGetAllTree[index].id);
                        ItemCatalogSearchCubit.get(context).setTreeDirection(
                            state.itemsGetAllTree[index].text);
                      }
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
                              getCatalogPhotosCat(
                                  state.itemsGetAllTree[index].image ??
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(state.itemsGetAllTree[index].text ??
                                        "NOt defined",
                                        style: const TextStyle(
                                            fontSize: 18
                                        )),
                                  ],
                                ),
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
            ) :

            checkItemsList(state.itemsGetItemsCategory,state.treeDirection)

            )
          ],
        );
      }
    },
  );
}
