
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


Container backImgeFunction() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: const Icon(Icons.arrow_forward_ios,
        size: 18),
  );
}

getShimmer() {


  return Padding(
    padding: const EdgeInsets.all(5),
    child: SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 20),
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.grey.shade100,
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(),
                          ),
                          backImgeFunction(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    ),
  );
}
