import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';

import '../../widgets/map/open_map.dart';
import '../../constants/google_map_api_key.dart';

class GetDirectionWidget extends StatelessWidget {
  final List<LocationData> projectsDirectionData;
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
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black87,
                    title: Text(
                      projectsDirectionData[index].projectName ?? "No Project Name",
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      projectsDirectionData[index].city ?? "No Project City",
                      textAlign: TextAlign.center,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          openMap(projectsDirectionData[index].latitude ?? 0,
                              projectsDirectionData[index].longitude ?? 0);
                        },
                        icon: const Icon(Icons.directions)),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      openMap(projectsDirectionData[index].latitude ?? 0,
                          projectsDirectionData[index].longitude ?? 0);
                    },
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/fulllogoblue.png'),
                      image: CachedNetworkImageProvider(
                          DirectionHelper.generateLocationPreviewImage(
                              latitude: projectsDirectionData[index]
                                  .latitude ?? 0,
                              longitude: projectsDirectionData[index]
                                  .longitude ?? 0)),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
