import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../constants/google_map_api_key.dart';
import 'get_direction_screen.dart';

class GetDirectionWidget extends StatelessWidget {
  List<dynamic> projectsDirectionData;
  GetDirectionWidget(this.projectsDirectionData,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(maintainBottomViewPadding: true,
      child: ConditionalBuilder(
        condition: projectsDirectionData.isNotEmpty,
        builder: (context) => GridView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: projectsDirectionData.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  // header: GridTileBar(
                  //   title: Text(
                  //     projectsDirectionData[index]['city'],
                  //     textAlign: TextAlign.center,
                  //   ),
                  //   backgroundColor: Colors.black45,
                  // ),
                  child: Hero(
                    tag: 'product',
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/images/1.png'),
                      image: NetworkImage(DirectionHelper
                          .generateLocationPreviewImage(
                          latitude: projectsDirectionData[index]
                          ['latitude'],
                          longitude: projectsDirectionData[index]
                          ['longitude'])),
                      fit: BoxFit.cover,
                    ),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    title: Text(
                      projectsDirectionData[index]['projectName'],
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      projectsDirectionData[index]['city'],
                      textAlign: TextAlign.center,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          GetDirectionScreen.openMap(
                              projectsDirectionData[index]['latitude'],
                              projectsDirectionData[index]['longitude']);
                        },
                        icon: const Icon(Icons.directions)),
                  ),
                ),
              ),
            );
          },
        ),
        fallback: (context) =>
            const Center(child: LinearProgressIndicator()),
      ),
    );
  }
}
