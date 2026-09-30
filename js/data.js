const qnaList = [
  {
    q: "&quot;눈을 감고 행복했던 순간을 떠올려보세요. 어떤 장면이 떠오르나요?&quot;",
    a: [
      {
        answer: "💌소중한 사람이 준 꽃다발을 받았던 순간",
        type: [0],
      },
      {
        answer: "🍃바람에 실려온 싱그러운 풀 내음을 맡던 순간",
        type: [1],
      },
      {
        answer: "📚낙엽이 우수수 떨어지는 가을날, 따뜻한 차 한 잔을 마시던 순간",
        type: [2],
      },
      {
        answer: "🌃별이 가득한 밤, 낯선 곳에서 설레는 여행을 하던 순간",
        type: [3],
      },
    ],
  },

  {
    q: "&quot;당신의 하루를 색으로 표현한다면?&quot;",
    a: [
      {
        answer: "🎀부드럽고 따뜻한 핑크빛",
        type: [0],
      },
      {
        answer: "🍏싱그러운 연둣빛",
        type: [1],
      },
      {
        answer: "☕차분한 브라운 컬러",
        type: [2],
      },
      {
        answer: "💜신비로운 보랏빛",
        type: [3],
      },
    ],
  },
  {
    q: "&quot;새로운 곳을 여행한다면, 어떤 곳이 가장 끌리나요?&quot;",
    a: [
      {
        answer: "🏰유럽의 고풍스러운 정원",
        type: [0],
      },
      {
        answer: "🏝️한적한 해변에서 불어오는 바닷바람",
        type: [1],
      },
      {
        answer: "🌲숲속 오두막에서 맞이하는 고요한 아침",
        type: [2],
      },
      {
        answer: "🕌동양의 시장과 향신료가 가득한 거리",
        type: [3],
      },
    ],
  },

  {
    q: "&quot;당신이 가장 편안함을 느끼는 공간은?&quot;",
    a: [
      {
        answer: "🛋️포근한 소파와 은은한 꽃 향이 가득한 거실",
        type: [0],
      },
      {
        answer: "☀️창문을 열면 상쾌한 공기가 들어오는 밝은 방",
        type: [1],
      },
      {
        answer: "📖클래식 음악이 흐르는 조용한 서재",
        type: [2],
      },
      {
        answer: "🌙은은한 조명과 향초가 켜진 감각적인 공간",
        type: [3],
      },
    ],
  },

  {
    q: "&quot;당신이 꿈꾸는 이상적인 하루는?&quot;",
    a: [
      {
        answer: "💌소중한 사람과 함께하는 따뜻한 시간",
        type: [0],
      },
      {
        answer: "🌿자유롭게 산책하며 자연과 어울리는 하루",
        type: [1],
      },
      {
        answer: "📚조용한 공간에서 나만의 시간을 보내는 하루",
        type: [2],
      },
      {
        answer: "🌍새로운 곳을 탐험하며 특별한 경험을 하는 하루",
        type: [3],
      },
    ],
  },

  {
    q: "&quot;비 오는 날, 창밖을 바라보며 생각하는 것은?&quot;",
    a: [
      {
        answer: "☔따뜻한 차 한 잔과 사랑하는 사람",
        type: [0],
      },
      {
        answer: "🌦️빗소리를 배경으로 듣는 감미로운 음악",
        type: [1],
      },
      {
        answer: "📖따뜻한 모닥불 앞에서 조용한 독서 시간",
        type: [2],
      },
      {
        answer: "✈️떠나고 싶은 새로운 여행지",
        type: [3],
      },
    ],
  },

  {
    q: "&quot;당신에게 향수란 어떤 의미인가요?&quot;",
    a: [
      {
        answer: "💖마음을 따뜻하게 해주는 감정의 조각",
        type: [0],
      },
      {
        answer: "🌻하루를 상쾌하게 여는 작은 기쁨",
        type: [1],
      },
      {
        answer: "🍂나만의 공간을 지켜주는 편안한 존재",
        type: [2],
      },
      {
        answer: "🔮나를 표현하는 가장 특별한 언어",
        type: [3],
      },
    ],
  },

  {
    q: "&quot;당신에게 향수란 어떤 의미인가요?&quot;",
    a: [
      {
        answer: "마음을 따뜻하게 해주는 감정의 조각",
        type: [0],
      },
      {
        answer: "하루를 상쾌하게 여는 작은 기쁨",
        type: [1],
      },
      {
        answer: "나만의 공간을 지켜주는 편안한 존재",
        type: [2],
      },
      {
        answer: "나를 표현하는 가장 특별한 언어",
        type: [3],
      },
    ],
  },
  
];

const infoList = [
  {
    nameid:"<span style='color: #FF69B4;'>따스러운 봄 햇살</span> 같은 당신은,",
    name: "&quot;스프링 플로럴&quot; (Spring Floral)",
    desc: "&quot;따뜻한 햇살 아래, 잔잔한 바람이 머릿결을 스치고...<br> 그 순간, 당신은 사랑이라는 이름의 향기로 물들어갑니다.&quot;<br> 당신은 사람들의  마음을 사로잡는 부드러운 매력을 가진 사람이에요. <br>말하지 않아도 미소만으로도 따뜻한 감정을 전할 수 있는 존재죠.",
    recommend: "<button onclick='goToRecommendation(\"Spring\")'>추천 향수 보기</button>"
  },
  {
    nameid:"<span style='color: #969DFF;'>청량하고 시원한 바람</span>같은 당신은,",
    name: "&quot;썸머 플로럴&quot; (Summer Floral)",
    desc: "&quot;고요한 숲속, 나뭇잎 사이로 스며드는 따뜻한 햇볕.<br> 당신은 차분함 속에서 빛나는 깊이를 가진 사람입니다.&quot; <br>  조용하지만 단단한 내면의 힘을 지닌 당신.<br> 따뜻한 마음으로 사람들에게 편안함과 안정감을 주는 존재예요.",
     recommend: "<button onclick='goToRecommendation(\"Summer\")'>추천 향수 보기</button>"
  },
  {
    nameid:"<span style='color: #CA7E15;'>노을진 하늘 아래 놓인</span>같은 당신은,",
    name: "&quot;어텀 플로럴&quot; (Autumn Floral)",
    desc: "&quot;맑은 아침 공기, 햇살 아래 반짝이는 이슬방울.<br>당신은 그 자체로 상쾌한 발마과 같은 사람입니다.&quot;<br> 항상 밝고 긍정적인 에너지를 뿜어내며, 주변 사람들에게 신선한 기운을 선사하는 당신.<br> 자유롭고 자연스러운 분위기가 매력 포인트예요.",
    recommend: "<button onclick='goToRecommendation(\"Autumn\")'>추천 향수 보기</button>"
  }, 
  {
    nameid:"<span style='color: #5656C6;'>눈 결정같이 아름다운</span>같은 당신은,",
    name: "&quot;윈터 플로럴&quot; (Winter Floral)",
    desc: "&quot; 어둠 속에서도 반짝이는 별처럼, 당신은<br> 신비로움과 독특한 매력으로 빛나는 사람입니다.&quot;<br> 당신은 누구에게나 쉽게 드러나지 않는 매력을 가진, <br>미스터리한 분위기의 소유자. 깊은 여운을 남기는 향기가 잘 어울려요.",
    recommend: "<button onclick='goToRecommendation(\"Winter\")'>추천 향수 보기</button>"
  },        
 
];
function goToRecommendation(season) {
  alert(season + " 타입에 맞는 향수 추천 페이지로 이동합니다!");

  // 팝업을 새 창으로 열기
  const popup = window.open(`./${season}_Product.jsp`, '_top');

 
}


