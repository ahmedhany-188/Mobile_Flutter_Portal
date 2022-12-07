import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../constants/url_links.dart';
import 'package:flutter/services.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../widgets/dialogpopoup/dialog_popup_catalog_item_share.dart';

class ItemsCatalogDetailScreen extends StatefulWidget {
  static const routeName = '/itemscatalog-detail-screen';
  static const object = "object";

  static const userHrCode = "userHrCode";

  static const objectID = 0;
  const ItemsCatalogDetailScreen({Key? key, this.requestData})
      : super(key: key);

  final dynamic requestData;

  @override
  State<ItemsCatalogDetailScreen> createState() =>
      ItemsCatalogDetailScreenClass();
}

class ItemsCatalogDetailScreenClass extends State<ItemsCatalogDetailScreen> {
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

  @override
  Widget build(BuildContext context) {
    final currentRequestData = widget.requestData;

    ItemCategorygetAllData itemCategorygetAllData =
        currentRequestData[ItemsCatalogDetailScreen.object];

    TextEditingController textController = TextEditingController();
    return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Item Catalog',
            style: TextStyle(
                color: ConstantsColors.bottomSheetBackground,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.chevron_left,
                color: ConstantsColors.bottomSheetBackground, size: 50),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                (state.favoriteResult.any((element) =>
                        element.itemCode == itemCategorygetAllData.itemCode))
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: ConstantsColors.bottomSheetBackgroundDark,
              ),
              padding: EdgeInsets.zero,
              iconSize: 30,
              onPressed: () async {
                if (state.favoriteResult.any((element) =>
                    element.itemCode == itemCategorygetAllData.itemCode)) {
                  ItemCatalogSearchCubit.get(context).deleteFavorite(
                      hrCode: currentRequestData[
                          ItemsCatalogDetailScreen.userHrCode],
                      itemId: itemCategorygetAllData.itemID ?? 0);
                } else {
                  await ItemCatalogSearchCubit.get(context).setFavorite(
                      hrCode: currentRequestData[
                          ItemsCatalogDetailScreen.userHrCode],
                      itemCode: itemCategorygetAllData.itemID ?? 0);
                }
              },
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: const EdgeInsets.only(bottom: 6.0),
                  //Same as `blurRadius` i guess
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(70.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    // image: DecorationImage(
                    //   fit: BoxFit.fill,
                    //   image: CachedNetworkImageProvider(
                    //     getCatalogPhotos(
                    //         itemCategorygetAllData.itemPhoto ?? ""),
                    //     // width: double.infinity,
                    //     // placeholder: (context, url) =>
                    //     //     Assets.images.loginImageLogo.image(),
                    //     // errorWidget: (context, url, error) => Center(
                    //     //     child: Assets.images.loginImageLogo.image()),
                    // ),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 5, bottom: 50),
                    child: CachedNetworkImage(
                        imageUrl: getCatalogPhotos(
                            itemCategorygetAllData.itemPhoto ?? ""),
                        width: double.infinity,
                        placeholder: (context, url) =>
                            Assets.images.loginImageLogo.image(),
                        errorWidget: (context, url, error) => Center(
                            child: Assets.images.loginImageLogo.image())),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 25),
                child: Center(
                  child: Text(
                    itemCategorygetAllData.itemName ?? "",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ConstantsColors.bottomSheetBackground),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantsColors.bottomSheetBackground),
                      ),
                      Text(
                        itemCategorygetAllData.itemDesc ?? "",
                        style: const TextStyle(
                            fontSize: 15,
                            color: ConstantsColors.bottomSheetBackground),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(
                          text: itemCategorygetAllData.itemCode ?? ""));
                      EasyLoading.showInfo('Code Copied');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Code",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ConstantsColors.bottomSheetBackground),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemCategorygetAllData.itemCode ?? "",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color:
                                      ConstantsColors.bottomSheetBackground),
                            ),
                            const Icon(Icons.copy, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () async {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return DialogCatalogShareItemBottomSheet(
                              value:
                                  "https://apps.hassanallam.com/Catalogue/item/${itemCategorygetAllData.itemID}",
                            );
                          });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Share Item",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ConstantsColors.bottomSheetBackground),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item id: ${itemCategorygetAllData.itemID}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color:
                                      ConstantsColors.bottomSheetBackground),
                            ),
                            const Icon(Icons.share, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ConstantsColors.bottomSheetBackground),
                      ),
                      // if (currentRequestData[ItemsCatalogDetailScreen.itemDesc.isNotEmpty])
                      Text(
                        itemCategorygetAllData.category?.catName ??
                            "Not defined",
                        style: const TextStyle(
                            fontSize: 15,
                            color: ConstantsColors.bottomSheetBackground),
                      ),
                    ],
                  ),
                ),
              ),

              /// Add to cart button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: InkWell(
                  onTap: () async {
                    if (state.cartResult.any((element) =>
                        element.itemCode == itemCategorygetAllData.itemID)) {
                      for (int i = 0; i < state.cartResult.length; i++) {
                        if (state.cartResult[i].itemCode ==
                            itemCategorygetAllData.itemID) {
                          ItemCatalogSearchCubit.get(context).deleteFromCart(
                              hrCode: currentRequestData[
                                  ItemsCatalogDetailScreen.userHrCode],
                              itemId: state.cartResult[i].id ?? 0);
                        }
                      }
                    } else {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) {
                          return CustomTheme(
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor:
                                  ConstantsColors.bottomSheetBackgroundDark,
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      'Discard',
                                      style: TextStyle(
                                          color:
                                              ConstantsColors.redAttendance),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      await ItemCatalogSearchCubit.get(
                                              context)
                                          .addToCart(
                                              hrCode: currentRequestData[
                                                  ItemsCatalogDetailScreen
                                                      .userHrCode],
                                              itemCode: itemCategorygetAllData
                                                      .itemID ??
                                                  0,
                                              qty: int.parse(
                                                  textController.text))
                                          .then((value) =>
                                              Navigator.of(context).pop());
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                          color: ConstantsColors
                                              .greenAttendance),
                                    )),
                              ],
                              title: const Text('Add Quantity'),
                              content: TextFormField(
                                controller: textController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[1-9][0-9]*'))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    //Same as `blurRadius` i guess
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: ConstantsColors.bottomSheetBackground,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (state.cartResult.any((element) =>element.itemCode ==itemCategorygetAllData.itemID))? 'Remove from cart':'Add to cart',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            (state.cartResult.any((element) =>
                                    element.itemCode ==
                                    itemCategorygetAllData.itemID))
                                ? Icons.shopping_cart
                                : Icons.add_shopping_cart_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          // IconButton(
                          //   icon: Icon(
                          //     (state.cartResult.any((element) =>
                          //     element.itemCode ==
                          //         itemCategorygetAllData.itemID))
                          //         ? Icons.shopping_cart
                          //         : Icons.add_shopping_cart_outlined,
                          //     color: Colors.white,size: 30,
                          //   ),
                          //   padding: EdgeInsets.zero,
                          //   iconSize: 30,
                          //   onPressed: () async {
                          //
                          //     if (state.cartResult.any((element) =>
                          //     element.itemCode ==
                          //         itemCategorygetAllData.itemID)) {
                          //
                          //       for(int i=0;i<state.cartResult.length;i++){
                          //         if(state.cartResult[i].itemCode==itemCategorygetAllData.itemID){
                          //
                          //           ItemCatalogSearchCubit.get(context)
                          //               .deleteFromCart(
                          //               hrCode: currentRequestData[ItemsCatalogDetailScreen
                          //                   .userHrCode],
                          //               itemId: state.cartResult[i].id ?? 0);
                          //         }
                          //       }
                          //
                          //     } else {
                          //       await showDialog(
                          //         context: context,
                          //         barrierDismissible: false,
                          //         builder: (ctx) {
                          //           return CustomTheme(
                          //             child: AlertDialog(
                          //               shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius.circular(20)),
                          //               backgroundColor: ConstantsColors
                          //                   .bottomSheetBackgroundDark,
                          //               actions: [
                          //                 TextButton(
                          //                     onPressed: () =>
                          //                         Navigator.of(context)
                          //                             .pop(),
                          //                     child: const Text(
                          //                       'Discard',
                          //                       style: TextStyle(
                          //                           color: ConstantsColors
                          //                               .redAttendance),
                          //                     )),
                          //                 TextButton(
                          //                     onPressed: () async {
                          //                       await ItemCatalogSearchCubit
                          //                           .get(
                          //                           context)
                          //                           .addToCart(
                          //                           hrCode: currentRequestData[ItemsCatalogDetailScreen
                          //                               .userHrCode],
                          //                           itemCode: itemCategorygetAllData.itemID ??
                          //                               0,
                          //                           qty: int.parse(
                          //                               textController
                          //                                   .text))
                          //                           .then((value) =>
                          //                           Navigator.of(context)
                          //                               .pop());
                          //                     },
                          //                     child: const Text(
                          //                       'Save',
                          //                       style: TextStyle(
                          //                           color: ConstantsColors
                          //                               .greenAttendance),
                          //                     )),
                          //               ],
                          //               title: const Text('Add Quantity'),
                          //               content: TextFormField(
                          //                 controller: textController,
                          //                 keyboardType: TextInputType
                          //                     .number,
                          //                 inputFormatters: [
                          //                   FilteringTextInputFormatter
                          //                       .allow(
                          //                       RegExp(r'^[1-9][0-9]*'))
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //       );
                          //     }
                          //   },
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
