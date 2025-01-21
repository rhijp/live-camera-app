import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class LiveCameraPage extends StatefulWidget {
  const LiveCameraPage({Key? key}) : super(key: key);

  @override
  State<LiveCameraPage> createState() => _LiveCameraPageState();
}

class _LiveCameraPageState extends State<LiveCameraPage> {
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

  int currentVideoIndex = 0;
  String currentCategory = '観光';

  @override
  void initState() {
    super.initState();
    _registerIframeViews();
  }

  void _registerIframeViews() {
    for (int i = 0; i < cameraData.length; i++) {
      final embedUrl = 'https://www.youtube.com/embed/${cameraData[i]['youtubeId']}?autoplay=1&rel=0&modestbranding=1';
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        'youtube-iframe-$i',
        (int viewId) {
          return html.IFrameElement()
            ..src = embedUrl
            ..style.border = 'none'
            ..allowFullscreen = true;
        },
      );
    }
  }

  List<Map<String, String>> get filteredVideos {
    return cameraData.where((video) => video['category'] == currentCategory).toList();
  }

  void _changeCategory(String category) {
    setState(() {
      currentCategory = category;
      currentVideoIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final videos = filteredVideos;
    final currentVideo = videos[currentVideoIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('カテゴリ: $currentCategory'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _changeCategory,
            itemBuilder: (context) {
              return ['観光', '海岸']
                  .map((category) => PopupMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: HtmlElementView(viewType: 'youtube-iframe-${cameraData.indexOf(currentVideo)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  currentVideo['title']!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('カテゴリ: ${currentVideo['category']}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentVideoIndex = (currentVideoIndex + 1) % videos.length;
                    });
                  },
                  child: const Text('次の動画へ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
