import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import 'dart:io';
// import 'package:open_file/open_file.dart' as open_file;
import 'package:open_file_safe/open_file_safe.dart' as open_file;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/error/error_widget.dart';
import 'favorite_screen.dart';
import 'items_catalog_order_history_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      await Process.run(
          'start', <String>['$path\\$fileName'], runInShell: true);
    } else if (Platform.isMacOS) {
      await Process.run('open', <String>['$path/$fileName'], runInShell: true);
    } else if (Platform.isLinux) {
      await Process.run('xdg-open', <String>['$path/$fileName'],
          runInShell: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    MainUserData user = BlocProvider
        .of<AppBloc>(context)
        .state
        .userData;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Hero(
          tag: 'hero',
          child: AppBar(
            title: const Text('Cart'),
            leading: InkWell(onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.home)),
            elevation: 0,
            backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushReplacementNamed(FavoriteScreen.routeName);
                  },
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .pushReplacementNamed(
                        ItemCatalogOrderHistory.routeName);
                  },
                  icon: const Icon(Icons.history)),
            ],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
        {
          ItemCatalogSearchCubit.get(context).placeOrder(
              hrCode: user.employeeData?.userHrCode ?? ""),
          //,cartList:ItemCatalogSearchCubit.get(context).state.cartResult );
        },
        backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        icon: Assets.images.excel.image(fit: BoxFit.scaleDown, scale: 13),
        label: const Text('Export'),
      ),
      body: BlocProvider<ItemCatalogSearchCubit>.value(
        value: ItemCatalogSearchCubit.get(context)
          ..getCartItems(userHrCode: user.employeeData?.userHrCode ?? ""),
        child: BlocConsumer<ItemCatalogSearchCubit, ItemCatalogSearchState>(
          listener: (context, state) {
            if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.success) {
              EasyLoading.dismiss();
            } else if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.noConnection) {
              EasyLoading.showError("No Internet Connection");
            } else if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.failed) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("error"),
                ),
              );
            } else if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.loadingTreeData) {
              EasyLoading.show();
            } else if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.noDataFound) {
              EasyLoading.showError("No Data Found");
            }
          },
          builder: (context, state) {
            return (state.cartResult.isNotEmpty) ? ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.cartResult.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20),
                  child: InkWell(
                    onTap: () {
                      ItemCategorygetAllData itemCategorygetAllData = ItemCategorygetAllData(
                          itemName: state.cartResult[index].itmCatItems
                              ?.itemName,
                          itemDesc: state.cartResult[index].itmCatItems
                              ?.itemDesc,
                          itemID: state.cartResult[index].itmCatItems?.itemID,
                          itemQty: state.cartResult[index].itmCatItems?.itemQty,
                          itemPhoto: state.cartResult[index].itmCatItems
                              ?.itemPhoto,
                          itemCode: state.cartResult[index].itmCatItems
                              ?.itemCode);

                      Navigator.of(context).pushNamed(
                          ItemsCatalogDetailScreen.routeName,
                          arguments: {
                            ItemsCatalogDetailScreen
                                .object: itemCategorygetAllData,
                            ItemsCatalogDetailScreen.userHrCode: user
                                .employeeData?.userHrCode ?? "",
                            ItemsCatalogDetailScreen.objectID: state
                                .cartResult[index].id ?? 0,
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
                                      "Quantity: ${state.cartResult[index]
                                          .itemQty ?? 0}",
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
            ) : getCartResult(state);
          },
        ),
      ),
    );
  }
}

Center getCartResult(ItemCatalogSearchState state) {
  if (state.itemCatalogSearchEnumStates ==
      ItemCatalogSearchEnumStates.noDataFound) {
    return Center(child: noDataFoundContainerCatalog("List is empty"));
  } else if (state.itemCatalogSearchEnumStates ==
      ItemCatalogSearchEnumStates.noConnection) {
    return Center(child: noDataFoundContainerCatalog("No internet connection"));
  }  else if(state.itemCatalogSearchEnumStates ==
      ItemCatalogSearchEnumStates.failed) {
    return Center(child: noDataFoundContainerCatalog("Something went wrong"));
  }else{
    return Center(child: noDataFoundContainerCatalog(""));
  }
}
