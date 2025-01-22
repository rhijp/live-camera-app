import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrefectureListPage extends StatelessWidget {
  const PrefectureListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 都道府県のリスト
    final List<String> prefectures = [
      "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
      "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
      "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県",
      "岐阜県", "静岡県", "愛知県", "三重県",
      "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
      "鳥取県", "島根県", "岡山県", "広島県", "山口県",
      "徳島県", "香川県", "愛媛県", "高知県",
      "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('都道府県一覧'),
      ),
      body: ListView.builder(
        itemCount: prefectures.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(prefectures[index]),
            onTap: () {
              // 都道府県ごとのライブカメラ画面に遷移
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrefectureCameraPage(
                    prefecture: prefectures[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PrefectureCameraPage extends StatelessWidget {
  final String prefecture;

  // 仮のデータ（都道府県ごとの動画データを定義）
  final Map<String, List<Map<String, String>>> cameraDataByPrefecture = {
    "群馬県": [
      {"title": "「LIVE CAMERA」草津温泉・温泉門 - YouTube", "youtubeId": "d6a0sL8lYGkQ"},
      {"title": "「LIVECAMERA 」西の河原露天風呂入り口 - YouTube", "youtubeId": "RJYYbPs8hjQ"},
      {"title": "「LIVE CAMERA」草津温泉スキー場　天狗山山頂エリア - YouTube", "youtubeId": "JDLSr4iqjIg"},
      
    ],
    "京都府": [
      {"title": "🔴【生中継】京都タワー Kyoto Japan Live Camera 🌙京都ライブカメラ 🏢🗼🕯🎑　森信三郎商舗より生中継 🌕 即時影像 LiveCam　天気 京都観光 天体 - YouTube", "youtubeId": "IQKJPxjnjUw"},
      {"title": "東本願寺", "youtubeId": "RJYYbPs8hjQ"},
    ],
    // 他の都道府県のデータを追加
  };

  PrefectureCameraPage({Key? key, required this.prefecture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cameras = cameraDataByPrefecture[prefecture] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$prefectureのライブカメラ'),
      ),
      body: cameras.isEmpty
          ? Center(
              child: Text(
                '現在、$prefectureのライブカメラデータはありません。',
                style: const TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: cameras.length,
              itemBuilder: (context, index) {
                final video = cameras[index];
                return ListTile(
                  title: Text(video['title']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(title: Text(video['title']!)),
                          body: WebViewWidget(
                            controller: WebViewController()
                              ..setJavaScriptMode(JavaScriptMode.unrestricted)
                              ..loadRequest(Uri.parse(
                                'https://www.youtube.com/embed/${video['youtubeId']}?autoplay=1',
                              )),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}