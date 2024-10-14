import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/comment_provider.dart';
import 'package:doctorviewapp/providers/detail_provider.dart';
import 'package:doctorviewapp/providers/doctor_provider.dart';
import 'package:doctorviewapp/providers/dreply_provider.dart';
import 'package:doctorviewapp/providers/dreview_provider.dart';
import 'package:doctorviewapp/providers/hashtag_provider.dart';
import 'package:doctorviewapp/providers/hospital_provider.dart';
import 'package:doctorviewapp/providers/hours_provider.dart';
import 'package:doctorviewapp/providers/hreply_provider.dart';
import 'package:doctorviewapp/providers/hreview_provider.dart';
import 'package:doctorviewapp/providers/likes_provider.dart';
import 'package:doctorviewapp/providers/member_provider.dart';
import 'package:doctorviewapp/providers/reserve_provider.dart';
import 'package:doctorviewapp/screens/chat/chat_list_screen.dart';
import 'package:doctorviewapp/screens/home/home_screen.dart';
import 'package:doctorviewapp/screens/mypage/mypage_screen.dart';
import 'package:doctorviewapp/providers/report_provider.dart';
import 'package:doctorviewapp/screens/board/board_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorviewapp/screens/hosp_doctor_list_screen.dart';
import 'widgets/common/bottom_navigation_bar.dart';
// 예약하기 캘린더 한글처리
import 'package:intl/date_symbol_data_local.dart';

void main() {

  // 캘린더 한글처리를 위한 intl 패키지 초기화포함
  initializeDateFormatting().then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DoctorProvider()),
          ChangeNotifierProvider(create: (context) => DreviewProvider()),
          ChangeNotifierProvider(create: (context) => DreplyProvider()),
          ChangeNotifierProvider(create: (context) => HospitalProvider()),
          ChangeNotifierProvider(create: (context) => HreviewProvider()),
          ChangeNotifierProvider(create: (context) => HreplyProvider()),
          ChangeNotifierProvider(create: (context) => LikesProvider()),
          ChangeNotifierProvider(create: (context) => HashtagProvider()),
          // 회원 관리
          ChangeNotifierProvider(create: (context) => MemberProvider()),
          ChangeNotifierProvider(create: (context) => HoursProvider()),
          ChangeNotifierProvider(create: (context) => DetailProvider()),
          // 게시판
          ChangeNotifierProvider(create: (context) => BoardProvider()),
          ChangeNotifierProvider(create: (context) => CommentProvider()),
          ChangeNotifierProvider(create: (context) => ReportProvider()),
          // 예약
          ChangeNotifierProvider(create: (context) => ReserveProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
  
  // 원본
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (context) => DoctorProvider()),
  //       ChangeNotifierProvider(create: (context) => DreviewProvider()),
  //       ChangeNotifierProvider(create: (context) => DreplyProvider()),
  //       ChangeNotifierProvider(create: (context) => HospitalProvider()),
  //       ChangeNotifierProvider(create: (context) => HreviewProvider()),
  //       ChangeNotifierProvider(create: (context) => HreplyProvider()),
  //       ChangeNotifierProvider(create: (context) => LikesProvider()),
  //       ChangeNotifierProvider(create: (context) => HashtagProvider()),
  //       //회원관리
  //       ChangeNotifierProvider(create: (context) => MemberProvider()),
  //       ChangeNotifierProvider(create: (context) => HoursProvider()),
  //       ChangeNotifierProvider(create: (context) => DetailProvider()),
  //       // 게시판
  //       ChangeNotifierProvider(create: (context) => BoardProvider()),
  //       ChangeNotifierProvider(create: (context) => CommentProvider()),
  //       ChangeNotifierProvider(create: (context) => ReportProvider()),
  //       //예약
  //       ChangeNotifierProvider(create: (context) => ReserveProvider()),
  //     ],
  //     child: const MyApp(),
  //   ),
  // );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: '변경하기'),
    );
  }
}

class CustomTextStyles {
  static TextStyle appbarText = TextStyle(
    color: Colors.grey[900],
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
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
        page = const HomeScreen();
        break;
      case 1:
        page = const HospDoctorListScreen();
        break;
      case 2:
        page = const ChatListScreen();
        break;
      case 3:
        page = const BoardMainScreen();
        break;
      case 4:
        page = const MyPage();
        break;
    }
    return page!;
  }
}