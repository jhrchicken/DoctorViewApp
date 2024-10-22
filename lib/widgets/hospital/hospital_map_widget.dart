import 'dart:async';

import 'package:doctorviewapp/models/hospital.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HospitalMapWidget extends StatefulWidget {
  final String id;

  const HospitalMapWidget({
    super.key,
    required this.id,
  });

  @override
  State<HospitalMapWidget> createState() => _HospitalMapWidgetState();
}

class _HospitalMapWidgetState extends State<HospitalMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  late Hospital hospital;
  Marker? marker;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    
    hospital = hospitalProvider.selectHosp(widget.id)!;

    if (hospital.lat != null && hospital.lng != null) {
      makeMarker();
    }
  }

  void makeMarker() {
    marker = Marker(
      markerId: MarkerId(widget.id),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      position: LatLng(hospital.lat!, hospital.lng!),
      infoWindow: InfoWindow(
        title: hospital.name,
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '위치',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // 지도 또는 위치 정보 없음 메시지 표시
        hospital.lat == null || hospital.lng == null
            ? Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '위치정보가 없습니다',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 240,
                width: double.infinity,
                child: Center(
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(hospital.lat!, hospital.lng!),
                      zoom: 17.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: marker != null ? {marker!} : {},
                  ),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        // 지도 하단 주소 표시
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                hospital.address,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: hospital.address));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
                minimumSize: const Size(0, 30),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
              ),
              child: Text(
                '주소복사',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}