import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/screens/mypage/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorviewapp/screens/hosp_doctor_list_screen.dart';
import 'widgets/common/bottom_navigation_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DoctorProvider()),
        ChangeNotifierProvider(create: (context) => DreviewProvider()),
        ChangeNotifierProvider(create: (context) => DreplyProvider()),
        ChangeNotifierProvider(create: (context) => HospitalProvider()),
        ChangeNotifierProvider(create: (context) => HreviewProvider()),
        ChangeNotifierProvider(create: (context) => LikesProvider()),
        ChangeNotifierProvider(create: (context) => HashtagProvider()),
        //회원관리
        ChangeNotifierProvider(create: (context) => MemberProvider()),
        ChangeNotifierProvider(create: (context) => HoursProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: '변경하기'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 네비게이션에서 사용할 인덱스
  int _curIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // 페이지 위젯을 반환하는 메서드 호출
        child: navigatePage(),
      ),
      // 탭바 위젯
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _curIndex,
        onTap: (index) {
          setState(() {
            _curIndex = index;
          });
        },
      ),
    );
  }

  Widget navigatePage() {
    Widget? page;
    switch(_curIndex) {
      case 0:
        page = dummyPage();
        break;
      case 1:
        page = const HospDoctorListScreen();
        break;
      case 2:
        page = dummyPage();
        break;
      case 3:
        page = dummyPage();
        break;
      case 4:
        page = const MyPage();
        break;
    }
    return page!;
  }

  // 각 페이지를 반환하는 메서드 (추후 삭제) 깃 연동 테스트 !!!!!!!!!
  Widget dummyPage() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              color: Colors.red,
              size: 50.0,
            ),
            Text(
              'Page Index : 0',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}