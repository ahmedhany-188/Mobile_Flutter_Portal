import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/items_catalog_tree_model.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'catalog_shimmer.dart';
import '../../widgets/error/error_widget.dart';

Widget itemCatalogSearchWidget(hrCode) {

  Padding networkImageFunction(String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CachedNetworkImage(
          imageUrl: getCatalogPhotos(image),
          width: 100,
          height: 100,
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              Assets.images.loginImageLogo.image(),
          errorWidget: (context, url, error) =>
              Center(
                  child: Assets.images.loginImageLogo
                      .image())
      ),
    );
  }

  Container backImgeFunction() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Icon(Icons.arrow_forward_ios,
          size: 18),
    );
  }

  Text textFunction(String text, double fontSize, int maxLines) {
    return Text(
        text,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize,
          overflow: TextOverflow.ellipsis,
        ));
  }

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
                  'null')?
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0),
                child: CachedNetworkImage(
                    imageUrl: getCatalogPhotosCat(mainPhoto ?? ""),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        Assets.images.loginImageLogo.image(),
                    errorWidget: (context, url, error) =>
                        Center(
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
                      textFunction(itemName ??
                          "Not defined", 18.0, 2),
                    ],
                  ),
                ),
              ),
              backImgeFunction(),
            ],
          ),
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
  Widget checkItemsList(List<ItemCategorygetAllData> itemCategoryGetAllData, ItemCatalogSearchState state) {
    if(state.itemCatalogSearchEnumStates==ItemCatalogSearchEnumStates.noDataFound){
      return Center(
        child: Container(
          child:noDataFoundContainerCatalog("Category is empty"),
        ),
      );
    }else if(state.itemCatalogSearchEnumStates==ItemCatalogSearchEnumStates.noConnection){
      return Center(
        child: Container(
          child:noDataFoundContainerCatalog("No internet connection"),
        ),
      );
    }else if (itemCategoryGetAllData.isNotEmpty) {
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
                      networkImageFunction(
                          itemCategoryGetAllData[index].itemPhoto ?? ""),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textFunction(
                                itemCategoryGetAllData[index].itemName ??
                                    "Not Defined", 18.0, 2),
                          ],
                        ),
                      ),
                      backImgeFunction(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return getShimmer();
    }
  }

  Center getSearchResult(ItemCatalogSearchState state){
    if(state.itemCatalogSearchEnumStates==ItemCatalogSearchEnumStates.noDataFound){
      return Center(
          child: Container(
            child:noDataFoundContainerCatalog("No data found"),
        ),
      );
    }else if(state.itemCatalogSearchEnumStates==ItemCatalogSearchEnumStates.noConnection){
      return Center(
          child: Container(
            child:noDataFoundContainerCatalog("No internet connection"),
          ),
      );
    }else{
      return  Center(
        child: Container(
            child: getShimmer(),),
      );
    }
  }

  return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
    builder: (context, state) {
      if (state.searchString != "" && state.detail == true) {
        return WillPopScope(
          onWillPop: () async {
            int treeLength = ItemCatalogSearchCubit.get(context)
                .getTreeLenght();
            if (treeLength == 1) {
              if(state.searchString.isNotEmpty){
                ItemCatalogSearchCubit.get(context).setInitialization();
                return false;
              }else{
                EasyLoading.dismiss();
                return true;
              }
            } else {
              treeLength--;
              treeLength--;
              if (treeLength == 0) {
                ItemCatalogSearchCubit.get(context).setInitialization();
              }
              ItemCatalogSearchCubit.get(context).getNewSubTree(treeLength);
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
                'Search Result ',
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
                      },
                      borderRadius: BorderRadius.circular(20),
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.zero,
                          color: Colors.grey.shade300,
                          child: Row(
                            children: [
                              networkImageFunction(
                                  state.searchResult[index].itemPhoto ?? ""),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    textFunction(state.searchResult[index]
                                        .itemName ??
                                        "Not defined", 18.0, 2),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8.0,),
                                      child: textFunction(
                                          state.searchResult[index].itemDesc ??
                                              "No description", 13.0, 3),
                                    ),
                                  ],
                                ),
                              ),
                              backImgeFunction()
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
                  :getSearchResult(state),
            ),
          ]),
        );
      }
      else {
        return WillPopScope(
            onWillPop: () async {
              int treeLength = ItemCatalogSearchCubit.get(context)
                  .getTreeLenght();
              if (treeLength == 1) {
                if(state.searchString.isNotEmpty){
                  ItemCatalogSearchCubit.get(context).setInitialization();
                  return false;
                }else{
                  EasyLoading.dismiss();
                  return true;
                }
              } else {
                treeLength--;
                treeLength--;
                if (treeLength == 0) {
                  ItemCatalogSearchCubit.get(context).setInitialization();
                }
                ItemCatalogSearchCubit.get(context).getNewSubTree(treeLength);
                return false;
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        for (int i = 0; i < state.treeDirectionList.length; i++)
                          TextSpan(
                            text: '${state.treeDirectionList[i]} >  ',
                            style: const TextStyle(
                                fontSize: 15, color: ConstantsColors
                                .bottomSheetBackground, fontStyle: FontStyle
                                .italic
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (state.treeDirectionList[i] == "Home" &&
                                    i == 0) {
                                  ItemCatalogSearchCubit.get(context)
                                      .setInitialization();
                                } else {
                                  ItemCatalogSearchCubit.get(context)
                                      .getNewSubTree(i);
                                }
                              },
                          ),
                      ],
                    ),
                  ),
                ),
                buildDivider(),
                Expanded(
                    child: checkList(state
                        .itemsGetAllTree) && !state
                        .itemCategoryShow //(state.getAllItemsCatalogList.data.isNotEmpty)
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
                        state.itemsGetItemsCategory, state))
              ],
            )
        );
      }
    },
  );



}
