import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/data/models/get_location_model/location_data.dart';
import 'package:hassanallamportalflutter/widgets/background/custom_background.dart';

import '../../constants/google_map_api_key.dart';
import '../../widgets/map/open_map.dart';

class ProjectDetailsScreen extends StatelessWidget {
  static const routeName = 'projects-portfolio-details-screen';
  final LocationData locationData;
  const ProjectDetailsScreen({required this.locationData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: CustomTheme(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                // title: Text(locationData.projectName ?? "Not Defined"),
                actions: [
                  if (locationData.latitude.toString().contains('.') ||
                      locationData.longitude.toString().contains('.'))
                    IconButton(
                        onPressed: () {
                          openMap(locationData.latitude ?? 0,
                              locationData.longitude ?? 0);
                        },
                        icon: const Icon(
                          Icons.directions,
                          // color: ConstantsColors.bottomSheetBackgroundDark,
                        ))
                ],
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                expandedHeight: 300,
                pinned: true,
                // snap: true,
                // floating: true,
                flexibleSpace:  FlexibleSpaceBar(
                  title: Text(
                    locationData.projectName ?? "Not Defined",
                  ),
                  background: Hero(
                    tag: 'googleMapTag',
                    child: CachedNetworkImage(
                      imageUrl: DirectionHelper.generateLocationPreviewImage(
                          latitude: locationData.latitude ?? 30.1073842,
                          longitude: locationData.longitude ?? 31.384012),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const Padding(padding: EdgeInsets.all(10)),
                  // const SizedBox(
                  //   height: 1000,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      'Project Name: \n${locationData.projectName}',
                      style: const TextStyle(fontSize: 16),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      'Project Manager Name: \n${locationData.projectManagerName}',
                      style: const TextStyle(fontSize: 16),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      'Department Name: \n${locationData.departmentName}',
                      style: const TextStyle(fontSize: 16),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  if (locationData.startAt != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        'Starts At: \n${DateTime.parse(locationData.startAt ?? "0")}',
                        style: const TextStyle(fontSize: 16),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  if (locationData.endAt != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        'End At: \n${DateTime.parse(locationData.endAt ?? "0")}',
                        style: const TextStyle(fontSize: 16),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      'Projects Director: \n${locationData.projectsDirector}',
                      style: const TextStyle(fontSize: 16),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(75))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
