import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hassanallamportalflutter/constants/colors.dart';
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
          appBar: AppBar(
            title: Text(locationData.projectName ?? "Not Defined"),
            actions: [
              if (locationData.latitude.toString().contains('.') ||
                  locationData.longitude.toString().contains('.'))
                IconButton(
                    splashRadius: 1,
                    onPressed: () =>
                        openMap(locationData.latitude ?? 0,
                            locationData.longitude ?? 0),
                    icon: const Icon(
                      Icons.directions,
                    )),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (locationData.latitude.toString().contains('.') ||
                        locationData.longitude.toString().contains('.')) {
                      openMap(locationData.latitude ?? 0,
                          locationData.longitude ?? 0);
                    }
                  },
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.30,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(
                          DirectionHelper.generateLocationPreviewImage(
                              latitude: locationData.latitude ?? 30.1073842,
                              longitude: locationData.longitude ?? 31.384012),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white24,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [

                        textHead('Project Name:'),
                        textLine(locationData.projectName.toString()),

                        textHead('Project Manager Name:'),
                        textLine(locationData.projectManagerName.toString()),

                        textHead('Department Name:'),
                        textLine(locationData.departmentName.toString()),

                        // if (locationData.startAt != null)
                        //   Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 8.0),
                        //     child: Text(
                        //       'Starts At: \n${DateTime.parse(
                        //           locationData.startAt ?? "0")}',
                        //       style: const TextStyle(fontSize: 16),
                        //       // textAlign: TextAlign.center,
                        //     ),
                        //   ),
                        // if (locationData.endAt != null)
                        //   Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 8.0),
                        //     child: Text(
                        //       'End At: \n${DateTime.parse(
                        //           locationData.endAt ?? "0")}',
                        //       style: const TextStyle(fontSize: 16),
                        //       // textAlign: TextAlign.center,
                        //     ),
                        //   ),

                        textHead('Projects Director:'),
                        textLine(locationData.projectsDirector.toString()),

                        textHead('HR Coordinator:'),
                        textLine(locationData.hrCoordinator.toString()),

                        textHead('HR SectionHead:'),
                        textLine(locationData.hrSectionHead.toString()),

                        textHead('HRAssWages:'),
                        textLine(locationData.hrAssWages.toString()),

                        textHead('Project Status:'),
                        textLine(locationData.status.toString()),

                        textHead('Project City:'),
                        textLine(locationData.city.toString()),

                        textHead('Project Start Date:'),
                        textLine(locationData.startAt.toString()),

                        textHead('Project End Date:'),
                        textLine(locationData.endAt.toString()),

                        textHead('Project Admin:'),
                        textLine(locationData.projectAdmin.toString()),

                        textHead('Project ID:'),
                        textLine(locationData.projectId.toString()),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row textHead(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              name, style: const TextStyle(
              color: ConstantsColors.appraisalColor3,
              fontSize: 17,
              fontFamily: 'Nunito',
            ),
            ),
          ),
        ),
      ],
    );
  }

  Row textLine(String line) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 3, top: 3, bottom: 3),
              child: Text(
                line,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          )
        ]);
  }
}
