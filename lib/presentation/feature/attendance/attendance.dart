import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

import '../../../helpers/colors_custom.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance>
    with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> controller = Completer();
  late GoogleMapController kcontroller;

  final formatTimeSeconds = DateFormat('HH:mm:ss');

  TextEditingController searchController = TextEditingController();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<Placemark> placemark = [];

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(-6.175392, 106.827153),
    zoom: 0,
  );
  Marker? marker;

  String timeString = '00:00:00';

  bool loading = true;
  bool hide = false;
  bool isLocationServiceEnabled = false;

  bool searchbar = false;

  void _getTime() {
    final String formattedDateTime = formatTimeSeconds.format(DateTime.now());
    if (mounted) {
      setState(() {
        timeString = formattedDateTime;
      });
    }
  }

  Future<void> checkLocation() async {
    setState(() {
      loading = true;
    });
    try {
      kcontroller = await controller.future;

      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      geolocator.Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      const MarkerId markerId = MarkerId('1');
      List<Placemark> getPlacemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        marker = Marker(
          markerId: markerId,
          position: LatLng(position.latitude, position.longitude),
          anchor: const Offset(0.5, 1.5),
        );
        markers[markerId] = marker!;
        placemark = getPlacemark;
      });

      CameraPosition goPosition = CameraPosition(
          bearing: 0,
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.151926040649414);

      kcontroller.animateCamera(CameraUpdate.newCameraPosition(goPosition));
      setState(() {
        loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        loading = false;
      });
    }
  }

  void hideSeek() {
    setState(() {
      hide = !hide;
    });
  }

  Future<void> loader() async {
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        loading = false;
      });
    });

    await checkLocation();
  }

  Future<void> onSubmitLocation() async {
    String location =
        "${Platform.isIOS ? placemark[0].locality : placemark[0].subAdministrativeArea}, ${placemark[0].country}";
    // Navigator.pushReplacement(
    //     // ignore: use_build_context_synchronously
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             Adzan(mode: widget.mode == 'home' ? 'home' : 'init')));
  }

  Future listenForPermissionStatus() async {
    permission.ServiceStatus serviceStatus =
        await permission.Permission.location.serviceStatus;
    bool enabled = (serviceStatus == permission.ServiceStatus.enabled);

    if (enabled) {
      setState(() {
        isLocationServiceEnabled = true;
      });
    }
  }

  @override
  void initState() {
    listenForPermissionStatus();
    checkLocation();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loader();
      Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: <Widget>[
      SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: kGooglePlex,
          onMapCreated: (GoogleMapController theController) {
            controller.complete(theController);
          },
          markers: Set<Marker>.of(markers.values),
        ),
      ),
      AnimatedOpacity(
          opacity: loading ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            color: ColorsCustom.primary.withOpacity(0.7),
            child: Center(child: CircularProgressIndicator()),
          )),
      AnimatedPositioned(
        bottom: hide ? -200 : 0,
        left: 0,
        right: 0,
        duration: const Duration(milliseconds: 250),
        child: AnimatedOpacity(
          opacity: loading ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 15),
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius:
                              8.0, // has the effect of softening the shadow
                          spreadRadius:
                              2.0, // has the effect of extending the shadow
                          offset: const Offset(
                            0.0, // horizontal, move right 10
                            0.0, // vertical, move down 10
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () => hideSeek(),
                    child: hide
                        ? const Icon(Icons.arrow_upward)
                        : const Icon(Icons.arrow_downward),
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 450),
                curve: Curves.fastLinearToSlowEaseIn,
                child: Container(
                  constraints: const BoxConstraints(minHeight: 150),
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius:
                              8.0, // has the effect of softening the shadow
                          spreadRadius:
                              5.0, // has the effect of extending the shadow
                          offset: const Offset(
                            0.0, // horizontal, move right 10
                            4.0, // vertical, move down 10
                          ),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Waktu",
                        style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.timelapse, color: ColorsCustom.primary),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              timeString,
                              style: TextStyle(
                                  color: ColorsCustom.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Lokasi Anda",
                        style: TextStyle(
                            color: ColorsCustom.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_pin, color: ColorsCustom.primary),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              loading || placemark.isEmpty
                                  ? "Waiting..."
                                  : Platform.isIOS
                                      ? "${placemark[0].locality ?? '-'}, ${placemark[0].country ?? '-'}"
                                      : "${placemark[0].subAdministrativeArea ?? '-'}, ${placemark[0].country ?? '-'}",
                              style: TextStyle(
                                  color: ColorsCustom.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: screenSize.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: ColorsCustom.primary,
                            textStyle: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () => onSubmitLocation(),
                          child: Text(
                            "Absen Sekarang",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
