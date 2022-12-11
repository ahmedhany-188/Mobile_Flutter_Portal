import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/data/models/items_catalog_models/item_catalog_all_data.dart';
import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'cart_screen.dart';
import 'items_catalog_screen_getall.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_catalog_detail_screen.dart';
import 'package:hassanallamportalflutter/widgets/error/error_widget.dart';

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
            title: const Text('Favourite'),
            leading: InkWell(onTap: () => Navigator.of(context).pushReplacementNamed(ItemsCatalogGetAllScreen.routeName),child: const Icon(Icons.home)),
            elevation: 0,
            backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
            actions: <Widget>[
          IconButton(
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
          ..getFavoriteItems(userHrCode: user.employeeData?.userHrCode ?? "")
        ..getCartItems(userHrCode: user.employeeData?.userHrCode ?? ""),
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
              ),),
                  Expanded(
                    child: state.favoriteResult.isNotEmpty?ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.favoriteResult.length,
                      itemBuilder: (context, index) {
                        return
                          Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 20),
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
                    ):
                    emptyFavoriteWidget(),
                  ),
                ],
              );
            } else {
              return emptyFavoriteWidget();
            }
          },
        ),
      ),
    );
  }

  Center emptyFavoriteWidget(){
    return Center(
      child: Padding(
        padding:  const EdgeInsets.all(10.0),
        child: noDataFoundContainerCatalog("Your Favorite List is Empty"),
      ),
    );
  }
}

