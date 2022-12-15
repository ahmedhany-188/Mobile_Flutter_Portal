import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import 'package:shimmer/shimmer.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget itemCatalogSearchWidget(hrCode) {
  ClipRRect catalogWidgetMainPage(String ?mainPhoto, String ?itemName) {
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.zero,
          color: Colors.grey.shade300,
          child: Row(
            children: [
              (mainPhoto !=
                  'null')
                  ? Padding(
                padding: const EdgeInsets.only(
                    right: 8.0),
                child: CachedNetworkImage(
                  imageUrl: getCatalogPhotosCat(mainPhoto ?? ""),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        Assets.images.loginImageLogo.image(),
                    errorWidget: (context, url, error) => Center(
                        child: Assets.images.loginImageLogo.image())
                ),
              )
                  : Assets.images.loginImageLogo.image(
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
                          itemName ??
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
      );
  }

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
                    child:
                    ClipRRect(
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
  Widget checkItemsList(List<ItemCategorygetAllData> itemCategoryGetAllData,
      List<String> treeDirection) {
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
                Navigator.of(context).pushNamed(
                    ItemsCatalogDetailScreen.routeName,
                    arguments: {
                      ItemsCatalogDetailScreen
                          .object: itemCategoryGetAllData[index],
                      ItemsCatalogDetailScreen.userHrCode: hrCode
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
                        child: CachedNetworkImage(
                            imageUrl: getCatalogPhotos(itemCategoryGetAllData[index].itemPhoto ?? ""),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Assets.images.loginImageLogo.image(),
                            errorWidget: (context, url, error) => Center(
                                child: Assets.images.loginImageLogo.image())
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
      // TODO: Check the value is found or not
      if (treeDirection.length == 1) {
        // EasyLoading.showInfo('No data found');
      }
      return getShimmer();
    }
  }

  return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
    builder: (context, state) {
      if (state.searchString != "" && state.detail == false) {
        return WillPopScope(
          onWillPop: () async {
            int treeLenght = ItemCatalogSearchCubit.get(context)
                .getTreeLenght();
            if (treeLenght == 1) {
              return true;
            } else {
              treeLenght--;
              treeLenght--;
              if (treeLenght == 0) {
                ItemCatalogSearchCubit.get(context).setInitialization();
              }
              ItemCatalogSearchCubit.get(context).getNewSubTree(treeLenght);
              return false;
            }
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.zero,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CachedNetworkImage(
                                    imageUrl: getCatalogPhotos(state.searchResult[index].itemPhoto ?? ""),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        Assets.images.loginImageLogo.image(),
                                    errorWidget: (context, url, error) => Center(
                                        child: Assets.images.loginImageLogo.image())
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
          ]),
        );
      }
      else {
        return WillPopScope(
            onWillPop: () async {
              int treeLenght = ItemCatalogSearchCubit.get(context)
                  .getTreeLenght();
              if (treeLenght == 1) {
                return true;
              } else {
                treeLenght--;
                treeLenght--;
                if (treeLenght == 0) {
                  ItemCatalogSearchCubit.get(context).setInitialization();
                }
                ItemCatalogSearchCubit.get(context).getNewSubTree(treeLenght);
                return false;
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,

                      physics: const BouncingScrollPhysics(),
                      itemCount: state.treeDirectionList.length,
                      itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.all(3.0),
                          child: InkWell(
                            onTap: () {
                              if (state.treeDirectionList[index] == "Home" &&
                                  index == 0) {
                                ItemCatalogSearchCubit.get(context)
                                    .setInitialization();
                              } else {
                                ItemCatalogSearchCubit.get(context)
                                    .getNewSubTree(
                                    index);
                              }
                            },
                            child: Text("${state.treeDirectionList[index]} > ",
                              style: const TextStyle(fontSize: 15,
                                  color: ConstantsColors.bottomSheetBackground,
                                  fontStyle: FontStyle.italic),),
                          ),
                        );
                      }),
                ),

                buildDivider(),
                Expanded(
                    child: checkList(state
                        .itemsGetAllTree) && !state.itemCategoryShow//(state.getAllItemsCatalogList.data.isNotEmpty)
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
                              if (state.listTapAction == false) {
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
                              }
                            },
                            onDoubleTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child:
                            catalogWidgetMainPage(
                                state.itemsGetAllTree[index].main_Photo
                                    .toString(),
                                state.itemsGetAllTree[index].text ??
                                    "Not defined"),
                          ),
                        );
                      },
                    )
                        : checkItemsList(
                        state.itemsGetItemsCategory, state.treeDirectionList))
              ],
            )
        );
      }
    },
  );
}
