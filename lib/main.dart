import 'package:doctorviewapp/providers/board_provider.dart';
import 'package:doctorviewapp/providers/chat_provider.dart';
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

// apk 파일 빌드 완료
void main() {

  // 캘린더 한글처리를 위한 intl 패키지 초기화 포함
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
          // 채팅
          ChangeNotifierProvider(create: (context) => ChatProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
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
  void initState() {
    super.initState();
    //API처리
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctor(); //의사
    Provider.of<DreviewProvider>(context, listen: false).fetchDreview(); //의사라뷰
    Provider.of<DreplyProvider>(context, listen: false).fetchDreply(); //의사답글
    Provider.of<HospitalProvider>(context, listen: false).fetchHospital(); //병원
    Provider.of<HreviewProvider>(context, listen: false).fetchHreview(); //병원리뷰 
    Provider.of<HreplyProvider>(context, listen: false).fetchHreply(); //병원답글
    Provider.of<LikesProvider>(context, listen: false).fetchLike(); //좋아요
    Provider.of<HashtagProvider>(context, listen: false).fetchHashtag(); //해시태그

    Provider.of<MemberProvider>(context, listen: false).fetchMember(); //멤버
    Provider.of<HoursProvider>(context, listen: false).fetchHour(); //시간
    Provider.of<DetailProvider>(context, listen: false).fetchDetail(); //병원디테일

    Provider.of<BoardProvider>(context, listen: false).fetchBoard(); //게시판
    Provider.of<CommentProvider>(context, listen: false).fetchComment(); //댓글
    Provider.of<ReportProvider>(context, listen: false).fetchReport(); //리뷰
    Provider.of<ReserveProvider>(context, listen: false).fetchReserve(); //예약
  }
  
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