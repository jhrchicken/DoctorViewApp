import 'package:doctorviewapp/screens/hosp_doctor_list_screen.dart';
import 'package:flutter/material.dart';

class AddressSearchWidget extends StatefulWidget {
  const AddressSearchWidget({super.key});

  @override
  State<AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<AddressSearchWidget> {

  // 주소 선택을 위한 변수
  String? _selectedCity; // 선택된 광역시도
  String? _selectedDistrict; // 선택된 시군구
  String? _selectedTown; // 선택된 읍면동
  // 광역시도 목록
  List<String> cities = ['서울특별시', '부산광역시', '대구', '인천', '광주', '대전', '울산'];
  // 광역시도에 따른 시군구 목록
  Map<String, List<String>> districts = {
    '서울특별시': ['강남구', '서초구', '강북구', '종로구'],
    '부산광역시': ['해운대구', '수영구', '사하구'],
    '대구': ['달서구', '수성구'],
    '인천': ['남동구', '연수구'],
    '광주': ['동구', '서구'],
    '대전': ['유성구', '서구'],
    '울산': ['남구', '동구'],
  };
  // 시군구에 따른 읍면동 목록
  Map<String, List<String>> towns = {
    '강남구': ['역삼동', '삼성동', '논현동'],
    '서초구': ['서초동', '반포동', '잠원동'],
    '종로구': ['부암동', '삼청동', '관철동'],
    '해운대구': ['좌동', '중동', '송정동'],
    '사하구': ['괴정동', '당리동'],
    '수성구': ['수성동', '범어동', '만촌동'],
    '달서구': ['월성동', '상인동'],
  };

  // 검색 함수
  void _searchAddress() {
    if (_selectedCity != null && _selectedDistrict != null && _selectedTown != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HospDoctorListScreen(
            city: '$_selectedCity',
            district: '$_selectedDistrict',
            town: '$_selectedTown',
          ),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '지역으로 병원을 검색해보세요',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // 광역시도 드롭다운
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                      hint: Text(
                        '광역시도',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      value: _selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCity = newValue;
                          _selectedDistrict = null;
                          _selectedTown = null;
                        });
                      },
                      items: cities.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // 시군구 드롭다운
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                      hint: Text(
                        '시/군/구',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      value: _selectedDistrict,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue;
                          _selectedTown = null;
                        });
                      },
                      items: (_selectedCity != null && districts[_selectedCity!] != null)
                          ? districts[_selectedCity!]!.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                  const SizedBox(width: 4),
                  // 읍면동 드롭다운
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                      hint: Text(
                        '읍/면/동',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      value: _selectedTown,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTown = newValue;
                          if (_selectedTown != null) {
                            _searchAddress();
                          }
                        });
                      },
                      items: (_selectedDistrict != null && towns[_selectedDistrict!] != null)
                          ? towns[_selectedDistrict!]!.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
