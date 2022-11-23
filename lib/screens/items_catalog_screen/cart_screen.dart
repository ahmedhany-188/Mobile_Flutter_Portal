import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';


import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'export_excel.dart';
import 'favorite_screen.dart';
import 'item_catalog_search_widget.dart';

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
                            .pushNamed(FavoriteScreen.routeName);
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
        onPressed: () => importData(ItemCatalogSearchCubit.get(context).state.cartResult,() {
          ItemCatalogSearchCubit.get(context).deleteAllCart(hrCode: user.employeeData?.userHrCode ??"");
        }),
        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: Assets.images.excel.image(fit: BoxFit.scaleDown,scale: 13),
        label: const Text('Export to Excel'),
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
                              ItemCatalogSearchCubit.get(context).setDetail(
                                  itemCode: state.cartResult[index].itmCatItems
                                          ?.itemCode ??
                                      "");
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
              return itemCatalogSearchWidget(
                  user.employeeData?.userHrCode ?? "");
            }
          },
        ),
      ),
    );
  }
}
