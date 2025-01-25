import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart' show kIsWeb;

class PrefectureListPage extends StatelessWidget {
  const PrefectureListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    final Map<String, List<Map<String, String>>> cameraDataByPrefecture = {

"北海道": [
      {"title": "札幌市ライブカメラ | lofi, beats to relax | 狸小路8丁目交差点 雪道・道路状況 - YouTube", "category": "道路", "youtubeId": "CF1vS8DdBIk"},
     {"title": "[LIVE][北海道北見市常呂町]大友産業より道道北見常呂線・常呂町基線交差点ライブ (HOKKAIDO KITAMI TOKORO LIVECAMERA) - YouTube", "category": "道路", "youtubeId": "94Y6ybrTYQY"},
    {"title": "北海道士幌町のライブカメラ Shihoro town, Hokkaido, Japan - YouTube", "category": "道路", "youtubeId": "cElpVZpu1wI"},
    {"title": "十勝大橋ライブカメラ Live Camera in Tokachi Big Bridge over the Tokachi river, Hokkaido in Japan - YouTube", "category": "河川", "youtubeId": "nk9uKVuLcGE"},
      
    ],
    
   

    "宮城県": [
    {"title": "【LIVE】仙台・広瀬通＠朝日新聞社仙台総局　Hirosedori street in Sendai - YouTube", "category": "道路", "youtubeId": "ClAXk49nOSw"},
    {"title": "[LIVE]仙台・愛宕上杉通ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "DSR9lyqMVvM"},
    {"title": "[LIVE]仙台・北環状線(南吉成)ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "94Y6ybrTYQY"},
    {"title": "[LIVE]仙台・東二番丁(五橋)ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "9UNpXYB8rCQ"},
    {"title": "[LIVE]仙台・北環状線(南吉成)ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "94Y6ybrTYQY"},
    ],

    "山形県": [
    {"title": "【24時間配信中】現在の山形市 - YouTube", "category": "その他", "youtubeId": "J56hFFHTfls"},
    {"title": "【生配信】現在の山形空港 - YouTube", "category": "空港", "youtubeId": "o3HewgWWtw0"},
    ],

    "福島県": [
   {"title": "三春滝桜 ライブカメラ 【2024.3.27～配信開始　4月10日満開】 - YouTube", "category": "観光", "youtubeId": "a49pXas0L4M"},
    ],

     "茨城県": [
       {"title": "つくば駅前ライブカメラ　人材派遣のインテック 365日　24時間　オンライン登録受付中　 - YouTube", "category": "鉄道", "youtubeId": "zlQHMm67CSQ"},
    ],

     "栃木県": [
     {"title": "ホテル森の風那須　ライブカメラHOTEL MORI NO KAZE NASU Live Camera - YouTube", "category": "山岳", "youtubeId": "tx5tWvV1EQ"},
    ],

     "群馬県": [
     {"title": "「LIVE CAMERA」草津温泉・温泉門 - YouTube", "category": "観光", "youtubeId": "d6a0sL8lYGkQ"},
    {"title": "「LIVECAMERA 」西の河原露天風呂入り口 - YouTube", "category": "観光", "youtubeId": "RJYYbPs8hjQ"},
    {"title": "「LIVE CAMERA」草津温泉スキー場　天狗山山頂エリア - YouTube", "category": "観光", "youtubeId": "JDLSr4iqjIg"},
     ],

      "千葉県": [
        {"title": "【LIVE】千葉県ライブカメラ　千葉市内の現在の様子　Chiba 지바 - YouTube", "category": "道路", "youtubeId": "yXn9ZlZWBbk"},
    {"title": "【LIVE】成田空港ライブカメラ　A滑走路(南側）＠朝日新聞成田支局 LIVE at Narita International airport - YouTube", "category": "空港", "youtubeId": "wb2xVVPA_2o"},
     ],

     "神奈川県": [
       {"title": "【江の島 ライブカメラ3】🐬腰越海岸：Enoshima LiveCamera3 24Hours - YouTube", "category": "海岸", "youtubeId": "WtkI9yUqUxk"},
    {"title": "「箱根遊船 SORAKAZE」ライブカメラ / Live camera ”SORAKAZE”(Hakone Cruise Ship) - YouTube", "category": "海岸", "youtubeId": "wY19h-e-8hM"},
     ],


     "東京都": [
    {"title": "東京 ライブ Tokyo Live (April 8th) Rainbow Bridge On-Ramp & Tokyo Sky Tree View - YouTube", "category": "河川", "youtubeId": "r74OyneNmg8"},
    {"title": "【LIVE】東京・築地ライブカメラ　湾岸やレインボーブリッジのある風景　 at Tsukiji, view of Tokyo waterfront and Rainbow bridge - YouTube", "category": "海岸", "youtubeId": "bKVGdsMVuMA"},
    {"title": "【空堀川】中里映像監視局［清瀬市野塩］ - YouTube", "category": "河川", "youtubeId": "dLsuCS_w0-8"},
    {"title": "【落合川】立野二の橋映像監視局［東久留米市本町1］ - YouTube", "category": "河川", "youtubeId": "3Lgz7df1nqE"},
    {"title": "【養沢川】小宮ふるさと自然学校映像監視局［あきる野乙津］ - YouTube", "category": "河川", "youtubeId": "2Hl_YCgM0g8"},
    {"title": "【東京湾ライブカメラ】 LIVE Tokyo Bay, Traffic between ships and planes - Sea and Sky / japan travel / Live cam - YouTube", "category": "海岸", "youtubeId": "qMDxy_qbdtE"},
    {"title": "【有明ライブカメラ】 LIVE Scenery overlooking land, sea and sky, Tokyo JAPAN / Tokyo Bay / Live cam - YouTube", "category": "河川", "youtubeId": "_ByNEL0Ton4"},
    {"title": "【LIVE】2024 Tokyo Shinjuku 新宿 大ガード交差点 Live Ch - YouTube", "category": "道路", "youtubeId": "6dp-bvQ7RWo"},
    {"title": "渋谷センター街 マクドナルド前 ライブカメラ - YouTube", "category": "道路", "youtubeId": "XBt5Fg69iLE"},
    {"title": "【LIVE】JAPAN 東京都足立区日暮里舎人ライナー側ライブカメラ TOKYO ADACHI-KU NIPPORI TONERI LINER LIVECAMERA コスモ石油 - YouTube", "category": "観光", "youtubeId": "E3uAem1vsEk"},
    {"title": "【LIVE】JAPAN 東京都足立区立みだまえ公園カメラ2 TOKYO JAPAN LIVECAMERA ライブカメラ - YouTube", "category": "道路", "youtubeId": "qsTJNeJq_q8"},
    {"title": " 【白子川】子安橋映像監視局［練馬区旭町3］ - YouTube", "category": "道路", "youtubeId": "93DsB7VeJ-w"},
     ],


   "新潟県": [
           {"title": " 【道の駅】新潟県・笹川流れ 夕日会館　Liveチャンネル（Road Station Murakami City, Niigata Prefecture　Sasagawa Nagare）+BGM - YouTube", "category": "道路", "youtubeId": "nwO2D1yUnT8"},
    {"title": " 新潟日報メディアシップ２０階のライブカメラ【北側】　Live Camera in Niigata - YouTube", "category": "海岸", "youtubeId": "npUguwCxiwI"},
    {"title": " 【＜LIVE配信＞新潟駅前ライブカメラ　リニューアル工事が進む新潟駅（新潟市中央区） - YouTube", "category": "鉄道", "youtubeId": "MUnfLeaTaQU"},

   ],

   "富山県": [
   {"title": " 海王丸ライブカメラ - YouTube", "category": "海岸", "youtubeId": "UsW0JsRZXM"},

   ],

   "石川県": [
  {"title": "  ライブカメラ　金沢市（石川県）Kanazawa , Ishikawa , Japan - Live Camera - YouTube    ", "category": "道路", "youtubeId": "UMq8otOTTjU"},
    {"title": " 【石川県・珠洲市】被災地の天気は… Suzu, Ishikawa Japan #地震 #災害 #能登半島地震 #テレビ金沢 #ニュース - YouTube", "category": "その他", "youtubeId": "93DsB7VeJ-w"},
    {"title": " 〈石川県宝達志水町〉今浜海岸ライブカメラ - YouTube", "category": "海岸", "youtubeId": "pzmULgVLlQo"},
    {"title": " 兼六園ライブカメラ - YouTube", "category": "観光", "youtubeId": "uUTpDBgqQL8"},
    {"title": " 【LIVE】能登ワイン周辺ぶどう畑　石川県穴水町 - YouTube", "category": "観光", "youtubeId": "rXwJr5g3rzI"},

   ],

    "福井県": [
    {"title": " 新九頭竜橋 ライブカメラ - YouTube", "category": "河川", "youtubeId": "ogfzNJJlEHo"},
    {"title": " 足羽川・木田橋 ライブカメラ - YouTube ", "category": "河川", "youtubeId": "k3lKNrqtSyE"},
    {"title": " 国道８号線 大和田方面 ライブカメラ - YouTube", "category": "道路", "youtubeId": "LZ_T91paAU"},
    {"title": " 福井駅西口 ライブカメラ - YouTube", "category": "鉄道", "youtubeId": "IrXQ8JID0Gs"},
    {"title": " 北陸自動車道南条ＳＡ付近 ライブカメラ - YouTube", "category": "道路", "youtubeId": "htp23noMgRo"},
    {"title": " 三国・サンセットビーチ ライブカメラ - YouTube   ", "category": "海岸", "youtubeId": "CIjhFpsN-3k"},
    {"title": " 【ライブカメラ】FBC情報カメラ　福井県小浜市 - YouTube", "category": "道路", "youtubeId": "acLJEotPVJc"},
    {"title": " 【ライブカメラ】FBC情報カメラ　福井県福井市　福井駅付近　#ハピラインふくい #北陸新幹線 - YouTube", "category": "鉄道", "youtubeId": "tHMEnSTnFd4"},

   ],

   "静岡県": [
     {"title": " 【LIVE】静岡市さった峠　広重の富士山 / Mt. Fuji (World Heritage Site): Live Streaming in Shizuoka City - YouTube", "category": "道路", "youtubeId": "GsD9QQEKSzQ"},
    {"title": " 【LIVE】静岡市さった峠　交通の要衝 - YouTube", "category": "道路", "youtubeId": "6S4qvf97cbQ"},
    {"title": " 【LIVE】静岡ライブカメラ　現在の静岡市内　Shizuoka - YouTube", "category": "道路", "youtubeId": "0DHvrnepYJ0"},
    {"title": " はままつフラワーパーク　ライブカメラ 24h配信中 - YouTube", "category": "道路", "youtubeId": "6S4qvf97cbQ"},
    {"title": " JR浜松駅南口（新幹線口）24時間ライブカメラ - YouTube", "category": "鉄道", "youtubeId": "2RUChKtPxaY"},
    {"title": " 熱海みのやホテルライブカメラ - YouTube", "category": "海岸", "youtubeId": "uJChZdBiID8"},

   ],

    "滋賀県": [
    {"title": " 【琵琶湖湖畔・滋賀】リモート地蔵【お地蔵さんが本物の天気予報と琵琶湖の水位を答えてくれる】現在の砂浜の様子　浜欠けのメカニズム分析【滋賀】【外来魚回収BOX】LIVE生放送 - YouTube", "category": "河川", "youtubeId": "QfXmc9hrGu0"},
   ],

    "京都府": [
    {"title": " 太陽光発電 リアルタイム配信中 ／ 京阪電車 鉄道ライブカメラ【中書島～淀】 Keihan Electric Railway Kyoto Japan - YouTube", "category": "道路", "youtubeId": "6S4qvf97cbQ"},
    {"title": " 🔴【生中継】京都タワー Kyoto Japan Live Camera 🌙京都ライブカメラ 🏢🗼🕯🎑　森信三郎商舗より生中継 🌕 即時影像 LiveCam　天気 京都観光 天体 - YouTube", "category": "観光", "youtubeId": "IQKJPxjnjUw"},
    {"title": " 【LIVE】笠置キャンプ場ライブカメラ／Kasagi campsite livecam - YouTube", "category": "道路", "youtubeId": "jp8YydpqWJA"},
    {"title": " 【LIVE】🚅🇯🇵 京都駅 鉄道ライブカメラ JR東海 東海道新幹線カメラ 京都ライブカメラ ドクターイエローライブカメラ - YouTube", "category": "鉄道", "youtubeId": "D30itjKa2go"},
    {"title": " 【LIVE】京都 北野天満宮前付近ライブ中継カメラ（京都市観光協会公式）／Kitano Tenmangu Shrine, Kyoto Live camera - YouTube", "category": "観光", "youtubeId": "KHglGodzQ9g"},
    {"title": " 【LIVE】京都 嵯峨嵐山 渡月橋北詰ライブ中継カメラ（京都市観光協会公式）／Saga Arashiyama, Kyoto Live camera - YouTube", "category": "観光", "youtubeId": "jqtsC5BYlIk"},
    ],

    "大阪府": [
   {"title": " 【ライブ配信】夜景がきれい！あべのハルカス・大阪の夜景/OSAKA NIGHT VEW - YouTube", "category": "道路", "youtubeId": "qz8F44n5DEw"},
    {"title": " 大阪空港ライブカメラ - YouTube", "category": "空港", "youtubeId": "0C2EK3VUdLw"},
    {"title": " 【LIVE】大阪国際空港（伊丹空港）ライブカメラ　＠朝日新聞社格納庫 - YouTube", "category": "空港", "youtubeId": "Tjr2tG_Wg70"},
    {"title": " 【LIVE】 大阪　ライブカメラ　北新地本通　ダーリンビル - YouTube", "category": "道路", "youtubeId": "Xtf16Aa2n3o"},
    {"title": " 大阪府摂津市　府道19号線　リアルタイム ライブ配信　渋滞情報 - YouTube", "category": "道路", "youtubeId": "65mMpFTsYz0"},
    {"title": " 〔LIVE〕JR大阪駅 桜橋口タクシー乗場ライブ中継カメラ（大阪タクシーセンター公式) /OsakaStation SakurabashiGate TaxiStation LiveCamera - YouTube", "category": "鉄道", "youtubeId": "jDCCynfjX9I"},
    ],


    "兵庫県": [
{"title": " 宝塚お天気カメラ - YouTube", "category": "その他", "youtubeId": "rPJksdxOggI"},
    {"title": " 【LIVE】神戸ウォーターフロント ＃メリケンパーク＃神戸ポートタワー - YouTube", "category": "観光", "youtubeId": "AU_2zfM4m68"},
    {"title": "  伊丹空港　ライブ配信　2024.05.07　(スカイランドHARADA)　Osaka International Airport　Japan - YouTube", "category": "空港", "youtubeId": "apog1DBabJg"},
    {"title": " 尼崎市立魚つり公園 - YouTube", "category": "海岸", "youtubeId": "2dS0y7TZCPA"},
    ],

     "岡山県": [
    {"title": " 湯原温泉お天気ライブカメラ　青空・雨　岡山県真庭市 - YouTube", "category": "観光", "youtubeId": "PbqxYObjHms"},
    {"title": " 【LIVE】岡山後楽園ライブカメラ Okayama Korakuen Garden - YouTube", "category": "観光", "youtubeId": "Mk-_-Nq7Mtw"},
  
    ],

    "広島県": [
    {"title": " 【LIVE】広島空港ライブカメラ/Hiroshima Airport Plane Spotting - YouTube", "category": "空港", "youtubeId": "UlNoPGKJ_9k"},
    {"title": " しまなみライブカメラ【EBC】 - YouTube", "category": "海岸", "youtubeId": "OV0JEv6C2QQ"},
  
    ],

     "香川県": [
    {"title": " 【LIVEカメラ】瀬戸大橋ライブカメラ Seto Ohashi Bridge Livecamera - YouTube", "category": "海岸", "youtubeId": "TGxd6RJTLck"},
  
    ],

    "愛媛県": [
     {"title": " 八幡浜港フェリーターミナル ライブカメラ 海 4K　Yawatahama Port Ferry Terminal Live camera Sea side - YouTube", "category": "海岸", "youtubeId": "XJ-o3WNR6Fk"},
  
    ],

     "福岡県": [
     {"title": " 関門海峡【LIVE CAMERA】癒しの空間、関門海峡を（門司港から）ライブ配信中！ 船の汽笛が聴けるように生音での配信（壇ノ浦の戦いの場）※チャット参加の方は概要欄一読を🙏 - YouTube", "category": "海岸", "youtubeId": "_r-g8wU-0o8"},
  
    ],
     "長崎県": [
     {"title": " 【NCC】佐世保港ライブ - YouTube", "category": "空港", "youtubeId": "tGaSspbB8wA"},
  
    ],

      "沖縄県": [
     {"title": "  【LIVE】沖縄・石垣島（Ishigaki Island) Okinawa JAPAN｜RBC News - YouTube", "category": "海岸", "youtubeId": "MKMk5UqVLcc"},
  
    ]



    
      
   
    // 他の都道府県のデータを追加
  };


    return Scaffold(
      appBar: AppBar(title: const Text('都道府県一覧')),
      body: ListView.builder(
        itemCount: prefectures.length,
        itemBuilder: (context, index) {
          final prefecture = prefectures[index];
          final count = cameraDataByPrefecture[prefecture]?.length ?? 0;
          return ListTile(
            title: Text('$prefecture ($count)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrefectureCameraPage(
                    prefecture: prefecture,
                    cameras: cameraDataByPrefecture[prefecture] ?? [],
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
  final List<Map<String, String>> cameras;

  const PrefectureCameraPage({Key? key, required this.prefecture, required this.cameras})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$prefectureのライブカメラ')),
      body: cameras.isEmpty
          ? Center(child: Text('$prefectureにライブカメラはありません。'))
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
                        builder: (context) => VideoPlayerPage(
                          youtubeId: video['youtubeId']!,
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

class VideoPlayerPage extends StatelessWidget {
  final String youtubeId;

  const VideoPlayerPage({Key? key, required this.youtubeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Web用のiframe
      final embedUrl = 'https://www.youtube.com/embed/$youtubeId?autoplay=1';
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        'youtube-iframe-$youtubeId',
        (int viewId) => html.IFrameElement()
          ..src = embedUrl
          ..style.border = 'none',
      );

      return Scaffold(
        appBar: AppBar(title: const Text('動画再生')),
        body: Center(child: HtmlElementView(viewType: 'youtube-iframe-$youtubeId')),
      );
    } else {
      // モバイル用のWebView
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse('https://www.youtube.com/embed/$youtubeId'));

      return Scaffold(
        appBar: AppBar(title: const Text('動画再生')),
        body: WebViewWidget(controller: controller),
      );
    }
  }
}
