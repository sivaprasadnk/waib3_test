import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:machine_test/screens/home/bottom_nav_bar.dart';
import 'package:machine_test/screens/home/custom_divider.dart';
import 'package:machine_test/screens/home/textfield_container.dart';
import 'package:machine_test/screens/home/where_would_go_container.dart';
import 'package:machine_test/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapController? controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller = MapController.withUserPosition(
        trackUserLocation: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
      );
      setState(() {});
    });
    super.initState();
  }

  GeoPoint? startPoint;
  GeoPoint? endPoint;

  showStartLocation(String loc) async {
    try {
      if (startPoint != null) {
        controller!.removeMarker(startPoint!);
        // controller!.removeRoad(roadKey: roadKey)
      }
      var locations = await addressSuggestion(loc);
      if (locations.isNotEmpty) {
        startPoint = locations.first.point!;

        controller!.addMarker(startPoint!);
        // drawRoute(GeoPoint(latitude: 48.8588443, longitude: 2.2943506), point);
      }
    } catch (e) {
      print(e);
    }
  }

  showEndLocation(String loc) async {
    try {
      if (endPoint != null) {
        controller!.removeMarker(endPoint!);
      }
      var locations = await addressSuggestion(loc);
      if (locations.isNotEmpty) {
        endPoint = locations.first.point!;
        controller!.addMarker(endPoint!);
        drawRoute(startPoint!, endPoint!);
      }
    } catch (e) {
      print(e);
    }
  }

  void drawRoute(GeoPoint startPoint, GeoPoint endPoint) async {
    try {
      await controller!.drawRoad(
        startPoint,
        endPoint,
        // intersectPoint: [
        //   startPoint,
        // ],
        roadType: RoadType.car,
        roadOption: const RoadOption(
          roadWidth: 10,
          roadColor: Colors.blue,
          // showMarkerOfPOI: false,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  List<StaticPositionGeoPoint> staticPoints = [];

  bool showExpandedSheet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          height: showExpandedSheet ? 200 : 100,
          padding: EdgeInsets.only(
            top: 25,
            bottom: showExpandedSheet ? 0 : 25,
            right: 25,
            left: 25,
          ),
          decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: showExpandedSheet
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CustomDivider(),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextfieldContainer(
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  showStartLocation(value);
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  hintText: '58 Hullbrook Road, Billesley, B13',
                                  hintStyle: TextStyle(
                                    color: kGrey2Color,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextfieldContainer(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (value) {
                                  showEndLocation(value);
                                },
                                decoration: const InputDecoration(
                                  hintText: '67, Grand Central Pkwy, Newyork',
                                  hintStyle: TextStyle(
                                    color: kGrey2Color,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showExpandedSheet = true;
                      });
                    },
                    child: const WhereWouldGoContainer(),
                  ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: controller == null
            ? const Center(child: CircularProgressIndicator())
            : OSMFlutter(
                controller: controller!,
                osmOption: OSMOption(
                  // staticPoints: [
                  //   StaticPositionGeoPoint(id, markerIcon, geoPoints)
                  // ],
                  showZoomController: true,
                  userTrackingOption: const UserTrackingOption(
                    enableTracking: true,
                    unFollowUser: true,
                  ),
                  zoomOption: const ZoomOption(
                    initZoom: 15,
                    minZoomLevel: 3,
                    maxZoomLevel: 19,
                    stepZoom: 1.0,
                  ),
                  userLocationMarker: UserLocationMaker(
                    personMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 55,
                      ),
                    ),
                    directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                      ),
                    ),
                  ),
                  roadConfiguration: const RoadOption(
                    roadColor: Colors.yellowAccent,
                  ),

                  // markerOption: MarkerOption(
                  //     defaultMarker: MarkerIcon(
                  //         icon: Icon(
                  //           Icons.person_pin_circle,
                  //           color: Colors.blue,
                  //           size: 56,
                  //         ),
                  //     )

                  //   ),
                ),
              ));
  }
}
