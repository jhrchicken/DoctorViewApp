import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/theme/colors.dart';
import 'package:doctorviewapp/widgets/doctor/doctor_item_widget.dart';
import 'package:doctorviewapp/widgets/hospital/hospital_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospDoctorListScreen extends StatefulWidget {
  final int tabIndex;
  final String city;
  final String district;
  final String town;
  final String tag;

  const HospDoctorListScreen({
    super.key,
    this.tabIndex = 0,
    this.city = '',
    this.district = '',
    this.town = '',
    this.tag = '',
  });

  @override
  State<HospDoctorListScreen> createState() => _HospDoctorListScreenState();
}

class _HospDoctorListScreenState extends State<HospDoctorListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchWord = "";

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);
    final hospitalProvider = Provider.of<HospitalProvider>(context);
    final hashtagProvider = Provider.of<HashtagProvider>(context);

    return DefaultTabController(
      length: 2,
      initialIndex: widget.tabIndex,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchWord = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '병원명 혹은 의사명을 검색하세요',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Icon(
                Icons.search_rounded,
                color: Colors.grey[900],
              ),
            ],
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: '병원'),
              Tab(text: '의사'),
            ],
            indicatorColor: pointColor2,
            labelColor: pointColor2,
            unselectedLabelColor: Colors.grey[500],
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        body: TabBarView(
          children: [
            // 병원 목록
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: hospitalProvider.searchHosp(_searchWord).where((hospital) {
                  // address가 빈 문자열이 아닐 경우 필터링
                  bool addressFilter = (widget.city.isNotEmpty && widget.district.isNotEmpty && widget.town.isNotEmpty)
                      ? hospital.address.contains(widget.city) &&
                        hospital.address.contains(widget.district) &&
                        hospital.address.contains(widget.town)
                      : true;
                  // tag가 빈 문자열이 아닐 경우 필터링
                  bool tagFilter = widget.tag.isNotEmpty 
                      ? hashtagProvider.listHospHashtag(hospital.id)
                          .any((hashtag) => hashtag.tag == widget.tag)
                      : true;
                  return addressFilter && tagFilter;
                }).toList().length,
                itemBuilder: (context, index) {
                  final hospital = hospitalProvider.searchHosp(_searchWord).where((hospital) {
                    // address가 빈 문자열이 아닐 경우 필터링
                    bool addressFilter = (widget.city.isNotEmpty && widget.district.isNotEmpty && widget.town.isNotEmpty)
                      ? hospital.address.contains(widget.city) &&
                        hospital.address.contains(widget.district) &&
                        hospital.address.contains(widget.town)
                      : true;
                    // tag가 빈 문자열이 아닐 경우 필터링
                    bool tagFilter = widget.tag.isNotEmpty 
                        ? hashtagProvider.listHospHashtag(hospital.id)
                            .any((hashtag) => hashtag.tag == widget.tag)
                        : true;
                    return addressFilter && tagFilter;
                  }).toList()[index];
                  return Column(
                    children: [
                      HospitalItemWidget(
                        id: hospital.id,
                      ),
                      if (index < hospitalProvider.searchHosp(_searchWord).where((hospital) {
                        // address가 빈 문자열이 아닐 경우 필터링
                        bool addressFilter = (widget.city.isNotEmpty && widget.district.isNotEmpty && widget.town.isNotEmpty)
                          ? hospital.address.contains(widget.city) &&
                            hospital.address.contains(widget.district) &&
                            hospital.address.contains(widget.town)
                          : true;
                        // tag가 빈 문자열이 아닐 경우 필터링
                        bool tagFilter = widget.tag.isNotEmpty 
                            ? hashtagProvider.listHospHashtag(hospital.id)
                                .any((hashtag) => hashtag.tag == widget.tag)
                            : true;
                        return addressFilter && tagFilter;
                      }).toList().length - 1)
                        Divider(color: Colors.grey[100], thickness: 1.0),
                    ],
                  );
                },
              ),
            ),
            // 의사 목록
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: doctorProvider.searchDoctor(_searchWord).length,
                itemBuilder: (context, index) {
                  final doctor = doctorProvider.searchDoctor(_searchWord)[index];
                  return Column(
                    children: [
                      DoctorItemWidget(
                        docIdx: doctor.docIdx,
                      ),
                      if (index < doctorProvider.searchDoctor(_searchWord).length - 1)
                        Divider(color: Colors.grey[100], thickness: 1.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
