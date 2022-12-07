import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';

import 'dart:io';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/background/custom_background.dart';
import 'export_excel.dart';
import 'favorite_screen.dart';
import 'items_catalog_screen_getall.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = 'item-catalog-cart-screen';

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    //Get the storage folder location using path_provider package.
    String? path;
    if (Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isLinux ||
        Platform.isWindows) {
      final Directory directory =
      await path_provider.getApplicationSupportDirectory();
      path = directory.path;
    } else {
      path = await PathProviderPlatform.instance.getApplicationSupportPath();
    }
    final File file =
    File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    if (Platform.isAndroid || Platform.isIOS) {
      //Launch the file (used open_file package)
      await open_file.OpenFile.open('$path/$fileName');
    } else if (Platform.isWindows) {
      await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }

  @override
  Widget build(BuildContext context) {


    MainUserData user = BlocProvider.of<AppBloc>(context).state.userData;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Hero(
          tag: 'hero',
          child: AppBar(
            title: const Text('Cart'),
            leading: InkWell(onTap: () => Navigator.of(context).pushReplacementNamed(ItemsCatalogGetAllScreen.routeName),child: const Icon(Icons.home)),
            elevation: 0,
            backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
            centerTitle: true,
            actions: [
              BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
                // buildWhen: (previous, current) => previous.cartResult != current.cartResult,
                builder: (context, state) {
                  return IconButton(
                      onPressed: () async {
                        ItemCatalogSearchCubit.get(context).clearData();

                        await Navigator.of(context)
                            .pushReplacementNamed(FavoriteScreen.routeName);
                      },
                      icon: const Icon(Icons.favorite));
                },
              ),
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
        ),
      ),
        floatingActionButton:FloatingActionButton.extended(
        onPressed: () => importDataCart(ItemCatalogSearchCubit.get(context).state.cartResult,() {
          ItemCatalogSearchCubit.get(context).deleteAllCart(hrCode: user.employeeData?.userHrCode ??"");//,cartList:ItemCatalogSearchCubit.get(context).state.cartResult );
        }),
        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: Assets.images.excel.image(fit: BoxFit.scaleDown,scale: 13),
        label: const Text('Export'),
      ),
      body: BlocProvider<ItemCatalogSearchCubit>.value(
        value: ItemCatalogSearchCubit.get(context)
          ..getCartItems(userHrCode: user.employeeData?.userHrCode ?? "")
          ..getFavoriteItems(userHrCode: user.employeeData?.userHrCode ?? ""),
        child: BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchState>(
          builder: (context, state) {
            if (state.detail == false) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      bottom: 5,
                      top: 10,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.cartResult.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              // ItemCatalogSearchCubit.get(context).setDetail(
                              //     itemCode: state.cartResult[index].itmCatItems
                              //             ?.itemCode ??
                              //         "");
                              ItemCategorygetAllData itemCategorygetAllData=ItemCategorygetAllData(itemName: state.cartResult[index].itmCatItems?.itemName,
                                  itemDesc: state.cartResult[index].itmCatItems?.itemDesc,
                                  itemID: state.cartResult[index].itmCatItems?.itemID,itemQty:state.cartResult[index].itmCatItems?.itemQty,
                                  itemPhoto: state.cartResult[index].itmCatItems?.itemPhoto,itemCode: state.cartResult[index].itmCatItems?.itemCode);

                              Navigator.of(context).pushNamed(
                                  ItemsCatalogDetailScreen.routeName,
                                  arguments: {
                                    ItemsCatalogDetailScreen.object : itemCategorygetAllData,
                                    ItemsCatalogDetailScreen.userHrCode : user.employeeData?.userHrCode ?? "",
                                    ItemsCatalogDetailScreen.objectID:state.cartResult[index].id??0,
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
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Image.network(
                                        getCatalogPhotos(state.cartResult[index]
                                                .itmCatItems?.itemPhoto ??
                                            ""),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Assets.images.favicon.image(
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              state.cartResult[index]
                                                      .itmCatItems?.itemName ??
                                                  "Not Defined",
                                              style: const TextStyle(
                                                fontSize: 18,
                                              )),
                                          Text(
                                              "Quantity: ${state.cartResult[index].itemQty ?? 0}",
                                              style: const TextStyle(
                                                fontSize: 15,
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
                  ),
                ],
              );
            } else {
              return itemDetailWidgetInternal(
                  user.employeeData?.userHrCode ?? "");
            }
          },
        ),
      ),
    );
  }
}

Widget itemDetailWidgetInternal(dynamic hrcode) {
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
                            text: "Back",
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
              const Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Divider(
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                  color: ConstantsColors.bottomSheetBackgroundDark,
                ),
              ),
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
