<a id="readme-top"></a>

<!-- 프로젝트 로고 -->
<br />
<div align="center">
  <img src="assets/images/logo.png" width="160" height="70">
  <h3 align="center">지역 기반 의료 서비스 매칭 플랫폼</h3>
  <p align="center">
    지금 바로 닥터뷰를 시작해보세요!
    <br />
    <a href="https://github.com/jhrchicken/DoctorViewApp/raw/main/app-release.apk"><strong>모바일 앱 설치하기 »</strong></a>
  </p>
</div>

<!-- 목차 -->
<details>
  <summary>목차</summary>
  <ol>
    <li>
      <a href="#1">프로젝트 정보</a>
      <ul>
        <li><a href="#1-1">프로젝트 개요</a></li>
        <li><a href="#1-2">소속 단체 및 개발 기간</a></li>
        <li><a href="#1-3">팀원 구성 및 역할</a></li>
      </ul>
    </li>
    <li><a href="#2">사용 가이드</a></li>
    <li><a href="#3">기술 스택</a></li>
    <li><a href="#4">화면 구성</a></li>
    <li><a href="#5">주요 기능</a></li>
    <li>
      <a href="#6">아키텍처</a>
      <ul>
        <li><a href="#6-1">아키텍처</a></li>
        <li><a href="#6-2">프로젝트 구조</a></li>
      </ul>
    </li>
        <li>
      <a href="#7">기타</a>
      <ul>
        <li><a href="#7-1">개발 문서</a></li>
        <li><a href="#7-2">이슈 및 문제해결</a></li>
        <li><a href="#7-3">개선 사항</a></li>
        <li><a href="#7-4">프로젝트에서 배운 점</a></li>
        <li><a href="#7-5">결과 및 확장성</a></li>
      </ul>
    </li>
  </ol>
</details>

<br/>

# <span id="1">01. 프로젝트 정보</span>

## <span id="1-1">프로젝트 개요</span>

<b>닥터뷰는 지역 기반 의료 서비스 매칭 플랫폼입니다.</b>

닥터뷰는 병원 정보의 부족, 만족스러운 의료진 선택의 어려움, 긴급 상황에서 병원 찾기의 불편함, 번거로운 예약 과정 등 환자들이 겪는 문제를 해결하고자 하는 의도에서부터 출발하였습니다. 닥터뷰는 다양한 검색 방식과 조건을 통해 개인에게 적합한 병원을 찾고 예약할 수 있는 서비스를 제공합니다. 병원 방문 전후에는 채팅 기능을 통해 병원과 소통할 수 있으며, 게시판을 통해 건강 정보를 공유하는 커뮤니티를 형성하여 기존의 의료 시스템에 새로운 알고리즘을 도입합니다.

<b>닥터뷰는 웹과 모바일 앱을 모두 지원합니다.</b> <a href="https://github.com/jhrchicken/DoctorViewWeb">닥터뷰 웹에 대한 내용은 여기에서 확인하세요.</a>

이 모바일 앱은 다음과 같은 기능들을 제공합니다.

1. 다양한 검색 방식으로 검색 조건에 일치하는 병원과 의료진의 정보을 찾아 예약하고 리뷰를 남길 수 있습니다.
2. 환자들이 병원 방문 전후에 의료진과 간편하게 소통할 수 있도록 채팅 기능을 제공합니다.
3. 게시판을 통해 건강 정보를 공유하고 커뮤니티 내에서 자유롭게 상호작용할 수 있습니다.

<b>이제 지역 기반 의료 시스템 매칭 플랫폼 닥터뷰를 시작해보세요!</b>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="1-2">소속 단체 및 개발 기간</span>

<ul>
  <li>더조은아카데미 클라우드(AWS) 환경에서 개발하는 풀스택(프론트엔드&백엔드) 자바(JAVA)웹&앱 4기</li>
  <li>프로젝트 개발 기간: 2024.10.03 - 2024.10.13</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="1-3">팀원 구성 및 역할</span>

닥터뷰 프로젝트는 <b>모바일 앱 개발자 3명</b>으로 구성된 팀이 개발하였습니다.

|정하림|부다영|이회리|
|:---:|:---:|:---:|
|<img src="assets/images/jhrchicken.jpeg" width="120" height="120">|<img src="assets/images/budayeong.jpeg" width="120" height="120">|<img src="assets/images/leehr.jpeg" width="120" height="120">|
|앱 개발 및 팀장|앱 개발|앱 개발|

#### 닥터뷰 프로젝트에서 정하림([@jhrchicken](https://github.com/jhrchicken))의 주요 역할은 다음과 같습니다.

<ul>
  <li>
    <b>프로젝트 설계</b>
    <ul>
      <li>데이터베이스 설계, 프로젝트 구조 설계</li>
      <li>요구사항 정의서 작성, 앱 기능 정의서 작성, 데이터베이스 정의서 작성, 개발 일정 작성 등 일부 <b>개발 문서 작성</b></li>
    </ul>
  </li>
  <br/>
  <li>
    <b>UI 구현</b>
    <ul>
      <li>홈, 네비게이션 바 등 모든 <b>메인 관련 페이지</b></li>
      <li>병원 목록, 병원 상세보기, 병원 리뷰 목록, 병원 리뷰 작성, 병원 리뷰 수정 등 모든 <b>병원 관련 페이지</b></li>
      <li>의사 목록, 의사 상세보기, 의사 리뷰 목록, 의사 리뷰 작성, 의사 리뷰 수정 등 모든 <b>의사 관련 페이지</b></li>
      <li>게시판 목록, 게시판 작성, 게시판 수정, 게시판 상세 등 모든 <b>게시판 관련 페이지</b></li>
      <li>채팅 목록, 채팅방 등 모든 <b>게시판 관련 페이지</b></li>
      <li>작성한 리뷰 등 일부 <b>마이페이지 관련 페이지</b></li>
    </ul>
  </li>
  <br/>
  <li>
    <b>기능 개발</b>
    <ul>
      <li>병원 키워드로 검색, 병원 목록 표시, 병원 진료중 여부 표시 등 모든 <b>병원 찾기 기능</b></li>
      <li>병원 기본정보와 추가정보 표시, 병원에 소속된 의료진 정보 표시, 병원 찜 등 모든 <b>병원 상세정보 확인 기능</b></li>
      <li>의사 키워드로 검색, 의사 기본정보와 추가정보 표시, 의사 찜 등 모든 <b>의사 찾기 및 상세정보 확인 기능</b></li>
      <li>별점과 해시태그를 통한 리뷰 작성과 수정과 삭제, 리뷰 답변 작성과 수정과 삭제, 리뷰 수정 여부 표시 등 모든 <b>리뷰 기능</b></li>
      <li>Firebase 연동, 채팅 목록, 채팅방, 읽음 여부 표시, 안읽은 메세지 개수 표시, 채팅 날짜와 시간 표시 등 모든 <b>채팅 기능</b></li>
      <li>게시글 작성과 수정과 삭제, 댓글 작성과 수정과 삭제, 게시글 좋아요 및 신고, 게시판 활동 내역 확인 등 모든 <b>게시판 기능</b></li>
    </ul>
  </li>
</ul>

#### 다른 팀원에 대한 자세한 정보는 부다영([@budayeong](https://github.com/Budayeong))과 이회리([@leeeeeeeeeeeehr](https://github.com/leeeeeeeeeeeehr))에서 확인하세요.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="2">02. 사용 가이드</span>

### 앱 다운로드 및 설치

닥터뷰 앱 설치를 위해 다음 단계를 따릅니다.

<ol>
  <li>다음 링크를 클릭하여 <b>APK 파일을 다운로드</b> 합니다. (<a href="https://github.com/jhrchicken/DoctorViewApp/raw/main/app-release.apk">닥터뷰 APK 다운로드</a>)</li>
  <li>안드로이드 기기에서는 보안을 위해 기본적으로 외부 출처의 앱 설치가 차단되어 있습니다. <b>설정에서 알 수 없는 출처를 활성화</b>하세요.</li>
  <li>안드로이드에서 다운로드한 <b>APK 파일을 실행하여 설치를 시작</b>합니다.</li>
</ol>

최신 안드로이드 버전에서는 설치 경로 또는 보안 설정이 조금 다를 수 있습니다. 문제가 발생하면 APK 다운로드 경로 및 기기 설정을 다시 확인하세요.

<br/>

### Test ID/PW

<ul>
  <li>일반 사용자: harim1104 / 12341234</li>
  <li>병원 사용자: hospital1 / 12341234</li>
  <li>관리자: admin / 12341234</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="3">03. 기술 스택</span>

|분류|기술 스택|
|:---:|---|
|**언어**|<img src="https://img.shields.io/badge/dart-%230175C2?style=for-the-badge&logo=dart">|
|**프레임워크**|<img src="https://img.shields.io/badge/flutter-%2302569B?style=for-the-badge&logo=flutter"> <img src="https://img.shields.io/badge/android%20studio-%233DDC84?style=for-the-badge&logo=android&logoColor=%23fff">|
|**데이터베이스**|<img src="https://img.shields.io/badge/Firebase%20realtime%2010.13.2-%23EB844E?style=for-the-badge&logo=firebase">|
|**개발 환경 및 도구**|<img src="https://img.shields.io/badge/visual%20studio%20code-%230082FC?style=for-the-badge">|
|**라이브러리 및 API**|<img src="https://img.shields.io/badge/googlemap-%234285F4?style=for-the-badge&logo=googlemaps&logoColor=%23fff"> <img src="https://img.shields.io/badge/Provider-%23FFB441?style=for-the-badge"> <img src="https://img.shields.io/badge/REST%20API-%236BA539?style=for-the-badge">|
|**협업**|<img src="https://img.shields.io/badge/github-%23181717?style=for-the-badge&logo=github"> <img src="https://img.shields.io/badge/figma-%23F24E1E?style=for-the-badge&logo=figma&logoColor=%23fff"> <img src="https://img.shields.io/badge/notion-%23000000?style=for-the-badge&logo=notion"> <img src="https://img.shields.io/badge/google%20drive-%234285F4?style=for-the-badge&logo=googledrive&logoColor=%23fff">|



<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="4">04. 화면 구성</span>

<img src="/assets/images/ppt1.png">
<img src="/assets/images/ppt2.png">
<img src="/assets/images/ppt3.png">
<img src="/assets/images/ppt4.png">
<img src="/assets/images/ppt5.png">

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="5">05. 주요 기능</span>

### 로그인 및 회원가입
<ul>
  <li>사용자 입력 정보를 조건과 실시간 비교 후 안내</li>
  <li>회원가입 시 닉네임 랜덤 추천 기능</li>
</ul>

<br/>

### 병원 검색 및 상세정보 확인

#### 병원 찾기
<ul>
  <li>지역, 병원명, 해시태그로 키워드 검색</li>
  <li>GoogleMap으로 병원 위치를 지도에 표시</li>
  <li>현재 진료중 여부 표시 및 진료 중이 아닌 경우 다음 진료 시간 표시</li>
</ul>

#### 병원 상세정보 확인
<ul>
  <li>진료 시간, 진료 과목, 주소, 소속된 의료진 등 병원 기본 정보 표시</li>
  <li>교통편, 주차 가능 여부, 해시태그 등 병원 추가 정보 표시</li>
  <li>병원 찜 기능</li>
  <li>별점과 해시태그를 추가하여 리뷰 작성, 수정, 삭제</li>
  <li>일반 사용자가 작성한 리뷰에 병원 사용자의 답변 작성, 수정, 삭제</li>
  <li>수정된 리뷰와 답변에 수정 여부 표시</li>
</ul>

#### 의사 찾기
<ul>
  <li>의사명으로 키워드 검색</li>
</ul>

#### 의사 상세정보 확인
<ul>
  <li>진료 시간, 진료 과목, 소속 병원 등 병원 기본 정보 제공</li>
  <li>의사 찜 기능</li>
  <li>별점과 해시태그를 추가하여 리뷰 작성, 수정, 삭제</li>
  <li>일반 사용자가 작성한 리뷰에 병원 사용자의 답변 작성, 수정, 삭제</li>
  <li>수정된 리뷰와 답변에 수정 여부 표시</li>
</ul>

<br/>

### 예약

#### 일반 사용자의 예약 기능
<ul>
  <li>병원의 진료 시간, 예약 가능한 시간에 맞춰 온라인 예약 가능</li>
</ul>

#### 병원 사용자의 예약 기능
<ul>
  <li>회원가입 시 설정한 진료 시간 외 날짜별 예약시간 관리 가능</li>
</ul>

<br/>

### 채팅

<ul>
  <li>일반 사용자와 병원 사용자 간의 실시간 채팅 기능</li>
  <li>대화 내용을 Firebase Realtime Database에 저장하여 채팅 이력과 이전 대화를 조회</li>
  <li>채팅 목록에서 읽지 않은 메시지 개수를 표시</li>
  <li>채팅방에서 메시지 읽음 여부 표시</li>
  <li>날짜와 시간을 적절히 표시하여 사용자의 편의 제공</li>
  <li>채팅방을 삭제 후 나가는 기능 제공</li>
</ul>

<br/>

### 게시판

<ul>
  <li>게시글 작성, 수정, 삭제</li>
  <li>댓글 작성, 수정, 삭제</li>
  <li>게시글 좋아요 및 싫어요 표시</li>
  <li>내가 작성한 글, 좋아요한 글 등 게시판 활동 내역 확인</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="6">06. 아키텍처</span>

## <span id="6-1">아키텍쳐</span>

<b>닥터뷰 프로젝트는 프로바이더 패턴을 도입하여 효율적인 상태 관리와 데이터 공유를 구현하였습니다.</b>

프로바이더 패턴을 이용한 이유는 다음과 같습니다.

<ol>
  <li>관심사의 분리로 각 클래스가 명확한 역할만 수행하도록 설계</li>
  <li>데이터 공유의 용이성으로 여러 페이지에서 상태를 손쉽게 관리</li>
</ol>

이를 통해 프로젝트를 API, 모델, 프로바이더, 화면 등 역할별로 폴더를 구분하여 효율적으로 관리하였습니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-2">프로젝트 구조</span>

```
DoctorViewApp
├── README.md
├── analysis_options.yaml
├── android
├── assets
│   ├── fonts
│   └── images
├── build
├── devtools_options.yaml
├── doctorviewapp.iml
├── ios
├── lib
│   ├── api
│   ├── body.dart
│   ├── component
│   ├── header.dart
│   ├── main.dart
│   ├── models
│   │   ├── board.dart
│   │   ├── ...
│   │   └── reserve.dart
│   ├── providers
│   │   ├── board_provider.dart 
│   │   ├── ...
│   │   └── reserve_provider.dart
│   ├── screens
│   │   ├── board
│   │   ├── ...
│   │   └── reserve
│   ├── theme
│   └── widgets
│       ├── board
│       ├── ...
│       └── reserve
├── linux
├── macos
├── pubspec.lock
├── pubspec.yaml
├── test
├── web
└── windows
```

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="7">07. 기타</span>

## <span id="7-1">개발 문서</span>

#### 정의서

<ul>
  <li><a href="https://docs.google.com/spreadsheets/d/1-RER7R7QFNXRE4CgOUqKGith9Wt0Z91SCN1672EbLW0/edit?usp=drive_link">요구사항 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/11gptX480E9YtpxeUekT7gV6VwarE1xvttBCouKdbzro/edit?usp=drive_link">앱 기능 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/1hxAeG9cIlK2gOKKzilhP28s8gkanK2O-k3BdpuAEieQ/edit?usp=drive_link">데이터베이스 정의서</a></li>
</ul>

#### 디자인

<ul>
  <li><a href="https://www.figma.com/design/6Mbm1w0WRrV5zf4wMPoPpK/app%ED%99%94%EB%A9%B4%ED%9D%90%EB%A6%84%EB%8F%84?node-id=61-2&t=FEw0lzIR5S5qkX9Y-1">피그마 디자인</a></li>
</ul>

#### 기타

<ul>
  <li><a href="https://docs.google.com/spreadsheets/d/1zC_YDl9BHkNTQ4XoS8nbUvrYFBoN5bXuEljF49YOYT0/edit?usp=drive_link">개발 일정</a></li>
</ul>

<div align="right">
  
  [(back to top)](#readme-top)

</div>

<br/>

## <span id="7-2">이슈 및 문제해결</span>

#### 1. 이슈1

이슈 및 해결방법 1

<br/>

#### 2. 이슈2

이슈 및 해결방법 2

<div align="right">
  
  [(back to top)](#readme-top)

</div>

<br/>

## <span id="7-3">개선 사항</span>

<ul>
  <li>
    <b>플러터와 REST API 연동 구조 개선</b>
    <ul>
      <li>현재 플러터와 API를 연동하는 부분에서 조회 메서드만 구현되어 있음</li>
      <li>REST API의 표준 HTTP 메서드(POST, GET, PUT, DELETE)를 사용하여 CRUD 기능을 모두 구현 필요</li>
    </ul>
  </li>
</ul>

<div align="right">

[(back to top)](#readme-top)

</div>

<br/>

## <span id="7-4">프로젝트에서 배운 점</span>

#### 1. 여정 자체가 보상이다

프로젝트를 시작할 때는 제 부족함과 실력에 대한 막연한 두려움이 있었습니다. 하지만 프로젝트를 진행하면서, 배우려는 자세와 의지만 있다면 결과에 상관없이 저를 더 단단하게 만들어주는 실력과 경험을 얻을 수 있다는 것을 깨달았습니다. 앞으로 백엔드 개발자로 나아가면서 제가 모르는 기술들은 끝없이 쏟아져 나올 것입니다. 그 사실이 두렵고 때로는 자신감을 잃기도 하겠지만 그럼에도 불구하고 차근차근 공부하다 보면 꾸준히 성장하게 될 것입니다. 결국 이 여정 자체가 저에게 가장 큰 보상이 될 것이라고 믿습니다.

<br/>

#### 2. 팀 프로젝트에서 의사소통의 중요성과 문서화의 역할

팀 프로젝트를 진행하며 팀원 간의 의사소통이 개발 결과에 큰 영향을 미친다는 점을 깨달았습니다. 프로젝트에 대해 같이 논의하더라도, 각 팀원이 상상하는 이미지와 방향이 다른 경우가 있었습니다.
이렇게 각자의 이해가 다른 채 개발이 진행되어 수정과정을 거치는 경험을 하게 되었습니다.
이러한 경험을 통해 팀원 모두가 동일한 이해를 바탕으로 각자의 역할을 수행할 수 있도록 개선한 요소가 문서화였습니다.
문서화를 통해 기능을 명확히 정의하고 프로토타입을 제작해 시각적인 내용 역시 확정하여 개발 방향을 확실히 하였습니다.
의견이 정리된 이후에는 개발에 집중할 수 있었고, 그 결과 시간 내에 개발을 마칠 수 있었습니다.
이 경험을 통해 효율적이고 정확한 개발을 위해 문서화를 통한 명확한 의사소통의 중요성을 깊이 느낄 수 있었습니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="7-5">결과 및 확장성</span>

<b>닥터뷰 프로젝트는 기업초청 발표에서 다음과 같은 총괄 평가를 받았습니다.</b>

|심사항목|심사 세부내용|평가점수|
|:---:|:---:|--:|
|협동심|팀원 간의 협동|17 / 20|
|창의성|창의성과 기획력|16.5 / 20|
|실용성|명확한 목표 및 비전과 실용성|17.5 / 20|
|개발능력|개발 프로그래밍 능력|17.5 / 20|
|발표|발표력|9 / 10|
|가산점|기타 추가 가산점|5.5 / 10|
|-|-|82|

<ol>
  <li>짧은 시간 내에 많은 기능을 굉장히 안정적으로 구현하였음</li>
  <li>최근 의료 서비스 이슈에 따라 서비스를 제공하는 기획 의도가 좋았음</li>
  <li>실제 서비스가 가능한 수준으로 보이며, 런칭 후 사용자 피드백을 받아 개선하는 단계로 나아가기를 기대함</li>
</ol>

이러한 평가를 통해 닥터뷰 프로젝트는 안정적인 기능과 사용자 맞춤형 서비스를 제공하고 사용자 피드백을 반영해 개선할 가능성을 갖추게 되었습니다.

<b>이를 바탕으로 닥터뷰 프로젝트는 다음과 같이 확장할 수 있습니다.</b>

<ol>
  <li>의료 사각지대 지역의 의료 서비스 데이터를 집중적으로 분석하여 지역별 의료 서비스의 격차를 줄이고 질 높은 서비스를 제공</li>
  <li>커뮤니티 기능을 강화하여 의료 목적을 넘어 소모임 혹은 정보 공유 커뮤니티로 확장함으로써 사용자들이 웹에 오랜 시간 머무를 수 있도록 유도</li>
</ol>

닥터뷰 프로젝트는 지속적으로 사용자 피드백을 반영하여 서비스의 안정성과 편의성을 강화할 계획입니다. 이를 바탕으로 향후 더 많은 지역과 다양한 의료 분야로 서비스를 확장하여 많은 사용자에게 유용한 서비스를 제공할 것입니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>

