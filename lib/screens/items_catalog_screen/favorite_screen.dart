import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import '../../widgets/error/error_widget.dart';
import 'cart_screen.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const routeName = 'item-catalog-favorite-screen';


  @override
  Widget build(BuildContext context) {
    MainUserData user = BlocProvider.of<AppBloc>(context).state.userData;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Hero(
          tag: 'hero',
          child: AppBar(
            title: const Text('Favorite'),
            leading: InkWell(onTap: () => Navigator.of(context).pop(),child: const Icon(Icons.home)),
            elevation: 0,
            backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
            actions: <Widget>[IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(CartScreen.routeName);
          },
        ),],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5.0),
              child: TextButton.icon(
                onPressed: ()async{
                await ItemCatalogSearchCubit.get(context).deleteAllFavorite(hrCode: user.employeeData?.userHrCode ??"");
              },
                icon: const Icon(Icons.clear,color: Colors.red,),
                label: const Text('Clear List',style: TextStyle(color: Colors.red),),
                style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),)),
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
      body: BlocProvider<ItemCatalogSearchCubit>.value(
        value: ItemCatalogSearchCubit.get(context)
          ..getFavoriteItems(userHrCode: user.employeeData?.userHrCode ?? ""),
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
            }else if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.loadingTreeData) {
              EasyLoading.show();
            }else if (state.itemCatalogSearchEnumStates ==
                ItemCatalogSearchEnumStates.noDataFound) {
              EasyLoading.showError("No Data Found");
            }
          },
          builder: (context, state) {
                return (state.favoriteResult.isNotEmpty)? ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.favoriteResult.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 20),
                      child: InkWell(
                        onTap: () {
                          ItemCategorygetAllData itemCategorygetAllData=ItemCategorygetAllData(itemName: state.favoriteResult[index].itemName,
                              itemDesc: state.favoriteResult[index].itemDesc,
                              itemID: state.favoriteResult[index].itemID,itemQty:state.favoriteResult[index].itemQty,itemPhoto: state.favoriteResult[index].itemPhoto,itemCode: state.favoriteResult[index].itemCode);
                          Navigator.of(context).pushNamed(
                              ItemsCatalogDetailScreen.routeName,
                              arguments: {
                                ItemsCatalogDetailScreen.object: itemCategorygetAllData,
                                ItemsCatalogDetailScreen.userHrCode:user.employeeData?.userHrCode ?? ""
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
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Image.network(
                                    getCatalogPhotos(
                                        state.favoriteResult[index].itemPhoto ??
                                            ""),
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
                                          state.favoriteResult[index].itemName ??
                                              "Not Defined",
                                          style: const TextStyle(
                                            fontSize: 18,
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
                )
                    :getFavoriteResult(state);
            },
          ),
        ),
    );
  }
}

Center getFavoriteResult(ItemCatalogSearchState state) {
  if (state.itemCatalogSearchEnumStates ==
      ItemCatalogSearchEnumStates.noDataFound) {
    return Center(child: noDataFoundContainerCatalog("List is empty"));
  } else if (state.itemCatalogSearchEnumStates ==
      ItemCatalogSearchEnumStates.noConnection) {
    return Center(child: noDataFoundContainerCatalog("No internet connection"));
  } else {
    return Center(child: noDataFoundContainerCatalog("Something went wrong"));
  }
}
