import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/screens/items_catalog_screen/item_detail_screen.dart';

import '../../constants/url_links.dart';
import '../../data/models/items_catalog_models/item_catalog_search_model.dart';
import '../../gen/assets.gen.dart';

Widget itemCatalogSearchWidget(List<ItemCatalogSearchData> list) {
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
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: (list.isNotEmpty)
            ? ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ItemDetailScreen.routeName,
                            arguments: list[index]);
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
                                getCatalogPhotos(list[index].itemPhoto ?? ""),
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
                                    Text(list[index].itemName!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          list[index].itemDesc ??
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
}
