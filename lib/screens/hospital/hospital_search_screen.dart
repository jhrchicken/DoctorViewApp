import 'package:doctorviewapp/widgets/common/grey_button.dart';
import 'package:flutter/material.dart';
import 'package:doctorviewapp/theme/colors.dart';

class HospitalSearchPage extends StatefulWidget {
  const HospitalSearchPage({
    super.key
  });

  @override
  State<HospitalSearchPage> createState() => _HospitalSearchPageState();
}

class _HospitalSearchPageState extends State<HospitalSearchPage> {
  // 검색어 입력을 위한 컨트롤러
  final TextEditingController _controller = TextEditingController();
  // 주소 선택을 위한 변수
  String? _selectedCity; // 선택된 광역시도
  String? _selectedDistrict; // 선택된 시군구
  String? _selectedTown; // 선택된 읍면동
  // 광역시도 목록
  List<String> cities = ['서울', '부산', '대구', '인천', '광주', '대전', '울산'];
  // 광역시도에 따른 시군구 목록
  Map<String, List<String>> districts = {
    '서울': ['강남구', '서초구', '강북구', '종로구'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 앱 바의 배경색과 제목 설정
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            const SizedBox(width: 15),
            Flexible(
              flex: 1,
              child: TextField(
                controller: _controller, // 검색어 입력 필드
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
                  hintText: '병원명을 검색하세요', // 힌트 텍스트
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: gray400,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 최근 검색 섹션
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '최근 검색',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextButton(
                          onPressed: () {}, // 전체삭제 버튼
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            '전체삭제',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 0,
                      children: [
                        _buildRecentSearchButton('감기'), // 최근 검색어 버튼
                        _buildRecentSearchButton('접수'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        
            // 주제별 검색어 섹션
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
                    const Text(
                      '주제별 검색어',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0,
                      runSpacing: 0,
                      children: [
                        GreyButton(
                          text: '접수',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '예약',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '주차가능',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '야간진료',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '응급진료',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '전문의',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '여의사',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 추천 키워드 섹션
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
                    const Text(
                      '추천 키워드',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0,
                      runSpacing: 0,
                      children: [
                        GreyButton(
                          text: '감기',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '장염',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '골절',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '보건증',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '영유아 검진',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '공단검진',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 위치
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
                    const Text(
                      '위치',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                            hint: const Text(
                              '광역시도',
                              style: TextStyle(
                                color: gray500,
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
                                  style: const TextStyle(
                                    color: gray500,
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
                            hint: const Text(
                              '시/군/구',
                              style: TextStyle(
                                color: gray500,
                                fontSize: 12,
                              ),
                            ),
                            value: _selectedDistrict,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDistrict = newValue; // 선택된 값 업데이트
                                _selectedTown = null; // 읍면동 초기화
                              });
                            },
                            items: (_selectedCity != null && districts[_selectedCity!] != null)
                                ? districts[_selectedCity!]!.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: gray500,
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
                            hint: const Text(
                              '읍/면/동',
                              style: TextStyle(
                                color: gray500,
                                fontSize: 12,
                              ),
                            ),
                            value: _selectedTown,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedTown = newValue;
                              });
                            },
                            items: (_selectedDistrict != null && towns[_selectedDistrict!] != null)
                                ? towns[_selectedDistrict!]!.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          color: gray500,
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
            ),

            // 진료과목
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
                    const Text(
                      '진료과목',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0,
                      runSpacing: 0,
                      children: [
                        GreyButton(
                          text: '내과',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '안과',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '피부과',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '산부인과',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '정형외과',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '소아과',
                          onPressed: () {},
                        ),
                        GreyButton(
                          text: '신경과',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 최근 검색어 버튼 생성 함수
  ElevatedButton _buildRecentSearchButton(String label) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(
          color: Colors.black12,
          width: 1,
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: gray500,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.close,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}