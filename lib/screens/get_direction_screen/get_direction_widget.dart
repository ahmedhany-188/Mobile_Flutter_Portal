import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../widgets/map/open_map.dart';
import '../../constants/google_map_api_key.dart';

class GetDirectionWidget extends StatelessWidget {
  final List<dynamic> projectsDirectionData;
  const GetDirectionWidget(this.projectsDirectionData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
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
                          openMap(projectsDirectionData[index]['latitude'],
                              projectsDirectionData[index]['longitude']);
                        },
                        icon: const Icon(Icons.directions)),
                  ),
                  child: Hero(
                    tag: 'tag$index',
                    child: GestureDetector(
                      onTap: (){
                        openMap(projectsDirectionData[index]['latitude'],
                            projectsDirectionData[index]['longitude']);
                      },
                      child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/images/fulllogoblue.png'),
                        image: NetworkImage(
                            DirectionHelper.generateLocationPreviewImage(
                                latitude: projectsDirectionData[index]
                                    ['latitude'],
                                longitude: projectsDirectionData[index]
                                    ['longitude'])),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        fallback: (context) => const Center(child: LinearProgressIndicator()),
      ),
    );
  }
}
