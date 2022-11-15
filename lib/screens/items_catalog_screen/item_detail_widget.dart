import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../constants/colors.dart';
import '../../constants/url_links.dart';

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

Widget itemDetailWidget(dynamic hrcode) {
  TextEditingController textController = TextEditingController();
  return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
      builder: (context, state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 0,
              top: 10,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
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
                  ],
                ),
              ),
            ),
          ),
          buildDivider(),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 15, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                        imageUrl: getCatalogPhotos(
                            state.itemAllDatalist[0].itemPhoto ?? ""),
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Assets.images.loginImageLogo.image(),
                        errorWidget: (context, url, error) => Center(
                            child: Assets.images.loginImageLogo.image())),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state.itemAllDatalist[0].itemName ?? "",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ConstantsColors.bottomSheetBackground),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          (state.favoriteResult.any((element) =>
                                  element.itemCode ==
                                  state.itemAllDatalist[0].itemCode))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.amber,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        onPressed: () async {
                          if (state.favoriteResult.any((element) =>
                              element.itemCode ==
                              state.itemAllDatalist[0].itemCode)) {
                            ItemCatalogSearchCubit.get(context).deleteFavorite(
                                hrCode: hrcode,
                                itemId: state.itemAllDatalist[0].itemID ?? 0);
                          } else {
                            await ItemCatalogSearchCubit.get(context)
                                .setFavorite(
                                    hrCode: hrcode,
                                    itemCode:
                                        state.itemAllDatalist[0].itemID ?? 0);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          (state.cartResult.any((element) =>
                                  element.itemCode ==
                                  state.itemAllDatalist[0].itemID))
                              ? Icons.shopping_cart
                              : Icons.add_shopping_cart_outlined,
                          color: Colors.amber,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        onPressed: () async {
                          if (state.cartResult.any((element) =>
                              element.itemCode ==
                              state.itemAllDatalist[0].itemID)) {
                            ItemCatalogSearchCubit.get(context).deleteFromCart(
                                hrCode: hrcode,
                                itemId: state.itemAllDatalist[0].itemID ?? 0);
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
                                              Navigator.of(context).pop(),
                                          child: const Text(
                                            'Discard',
                                            style: TextStyle(
                                                color: ConstantsColors
                                                    .redAttendance),
                                          )),
                                      TextButton(
                                          onPressed: () async {
                                            await ItemCatalogSearchCubit.get(
                                                    context)
                                                .addToCart(
                                                    hrCode: hrcode,
                                                    itemCode: state
                                                            .itemAllDatalist[0]
                                                            .itemID ??
                                                        0,
                                                    qty: int.parse(
                                                        textController.text))
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
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
                    state.itemAllDatalist[0].itemDesc ?? "",
                    style: const TextStyle(
                        fontSize: 15,
                        color: ConstantsColors.bottomSheetBackground),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(
                      text: state.itemAllDatalist[0].itemCode ?? ""));
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
                          state.itemAllDatalist[0].itemCode ?? "",
                          style: const TextStyle(
                              fontSize: 15,
                              color: ConstantsColors.bottomSheetBackground),
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
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
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
                  if (state.itemAllDatalist.isNotEmpty)
                    Text(
                      state.itemAllDatalist[0].category?.catName ??
                          "Not defined",
                      style: const TextStyle(
                          fontSize: 15,
                          color: ConstantsColors.bottomSheetBackground),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  });
}
