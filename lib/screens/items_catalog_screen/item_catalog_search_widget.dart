import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_detail_screen.dart';

import '../../bloc/items_catalog_bloc/item_catalog_search/item_catalog_search_cubit.dart';
import '../../constants/url_links.dart';
import '../../gen/assets.gen.dart';

Widget itemCatalogSearchWidget() {
  return BlocBuilder<ItemCatalogSearchCubit, ItemCatalogSearchInitial>(
    builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              bottom: 15,
              top: 10,
            ),
            child: Text(
              'Search Result',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: (state.searchResult.isNotEmpty && state.searchString.isNotEmpty)
                ? ListView.builder(
              shrinkWrap: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              itemCount: state.searchResult.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 20),
                  child: InkWell(
                    onTap: () async{
                      Navigator.of(context).pushNamed(
                          ItemDetailScreen.routeName,
                          arguments: state.searchResult[index]);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.zero,
                        color: Colors.grey.shade300,
                        child: Row(
                          children: [
                            Image.network(
                              getCatalogPhotos(state.searchResult[index].itemPhoto ?? ""),
                              width: 100,
                              height: 100,
                              errorBuilder: (context, error, stackTrace) =>
                                  Assets.images.favicon.image(
                                    width: 100,
                                    height: 100,
                                  ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(state.searchResult[index].itemName ?? "NOt defined",
                                      style: const TextStyle(
                                        fontSize: 18,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        state.searchResult[index].itemDesc ??
                                            "No description",
                                        style: const TextStyle(fontSize: 14)),
                                  ),
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
                : const Center(
              child: Text("No data found"),
            ),
          )
        ],
      );
    },
  );
}
