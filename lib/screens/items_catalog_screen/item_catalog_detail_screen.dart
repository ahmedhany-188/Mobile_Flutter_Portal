import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../constants/url_links.dart';
import 'package:flutter/services.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';
import '../../widgets/dialogpopoup/dialog_popup_catalog_item_share.dart';



class ItemsCatalogDetailScreen extends StatefulWidget {

  static const routeName = '/itemscatalog-detail-screen';
  static const  itemCode = "itemCode";
  static const  itemPhoto = "itemPhoto";
  static const  itemName = "itemName";
  static const  itemDesc = "itemDesc";
  static const  itemID = "itemID";

  static const userHrCode = "userHrCode";
  const ItemsCatalogDetailScreen({Key? key, this.requestData}) : super(key: key);

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

    TextEditingController textController = TextEditingController();
    return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Item Catalog', style: TextStyle(
                  color: ConstantsColors.bottomSheetBackground,
                  fontWeight: FontWeight.bold),),
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
                    element.itemCode ==
                        currentRequestData[ItemsCatalogDetailScreen.itemCode]))
                        ? Icons.favorite
                        : Icons.favorite_border_rounded,
                    color: ConstantsColors
                        .bottomSheetBackgroundDark,
                  ),
                  padding: EdgeInsets.zero,
                  iconSize: 30,
                  onPressed: () async {
                    if (state.favoriteResult.any((element) =>
                    element.itemCode ==
                        currentRequestData[ItemsCatalogDetailScreen
                            .itemCode])) {
                      ItemCatalogSearchCubit.get(context).deleteFavorite(
                          hrCode: currentRequestData[ItemsCatalogDetailScreen
                              .userHrCode],
                          itemId: currentRequestData[ItemsCatalogDetailScreen
                              .itemID] ?? 0);
                    } else {
                      await ItemCatalogSearchCubit.get(context)
                          .setFavorite(
                          hrCode: currentRequestData[ItemsCatalogDetailScreen
                              .userHrCode],
                          itemCode:
                          currentRequestData[ItemsCatalogDetailScreen.itemID] ?? 0);
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
                          borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 6.0),
                            //Same as `blurRadius` i guess
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 15, bottom: 10),

                              child: CachedNetworkImage(
                                  imageUrl: getCatalogPhotos(
                                      currentRequestData[ItemsCatalogDetailScreen
                                          .itemPhoto] ?? ""),
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      Assets.images.loginImageLogo.image(),
                                  errorWidget: (context, url, error) =>
                                      Center(
                                          child: Assets.images.loginImageLogo
                                              .image())),
                            ),
                          ),),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            currentRequestData[ItemsCatalogDetailScreen
                                .itemName] ?? "",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ConstantsColors.bottomSheetBackground),
                          ),
                        ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
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
                            currentRequestData[ItemsCatalogDetailScreen
                                .itemDesc] ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                color: ConstantsColors.bottomSheetBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(
                              text: currentRequestData[ItemsCatalogDetailScreen
                                  .itemCode] ?? ""));
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
                                  currentRequestData[ItemsCatalogDetailScreen
                                      .itemCode] ?? "",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: ConstantsColors
                                          .bottomSheetBackground),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return DialogCatalogShareItemBottomSheet(
                                  value: "https://apps.hassanallam.com/Catalogue/item/" +
                                      currentRequestData[ItemsCatalogDetailScreen
                                          .itemID.toString()],
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
                                  "Item id:" +
                                      currentRequestData[ItemsCatalogDetailScreen
                                          .itemID.toString()],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: ConstantsColors
                                          .bottomSheetBackground),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
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
                            // currentRequestData[ItemsCatalogDetailScreen.itemCategoryGetAllData].category?.catName ??
                            "Not defined",
                            style: const TextStyle(
                                fontSize: 15,
                                color: ConstantsColors.bottomSheetBackground),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 6.0),
                              //Same as `blurRadius` i guess
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: ConstantsColors.bottomSheetBackground,
                                boxShadow: [
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
                                    child: Text("Add To Cart", style: TextStyle(
                                        color: Colors.white, fontSize: 18),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: IconButton(
                                      icon: Icon(
                                        (state.cartResult.any((element) =>
                                        element.itemCode ==
                                            currentRequestData[ItemsCatalogDetailScreen
                                                .itemID]))
                                            ? Icons.shopping_cart
                                            : Icons.add_shopping_cart_outlined,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      iconSize: 30,
                                      onPressed: () async {
                                        if (state.cartResult.any((element) =>
                                        element.itemCode ==
                                            currentRequestData[ItemsCatalogDetailScreen
                                                .itemID])) {
                                          ItemCatalogSearchCubit.get(context)
                                              .deleteFromCart(
                                              hrCode: currentRequestData[ItemsCatalogDetailScreen
                                                  .userHrCode],
                                              itemId: currentRequestData[ItemsCatalogDetailScreen
                                                  .itemID] ?? 0);
                                        } else {
                                          await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (ctx) {
                                              return CustomTheme(
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(20)),
                                                  backgroundColor: ConstantsColors
                                                      .bottomSheetBackgroundDark,
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(context)
                                                                .pop(),
                                                        child: const Text(
                                                          'Discard',
                                                          style: TextStyle(
                                                              color: ConstantsColors
                                                                  .redAttendance),
                                                        )),
                                                    TextButton(
                                                        onPressed: () async {
                                                          await ItemCatalogSearchCubit
                                                              .get(
                                                              context)
                                                              .addToCart(
                                                              hrCode: currentRequestData[ItemsCatalogDetailScreen
                                                                  .userHrCode],
                                                              itemCode: currentRequestData[ItemsCatalogDetailScreen
                                                                  .itemID] ??
                                                                  0,
                                                              qty: int.parse(
                                                                  textController
                                                                      .text))
                                                              .then((value) =>
                                                              Navigator.of(context)
                                                                  .pop());
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
                                                    keyboardType: TextInputType
                                                        .number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                          RegExp(r'^[1-9][0-9]*'))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                            ),
                          ),
                        ],
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