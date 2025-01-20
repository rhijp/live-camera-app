import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'prefecture_list_page.dart'; // 都道府県ページをインポート

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ライブマップ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(), // MainScreenをアプリのホーム画面に設定
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // 現在の画面のインデックス

  // 表示する画面のリスト
  final List<Widget> _pages = [
    const LiveCameraPage(), // ホーム画面
    const PrefectureListPage(), // 都道府県一覧画面
  ];

  // メニューバーで選択されたときの処理
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // 現在の画面を表示
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '都道府県',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // ボタンを押したときの処理
      ),
    );
  }
}

// LiveCameraPage（ホーム画面）
class LiveCameraPage extends StatefulWidget {
  const LiveCameraPage({Key? key}) : super(key: key);

  @override
  State<LiveCameraPage> createState() => LiveCameraPageState();
}

class LiveCameraPageState extends State<LiveCameraPage> {
  final List<Map<String, String>> cameraData = [
     {"title": "「LIVE CAMERA」草津温泉・温泉門 - YouTube", "category": "観光", "youtubeId": "d6a0sL8lYGkQ"},
    {"title": "「LIVECAMERA 」西の河原露天風呂入り口 - YouTube", "category": "観光", "youtubeId": "RJYYbPs8hjQ"},
    {"title": "「LIVE CAMERA」草津温泉スキー場　天狗山山頂エリア - YouTube", "category": "観光", "youtubeId": "JDLSr4iqjIg"},
    {"title": "🔴【生中継】京都タワー Kyoto Japan Live Camera 🌙京都ライブカメラ 🏢🗼🕯🎑　森信三郎商舗より生中継 🌕 即時影像 LiveCam　天気 京都観光 天体 - YouTube", "category": "観光", "youtubeId": "IQKJPxjnjUw"},
    {"title": "🔴🎥【LIVE】京都ライブカメラ 東本願寺 (KYOTO JAPAN LIVE CAMERA) 森信三郎商舗から生中継 即時影像 livecam　#nhk紅白歌合戦 #Ado #聖地 - YouTube", "category": "観光", "youtubeId": "aT3saBHTTyE"},
    {"title": "浅草寺の境内（本堂側）Precincts of Sensoji Temple (to Main Hall) - YouTube", "category": "観光", "youtubeId": "nOk4cd0kkp8"},
    {"title": "浅草寺の境内（雷門側）Precincts of Sensoji Temple (to Kaminarimon) - YouTube", "category": "観光", "youtubeId": "hBiBadOukZA"},
    {"title": "【LIVE CAMERA】#南丹 #紅葉峠展望台 #ライブカメラ #livecamera #nantan #momijitougetenboudai - YouTube", "category": "観光", "youtubeId": "Kdvg84_mL8Q"},
    {"title": "【ライブ】群馬県・高崎市 高崎駅周辺から24時間LIVE配信中！【LIVE: Takasaki,Gunma Takasaki Station】ANN/テレ朝 - YouTube", "category": "観光", "youtubeId": "YZcRxaKmvU4"},
    {"title": "海王丸ライブカメラ - YouTube", "category": "海岸", "youtubeId": "-UsW0JsRZXM"},
    {"title": "横須賀市災害監視カメラ　うみかぜ公園 - YouTube", "category": "海岸", "youtubeId": "Yj4CHgedlVw"},
    {"title": "八幡浜港フェリーターミナル ライブカメラ 海 4K　Yawatahama Port Ferry Terminal Live camera Sea side - YouTube", "category": "海岸", "youtubeId": "XJ-o3WNR6Fk"},
    {"title": "部原海岸ライブカメラ（千葉県勝浦市部原） - YouTube", "category": "海岸", "youtubeId": "z3TH-h6UtsE"},
    {"title": "🔴【LIVE】那覇空港・瀬長島・沖縄ライブカメラ【海と飛行機の見えるステーキ専門店 ヨナーズガーデン】Okinawa Naha Airport Yonars Garden - YouTube", "category": "海岸", "youtubeId": "-0wTh5KKSoE"},
    {"title": "尼崎市立魚つり公園 - YouTube", "category": "海岸", "youtubeId": "2dS0y7TZCPA"},
    {"title": "新潟日報メディアシップ２０階のライブカメラ【北側】　Live Camera in Niigata - YouTube - YouTube", "category": "海岸", "youtubeId": "npUguwCxiwI"},
    {"title": "元町港（大島） - YouTube", "category": "海岸", "youtubeId": "fVFhLgVTtQ0"},
    {"title": "【LIVE】明石海峡大橋ライブカメラ　瀬戸内海や淡路島の現在の様子　Akashi kaikyo Bridge and Awaji island - YouTube", "category": "海岸", "youtubeId": "TmoR3-XKgcI"},
  ];

  late PageController horizontalController;
  late PageController verticalController;

  Map<String, List<Map<String, String>>> categorizedVideos = {};
  String currentCategory = '';
  int currentCategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    // カテゴリごとに動画を分類
    for (var video in cameraData) {
      categorizedVideos.putIfAbsent(video['category']!, () => []).add(video);
    }

    currentCategory = categorizedVideos.keys.first;
    horizontalController = PageController();
    verticalController = PageController();
  }

  @override
  void dispose() {
    horizontalController.dispose();
    verticalController.dispose();
    super.dispose();
  }

  String getEmbedUrl(String youtubeId) {
    return 'https://www.youtube.com/embed/$youtubeId?autoplay=1&rel=0&modestbranding=1&enablejsapi=1';
  }

  @override
  Widget build(BuildContext context) {
    final categories = categorizedVideos.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ライブマップ - ${categories[currentCategoryIndex]}'),
      ),
      body: PageView.builder(
        controller: horizontalController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            currentCategoryIndex = index;
            currentCategory = categories[index];
          });
        },
        itemCount: categories.length,
        itemBuilder: (context, categoryIndex) {
          final videos = categorizedVideos[categories[categoryIndex]]!;
          return PageView.builder(
            controller: verticalController,
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, videoIndex) {
              final video = videos[videoIndex];
              return Column(
                children: [
                  Expanded(
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(Uri.parse(getEmbedUrl(video['youtubeId']!))),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          video['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'カテゴリ: ${video['category']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
