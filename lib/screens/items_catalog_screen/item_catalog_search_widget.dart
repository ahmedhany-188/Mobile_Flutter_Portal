import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

Widget itemCatalogSearchWidget() {
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
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.zero,
                    color: Colors.grey.shade300,
                    child: Row(
                      children: [
                        Assets.images.favicon.image(
                          width: 100,
                          height: 100,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Testing Headline',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('testing subtitle',
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}
