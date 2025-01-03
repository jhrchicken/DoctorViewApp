<a id="readme-top"></a>

<!-- 프로젝트 로고 -->
<br />
<div align="center">
  <img src="assets/images/logo.png" width="160" height="70">
  <h3 align="center">지역 기반 의료 서비스 매칭 플랫폼</h3>
  <p align="center">
    지금 바로 닥터뷰를 시작해보세요!
    <br />
    <a href=""><strong>모바일 앱 설치하기 »</strong></a>
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
    <li><a href="#4">주요 기능</a></li>
    <li>
      <a href="#5">아키텍처</a>
      <ul>
        <li><a href="#5-1">아키텍처</a></li>
        <li><a href="#5-2">프로젝트 구조</a></li>
      </ul>
    </li>
        <li>
      <a href="#6">기타</a>
      <ul>
        <li><a href="#6-1">개발 문서</a></li>
        <li><a href="#6-2">이슈 및 문제해결</a></li>
        <li><a href="#6-3">개선 사항</a></li>
        <li><a href="#6-4">프로젝트에서 배운 점</a></li>
        <li><a href="#6-5">결과 및 확장성</a></li>
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

<b>이제 </b><a href="">여기를 클릭하여</a><b> 지역 기반 의료 시스템 매칭 플랫폼 닥터뷰를 시작해보세요!</b>

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

### 정하림 ([@jhrchicken](https://github.com/jhrchicken))

<ul>
  <li>
    <b>프로젝트 설계</b>
    <ul>
      <li>데이터베이스 설계, 프로젝트 구조 설계</li>
      <li>요구사항 정의서 작성, 앱 기능 정의서 작성, 데이터베이스 정의서 작성, 개발 일정 작성</li>
    </ul>
  </li>
  <li>
    <b>UI 구현</b>
    <ul>
      <li>홈, 네비게이션 바 등 모든 <b>메인 관련 페이지</b></li>
      <li>게시판 목록, 게시판 작성, 게시판 수정, 게시판 상세 등 모든 <b>게시판 관련 페이지</b></li>
      <li>이모지 상점, 나의 이모지 등 모든 <b>이모지 관련 페이지</b></li>
      <li>예약 내역 등 일부 <b>마이페이지 관련 페이지</b></li>
    </ul>
  </li>
  <li>
    <b>기능 개발</b>
    <ul>
      <li>병원과 의사 키워드 검색, 병원 조건 필터링 검색, 병원 지도로 찾기, 병원 필터링 후 지도에 표시, 병원과 의사의 기본정보와 추가정보 표시, 병원과 의사 찜, 별점과 해시태그를 통한 리뷰 작성, 수정, 삭제, 리뷰에 대한 답변 작성, 수정, 삭제, 리뷰 수정 여부 표시 등 <b>병원과 의사 검색 및 상세정보 기능</b></li>
      <li>React와 Firebase 연동, 채팅 이력과 이전 대화 조회, 다중 채팅방 지원, 채팅 날짜 시간 표시 등 모든 <b>실시간 채팅 기능</b></li>
      <li>게시글 작성, 게시글 수정, 게시글 삭제, 댓글 작성, 댓글 수정, 댓글 삭제, 게시글 좋아요 및 신고, 게시판 활동 내역 확인 등 모든 <b>게시판 기능</b></li>
      <li>카테고리 별 세부적인 기능은 배포된 홈페이지와 하단의 <a href="#5">주요기능</a>에서 확인할 수 있습니다.</li>
    </ul>
  </li>
</ul>

#### 다른 팀원에 대한 자세한 정보는 부다영([@budayeong](https://github.com/Budayeong))과 이회리([@leeeeeeeeeeeehr](https://github.com/leeeeeeeeeeeehr))에서 확인하세요.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="2">02. 설치 가이드</span>

### 



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
|**데이터베이스**|<img src="https://img.shields.io/badge/Firebase%20realtime%2010.13.2-%23EB844E?style=for-the-badge&logo=firebase"> ++ 그리고 나머지는 API로 가져와서 씀 (오라클 적어야 하나)|
|**개발 환경 및 도구**|<img src="https://img.shields.io/badge/visual%20studio%20code-%230082FC?style=for-the-badge">|
|**라이브러리 및 API**|<img src="https://img.shields.io/badge/googlemap-%234285F4?style=for-the-badge&logo=googlemaps&logoColor=%23fff"> ++ 프로바이더 같은것도 다 적어야 하나|
|**협업**|<img src="https://img.shields.io/badge/github-%23181717?style=for-the-badge&logo=github"> <img src="https://img.shields.io/badge/figma-%23F24E1E?style=for-the-badge&logo=figma&logoColor=%23fff"> <img src="https://img.shields.io/badge/notion-%23000000?style=for-the-badge&logo=notion"> <img src="https://img.shields.io/badge/google%20drive-%234285F4?style=for-the-badge&logo=googledrive&logoColor=%23fff">|



<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="4">04. 주요 기능</span>

### 로그인 및 회원가입
<ul>
  <li></li>
</ul>

<br/>

### 병원 검색 및 상세정보 확인

#### 병원 찾기
<ul>
  <li>지역, 병원명, 전공, 해시태그로 키워드 검색</li>
  <li>AJAX를 이용한 비동기식 조건 필터링 검색</li>
</ul>

#### 의사 찾기
<ul>
  <li>진료 과목, 의사명으로 키워드 검색</li>
</ul>

#### 지도로 찾기
<ul>
  <li>KakaoMap으로 병원 위치를 지도에 표시</li>
  <li>야간진료, 주말진료, 진료중 병원 필터링 후 지도에 표시</li>
  <li>지도 확대/축소 및 교통정보 확인</li>
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
  <li></li>
</ul>

#### 병원 사용자의 예약 기능
<ul>
  <li></li>
</ul>

<br/>

### 채팅

<ul>
  <li>React와 Firebase를 이용한 일반 사용자와 병원 사용자 간의 실시간 채팅 기능</li>
  <li>대화 내용을 Firebase Realtime Database에 저장하여 채팅 이력과 이전 대화 조회</li>
  <li>다중 채팅방을 지원하여 여러 대화방에서 동시에 채팅 가능</li>
  <li>날짜와 시간을 적절히 표시하여 사용자 편의 제공</li>

  <li>일반 사용자와 병원 사용자 간의 실시간 채팅 기능</li>
  <li>대화 내용을 Firebase Realtime Database에 저장하여 채팅 이력과 이전 대화 조회</li>
  <li></li>
</ul>

<br/>

### 게시판

<ul>
  <li>게시글 작성, 수정, 삭제</li>
  <li>새로고침 없이 AJAX로 댓글 작성, 수정, 삭제</li>
  <li>AJAX를 이용한 비동기 방식으로 게시글 좋아요 및 신고 기능</li>
  <li>내가 작성한 글, 좋아요한 글 등 게시판 활동 내역 확인</li>
  <li>비방, 욕설 등이 포함된 부적절한 게시글은 관리자에 의해 삭제</li>
</ul>

<br/>

### 이모지

<ul>
  <li>출석체크를 통해 얻은 포인트를 시용해 이모지 구매</li>
  <li>보유 이모지 목록 확인 후 이모지 변경 및 해제 가능</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="5">05. 아키텍처</span>

## <span id="5-1">아키텍쳐</span>

프로바이더 패턴

<div align="right">
  
[(back to top)](#readme-top)

</div>

## <span id="5-2">프로젝트 구조</span>

<b>닥터뷰 프로젝트는 프로바이더 패턴 어쩌구</b>

Provider 패턴을 도입한 이유는 다음과 같습니다.

1. ㅇ
2
3

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="6">06. 기타</span>

## <span id="6-1">개발 문서</span>

<ul>
  <li><a href="https://docs.google.com/spreadsheets/d/1-RER7R7QFNXRE4CgOUqKGith9Wt0Z91SCN1672EbLW0/edit?usp=drive_link">요구사항 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/11gptX480E9YtpxeUekT7gV6VwarE1xvttBCouKdbzro/edit?usp=drive_link">앱 기능 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/1hxAeG9cIlK2gOKKzilhP28s8gkanK2O-k3BdpuAEieQ/edit?usp=drive_link">데이터베이스 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/1zC_YDl9BHkNTQ4XoS8nbUvrYFBoN5bXuEljF49YOYT0/edit?usp=drive_link">개발 일정</a></li>
  <li>피그마 디자인</li>
</ul>

<div align="right">
  
  [(back to top)](#readme-top)

</div>

<br/>
## <span id="6-2">이슈 및 문제해결</span>

#### 1. 내용 입력

내용 입력

<br/>

#### 2.--

--

<div align="right">
  
  [(back to top)](#readme-top)

</div>

<br/>

## <span id="6-3">개선 사항</span>

여기에 그 뭐냐 api 연동 그거만 적으면 될듯 restfulAPi

<div align="right">

[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-4">프로젝트에서 배운 점</span>

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

## <span id="6-5">결과 및 확장성</span>

<b>닥터뷰 프로젝트는 기업초청 발표에서 다음과 같은 총괄 평가를 받았습니다.</b>

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

