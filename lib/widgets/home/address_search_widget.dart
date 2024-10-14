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
  List<String> cities = ['서울특별시', '부산', '대구', '인천', '광주', '대전', '울산'];
  // 광역시도에 따른 시군구 목록
  Map<String, List<String>> districts = {
    '서울특별시': ['강남구', '서초구', '강북구', '종로구'],
    '부산': ['해운대구', '수영구', '사하구'],
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
    '종로구': ['부암동', '삼청동'],
    '해운대구': ['좌동', '중동', '송정동'],
    '사하구': ['괴정동', '당리동'],
    '수성구': ['수성동', '범어동', '만촌동'],
    '달서구': ['월성동', '상인동'],
  };

  // 검색 버튼을 눌렀을 때 호출되는 함수
  void _searchAddress() {
    if (_selectedCity != null && _selectedDistrict != null && _selectedTown != null) {
      // 선택된 주소를 처리하는 로직을 여기에 추가할 수 있습니다.
      String fullAddress = '$_selectedCity $_selectedDistrict $_selectedTown';
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('선택한 주소'),
            content: Text(fullAddress),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    } else {
      // 주소를 모두 선택하지 않았을 때 처리
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('에러'),
            content: const Text('모든 항목을 선택해주세요.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(20.0),
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
              Row(
                children: [
                  // 광역시도 드롭다운
                  Expanded(
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
                  const SizedBox(width: 8),
                  // 시군구 드롭다운
                  Expanded(
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
                  const SizedBox(width: 8),
                  // 읍면동 드롭다운
                  Expanded(
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
                            _searchAddress(); // 동이 선택될 때 바로 함수 호출
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
