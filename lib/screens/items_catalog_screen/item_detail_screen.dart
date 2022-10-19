import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hassanallamportalflutter/bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';

import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../data/models/items_catalog_models/item_catalog_search_model.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({required this.itemFromPreviousScreen, Key? key})
      : super(key: key);

  static const routeName = 'item-detail-screen';
  final ItemCatalogSearchData itemFromPreviousScreen;

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    FocusNode textFoucus = FocusNode();
    return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
      builder: (context, state) {
        ItemCatalogSearchCubit.get(context).getAllCatalogList(itemCode: itemFromPreviousScreen.itemCode ??"");
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130.0),
            child: Hero(
              tag: 'hero',
              child: AppBar(
                title: const Text('Item Catalog'),
                elevation: 0,
                backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 40, bottom: 20),
                    child: TextFormField(
                      focusNode: textFoucus,
                      // key: uniqueKey,
                      controller: textController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (text) {
                        ItemCatalogSearchCubit.get(context).setSearchString(text);

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
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                                itemFromPreviousScreen.itemPhoto ?? ""),
                            fit: BoxFit.fill,placeholder:(context, url) => Assets.images.loginImageLogo.image(),
                            errorWidget: (context, url, error) => Center(
                                child: Assets.images.loginImageLogo.image())),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Text(
                        itemFromPreviousScreen.itemName ?? "",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ConstantsColors.bottomSheetBackground),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
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
                        itemFromPreviousScreen.itemDesc ?? "",
                        style: const TextStyle(
                            fontSize: 15,
                            color: ConstantsColors.bottomSheetBackground),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: itemFromPreviousScreen.itemCode ?? ""));
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
                              itemFromPreviousScreen.itemCode ?? "",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: ConstantsColors.bottomSheetBackground),
                            ),
                            const Icon(Icons.copy, size: 14),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
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
                      if(state.itemAllDatalist.isNotEmpty)Text(
                        state.itemAllDatalist[0].category?.catName ?? "Not defined",
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
      },
    );
  }
}

// Widget buildItemDetail(ItemCatalogSearchData itemFromPreviousScreen){
//   return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
//       builder: (context, state) {
//     ItemCatalogSearchCubit.get(context).getAllCatalogList(itemCode: itemFromPreviousScreen.itemCode ??"");
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           height: MediaQuery.of(context).size.height * 0.4,
//           width: MediaQuery.of(context).size.width * 0.9,
//           decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(15)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 15.0, right: 15, top: 15, bottom: 10),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: CachedNetworkImage(
//                           imageUrl: getCatalogPhotos(
//                               itemFromPreviousScreen.itemPhoto ?? ""),
//                           fit: BoxFit.fill,
//                           errorWidget: (context, url, error) => Center(
//                               child: Assets.images.loginImageLogo.image())),
//                     ),
//                   )),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, bottom: 10),
//                 child: Text(
//                   itemFromPreviousScreen.itemName ?? "",
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: ConstantsColors.bottomSheetBackground),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Description",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: ConstantsColors.bottomSheetBackground),
//                 ),
//                 Text(
//                   itemFromPreviousScreen.itemDesc ?? "",
//                   style: const TextStyle(
//                       fontSize: 15,
//                       color: ConstantsColors.bottomSheetBackground),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: InkWell(
//               onTap: () async {
//                 await Clipboard.setData(ClipboardData(text: itemFromPreviousScreen.itemCode ?? ""));
//                 EasyLoading.showInfo('Code Copied');
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Code",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: ConstantsColors.bottomSheetBackground),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         itemFromPreviousScreen.itemCode ?? "",
//                         style: const TextStyle(
//                             fontSize: 15,
//                             color: ConstantsColors.bottomSheetBackground),
//                       ),
//                       Icon(Icons.copy, size: 14),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Category",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: ConstantsColors.bottomSheetBackground),
//                 ),
//                 if(state.itemAllDatalist.isNotEmpty)Text(
//                   state.itemAllDatalist[0].category?.catName ?? "Not defined",
//                   style: const TextStyle(
//                       fontSize: 15,
//                       color: ConstantsColors.bottomSheetBackground),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   });
// }
