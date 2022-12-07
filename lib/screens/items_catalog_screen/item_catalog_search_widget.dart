import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';

Widget itemCatalogSearchWidget(hrCode) {
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
                              child: Column(),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child:
                                  const Icon(Icons.arrow_forward_ios, size: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  bool checkList(List<ItemsCatalogTreeModel>? data) {
    if (data != null) {
      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // ItemCatalogSearchData getSearchObject(
  //     ItemCategorygetAllData itemCategorygetAllData) {
  //   return ItemCatalogSearchData(
  //     itemCode: itemCategorygetAllData.itemCode,
  //     itemPhoto: itemCategorygetAllData.itemPhoto,
  //     itemName: itemCategorygetAllData.itemName,
  //     itemDesc: itemCategorygetAllData.itemDesc,
  //   );
  // }

  Padding buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Divider(
        thickness: 1,
        indent: 15,
        endIndent: 15,
        color: ConstantsColors.bottomSheetBackgroundDark,
      ),
    );
  }


  // this function for going to the last children then go to the detail screen
  Widget checkItemsList(List<ItemCategorygetAllData> itemCategoryGetAllData, List<String> treeDirection) {
  Widget checkItemsList(List<ItemCategorygetAllData> itemCategoryGetAllData,
      String treeDirection) {
    if (itemCategoryGetAllData.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: itemCategoryGetAllData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
            child: InkWell(
              onTap: () {
                // ItemCatalogSearchCubit.get(context).setDetail(
                //     itemCode: getSearchObject(itemCategoryGetAllData[index])
                //         .itemCode ??
                //         "");
                // Navigator.of(context).pushNamed(
                //     ItemDetailScreen.routeName,
                //     arguments: getSearchObject(itemCategoryGetAllData[index]));
                Navigator.of(context).pushNamed(
                    ItemsCatalogDetailScreen.routeName,
                    arguments: {
                      ItemsCatalogDetailScreen.object: itemCategoryGetAllData[index],
                      ItemsCatalogDetailScreen.userHrCode:hrCode
                    });
              },
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.zero,
                  color: Colors.grey.shade300,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          getCatalogPhotos(
                              itemCategoryGetAllData[index].itemPhoto ?? ""),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Assets.images.favicon.image(
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                itemCategoryGetAllData[index].itemName ??
                                    "Not Defined",
                                style: const TextStyle(
                                  fontSize: 18,
                                )),
                          ],
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
            ),
          );
        },
      );
    } else {
      if (treeDirection.isNotEmpty) {
        EasyLoading.showInfo('No data found');
      }
      return getShimmer();
    }
  }

  return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
    builder: (context, state) {
      if (state.searchString != "" && state.detail == false) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.searchResult.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 20),
                        child: InkWell(
                          onTap: () {
                            // ItemCatalogSearchCubit.get(context).setDetail(
                            //     itemCode:
                            //     state.searchResult[index].itemCode ?? "");
                            ItemCategorygetAllData itemCategorygetAllData =
                                ItemCategorygetAllData(
                                    itemName:
                                        state.searchResult[index].itemName,
                                    itemDesc:
                                        state.searchResult[index].itemDesc,
                                    itemID: state.searchResult[index].itemID,
                                    itemQty: int.parse(
                                        state.searchResult[index].itemQty ??
                                            '0'),
                                    itemPhoto:
                                        state.searchResult[index].itemPhoto,
                                    itemCode:
                                        state.searchResult[index].itemCode);

                            Navigator.of(context).pushNamed(
                                ItemsCatalogDetailScreen.routeName,
                                arguments: {
                                  ItemsCatalogDetailScreen.object:
                                      itemCategorygetAllData,
                                  ItemsCatalogDetailScreen.userHrCode: hrCode
                                });
                            // Navigator.of(context).pushNamed(
                            //     ItemDetailScreen.routeName,
                            //     arguments: state.searchResult[index]);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.zero,
                              height: 100,
                              color: Colors.grey.shade300,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.network(
                                      getCatalogPhotos(
                                          state.searchResult[index].itemPhoto ??
                                              ""),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Assets.images.favicon.image(
                                                  // width: 100,
                                                  // height: 100,
                                                  ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            state.searchResult[index]
                                                    .itemName ??
                                                "Not defined",
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0,),
                                          child: Text(
                                              state.searchResult[index]
                                                      .itemDesc ??
                                                  "No description",
                                              maxLines: 3,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                overflow: TextOverflow.ellipsis,
                                              )),
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
                  )
                : getShimmer(),
          ),
        ]);
      }

      // if (state.detail == true)
      //
      // {
      //
      //   return Text("");
      // }

      else {
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
                    // TextSpan(
                    //   text: state.treeDirection,
                    //   style: const TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 17,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),
            buildDivider(),
            Expanded(
                child: checkList(state
                        .itemsGetAllTree) //(state.getAllItemsCatalogList.data.isNotEmpty)
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.itemsGetAllTree.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20),
                      child: InkWell(
                        onTap: () {
                          if (state.itemsGetAllTree[index].items !=
                              null) {
                            if (state.itemsGetAllTree[index].items!
                                .isNotEmpty) {
                              ItemCatalogSearchCubit.get(context)
                                  .getSubTree(
                                  state.itemsGetAllTree[index].items);
                              ItemCatalogSearchCubit.get(context)
                                  .setTreeDirectionList(
                                  state.itemsGetAllTree[index].text);
                            } else {
                              ItemCatalogSearchCubit.get(context)
                                  .getCategoryDataWithId(hrCode,
                                  state.itemsGetAllTree[index].id);
                              ItemCatalogSearchCubit.get(context)
                                  .setTreeDirectionList(
                                  state.itemsGetAllTree[index].text);
                            }
                          } else {
                            ItemCatalogSearchCubit.get(context)
                                .getCategoryDataWithId(hrCode,
                                state.itemsGetAllTree[index].id);
                            ItemCatalogSearchCubit.get(context)
                                .setTreeDirectionList(
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
                                (state.itemsGetAllTree[index].main_Photo
                                    .toString() !=
                                    'null')
                                    ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0),
                                  child: Image.network(
                                    getCatalogPhotosCat(state
                                        .itemsGetAllTree[index]
                                        .main_Photo
                                        .toString()),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error,
                                        stackTrace) =>
                                        Assets.images.favicon.image(
                                          width: 100,
                                          height: 100,
                                        ),
                                  ),
                                )
                                    : Assets.images.favicon.image(
                                  width: 100,
                                  height: 100,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            state.itemsGetAllTree[index]
                                                .text ??
                                                "Not defined",
                                            style: const TextStyle(
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : checkItemsList(
                    state.itemsGetItemsCategory, state.treeDirection))
          ],
        );
      }
    },
  );
}
