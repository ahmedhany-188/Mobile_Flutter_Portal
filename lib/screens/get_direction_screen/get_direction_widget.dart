import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';
import 'package:hassanallamportalflutter/gen/assets.gen.dart';

import '../../widgets/map/open_map.dart';
import '../../constants/google_map_api_key.dart';

class GetDirectionWidget extends StatelessWidget {
  final List<LocationData> projectsDirectionData;
  const GetDirectionWidget(this.projectsDirectionData, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: projectsDirectionData.isNotEmpty,
      builder: (context) => ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: projectsDirectionData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
                  title: Text(
                    projectsDirectionData[index].projectName ??
                        "No Project Name",
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
                  onTap: () {
                    openMap(projectsDirectionData[index].latitude ?? 0,
                        projectsDirectionData[index].longitude ?? 0);
                  },
                  child: FadeInImage(
                    placeholder: Assets.images.loginImageLogo.image().image,
                    imageErrorBuilder: (_, __, ___) =>
                        Assets.images.loginImageLogo.image(),
                    image: CachedNetworkImageProvider(
                        DirectionHelper.generateLocationPreviewImage(
                            latitude:
                                projectsDirectionData[index].latitude ?? 0,
                            longitude:
                                projectsDirectionData[index].longitude ?? 0)),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,)),
    );
  }
}
