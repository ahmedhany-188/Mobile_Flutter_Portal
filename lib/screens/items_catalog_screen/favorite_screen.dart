import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_app_status_bloc/app_bloc.dart';
import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';
import 'item_catalog_search_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const routeName = 'item-catalog-favorite-screen';

  @override
  Widget build(BuildContext context) {
    MainUserData user = BlocProvider.of<AppBloc>(context).state.userData;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Hero(
          tag: 'hero',
          child: AppBar(
            title: const Text('Favorite'),
            elevation: 0,
            backgroundColor: ConstantsColors.bottomSheetBackgroundDark,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: TextButton(onPressed: ()async{
                await ItemCatalogSearchCubit.get(context).deleteAllFavorite(hrCode: user.employeeData?.userHrCode ??"");
              },
                  child: const Text('Clear List',style: TextStyle(color: ConstantsColors.redAttendance),)),
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.favoriteResult.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              ItemCatalogSearchCubit.get(context).setDetail(
                                  itemCode:
                                      state.favoriteResult[index].itemCode ?? "");
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
