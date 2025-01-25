import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class LiveCameraPage extends StatefulWidget {
  const LiveCameraPage({Key? key}) : super(key: key);

  @override
  State<LiveCameraPage> createState() => _LiveCameraPageState();
}

class _LiveCameraPageState extends State<LiveCameraPage> with SingleTickerProviderStateMixin {
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
    {"title": "札幌市ライブカメラ | lofi, beats to relax | 狸小路8丁目交差点 雪道・道路状況 - YouTube", "category": "道路", "youtubeId": "CF1vS8DdBIk"},
    {"title": "[LIVE][北海道北見市常呂町]大友産業より道道北見常呂線・常呂町基線交差点ライブ (HOKKAIDO KITAMI TOKORO LIVECAMERA) - YouTube", "category": "道路", "youtubeId": "94Y6ybrTYQY"},
    {"title": "北海道士幌町のライブカメラ Shihoro town, Hokkaido, Japan - YouTube", "category": "道路", "youtubeId": "cElpVZpu1wI"},
    {"title": "十勝大橋ライブカメラ Live Camera in Tokachi Big Bridge over the Tokachi river, Hokkaido in Japan - YouTube", "category": "河川", "youtubeId": "nk9uKVuLcGE"},
    {"title": "【LIVE】仙台・広瀬通＠朝日新聞社仙台総局　Hirosedori street in Sendai - YouTube", "category": "道路", "youtubeId": "ClAXk49nOSw"},
    {"title": "[LIVE]仙台・愛宕上杉通ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "DSR9lyqMVvM"},
    {"title": "[LIVE]仙台・北環状線(南吉成)ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "94Y6ybrTYQY"},
    {"title": "[LIVE]仙台・東二番丁(五橋)ライブカメラ/Live streaming from Sendai-city,Japan - YouTube", "category": "道路", "youtubeId": "9UNpXYB8rCQ"},
    {"title": "【24時間配信中】現在の山形市 - YouTube", "category": "その他", "youtubeId": "J56hFFHTfls"},
    {"title": "【生配信】現在の山形空港 - YouTube", "category": "空港", "youtubeId": "o3HewgWWtw0"},
    {"title": "三春滝桜 ライブカメラ 【2024.3.27～配信開始　4月10日満開】 - YouTube", "category": "観光", "youtubeId": "a49pXas0L4M"},
    {"title": "つくば駅前ライブカメラ　人材派遣のインテック 365日　24時間　オンライン登録受付中　 - YouTube", "category": "鉄道", "youtubeId": "zlQHMm67CSQ"},
    {"title": "ホテル森の風那須　ライブカメラHOTEL MORI NO KAZE NASU Live Camera - YouTube", "category": "山岳", "youtubeId": "tx5tWvV1EQ"},
    {"title": "【LIVE】千葉県ライブカメラ　千葉市内の現在の様子　Chiba 지바 - YouTube", "category": "道路", "youtubeId": "yXn9ZlZWBbk"},
    {"title": "【LIVE】成田空港ライブカメラ　A滑走路(南側）＠朝日新聞成田支局 LIVE at Narita International airport - YouTube", "category": "空港", "youtubeId": "wb2xVVPA_2o"},
    {"title": "部原海岸ライブカメラ（千葉県勝浦市部原） - YouTube", "category": "海岸", "youtubeId": "z3TH-h6UtsE"},
    {"title": "【江の島 ライブカメラ3】🐬腰越海岸：Enoshima LiveCamera3 24Hours - YouTube", "category": "海岸", "youtubeId": "WtkI9yUqUxk"},
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
    {"title": " 【道の駅】新潟県・笹川流れ 夕日会館　Liveチャンネル（Road Station Murakami City, Niigata Prefecture　Sasagawa Nagare）+BGM - YouTube", "category": "道路", "youtubeId": "nwO2D1yUnT8"},
    {"title": " 新潟日報メディアシップ２０階のライブカメラ【北側】　Live Camera in Niigata - YouTube", "category": "海岸", "youtubeId": "npUguwCxiwI"},
    {"title": " 【＜LIVE配信＞新潟駅前ライブカメラ　リニューアル工事が進む新潟駅（新潟市中央区） - YouTube", "category": "鉄道", "youtubeId": "MUnfLeaTaQU"},
    {"title": " 海王丸ライブカメラ - YouTube", "category": "海岸", "youtubeId": "UsW0JsRZXM"},
    {"title": "  ライブカメラ　金沢市（石川県）Kanazawa , Ishikawa , Japan - Live Camera - YouTube    ", "category": "道路", "youtubeId": "UMq8otOTTjU"},
    {"title": " 【石川県・珠洲市】被災地の天気は… Suzu, Ishikawa Japan #地震 #災害 #能登半島地震 #テレビ金沢 #ニュース - YouTube", "category": "その他", "youtubeId": "93DsB7VeJ-w"},
    {"title": " 〈石川県宝達志水町〉今浜海岸ライブカメラ - YouTube", "category": "海岸", "youtubeId": "pzmULgVLlQo"},
    {"title": " 兼六園ライブカメラ - YouTube", "category": "観光", "youtubeId": "uUTpDBgqQL8"},
    {"title": " 【LIVE】能登ワイン周辺ぶどう畑　石川県穴水町 - YouTube", "category": "観光", "youtubeId": "rXwJr5g3rzI"},
    {"title": " 新九頭竜橋 ライブカメラ - YouTube", "category": "河川", "youtubeId": "ogfzNJJlEHo"},
    {"title": " 足羽川・木田橋 ライブカメラ - YouTube ", "category": "河川", "youtubeId": "k3lKNrqtSyE"},
    {"title": " 国道８号線 大和田方面 ライブカメラ - YouTube", "category": "道路", "youtubeId": "LZ_T91paAU"},
    {"title": " 福井駅西口 ライブカメラ - YouTube", "category": "鉄道", "youtubeId": "IrXQ8JID0Gs"},
    {"title": " 北陸自動車道南条ＳＡ付近 ライブカメラ - YouTube", "category": "道路", "youtubeId": "htp23noMgRo"},
    {"title": " 三国・サンセットビーチ ライブカメラ - YouTube   ", "category": "海岸", "youtubeId": "CIjhFpsN-3k"},
    {"title": " 【ライブカメラ】FBC情報カメラ　福井県小浜市 - YouTube", "category": "道路", "youtubeId": "acLJEotPVJc"},
    {"title": " 【ライブカメラ】FBC情報カメラ　福井県福井市　福井駅付近　#ハピラインふくい #北陸新幹線 - YouTube", "category": "鉄道", "youtubeId": "tHMEnSTnFd4"},
    {"title": " 【LIVE】静岡市さった峠　広重の富士山 / Mt. Fuji (World Heritage Site): Live Streaming in Shizuoka City - YouTube", "category": "道路", "youtubeId": "GsD9QQEKSzQ"},
    {"title": " 【LIVE】静岡市さった峠　交通の要衝 - YouTube", "category": "道路", "youtubeId": "6S4qvf97cbQ"},
    {"title": " 【LIVE】静岡ライブカメラ　現在の静岡市内　Shizuoka - YouTube", "category": "道路", "youtubeId": "0DHvrnepYJ0"},
    {"title": " はままつフラワーパーク　ライブカメラ 24h配信中 - YouTube", "category": "道路", "youtubeId": "6S4qvf97cbQ"},
    {"title": " JR浜松駅南口（新幹線口）24時間ライブカメラ - YouTube", "category": "鉄道", "youtubeId": "2RUChKtPxaY"},
    {"title": " 熱海みのやホテルライブカメラ - YouTube", "category": "海岸", "youtubeId": "uJChZdBiID8"},
    {"title": " 【琵琶湖湖畔・滋賀】リモート地蔵【お地蔵さんが本物の天気予報と琵琶湖の水位を答えてくれる】現在の砂浜の様子　浜欠けのメカニズム分析【滋賀】【外来魚回収BOX】LIVE生放送 - YouTube", "category": "河川", "youtubeId": "QfXmc9hrGu0"},
    {"title": " 太陽光発電 リアルタイム配信中 ／ 京阪電車 鉄道ライブカメラ【中書島～淀】 Keihan Electric Railway Kyoto Japan - YouTube", "category": "道路", "youtubeId": "6S4qvf97cbQ"},
    {"title": " 🔴【生中継】京都タワー Kyoto Japan Live Camera 🌙京都ライブカメラ 🏢🗼🕯🎑　森信三郎商舗より生中継 🌕 即時影像 LiveCam　天気 京都観光 天体 - YouTube", "category": "観光", "youtubeId": "IQKJPxjnjUw"},
    {"title": " 【LIVE】笠置キャンプ場ライブカメラ／Kasagi campsite livecam - YouTube", "category": "道路", "youtubeId": "jp8YydpqWJA"},
    {"title": " 【LIVE】🚅🇯🇵 京都駅 鉄道ライブカメラ JR東海 東海道新幹線カメラ 京都ライブカメラ ドクターイエローライブカメラ - YouTube", "category": "鉄道", "youtubeId": "D30itjKa2go"},
    {"title": " 【LIVE】京都 北野天満宮前付近ライブ中継カメラ（京都市観光協会公式）／Kitano Tenmangu Shrine, Kyoto Live camera - YouTube", "category": "観光", "youtubeId": "KHglGodzQ9g"},
    {"title": " 【LIVE】京都 嵯峨嵐山 渡月橋北詰ライブ中継カメラ（京都市観光協会公式）／Saga Arashiyama, Kyoto Live camera - YouTube", "category": "観光", "youtubeId": "jqtsC5BYlIk"},
    {"title": " 【ライブ配信】夜景がきれい！あべのハルカス・大阪の夜景/OSAKA NIGHT VEW - YouTube", "category": "道路", "youtubeId": "qz8F44n5DEw"},
    {"title": " 大阪空港ライブカメラ - YouTube", "category": "空港", "youtubeId": "0C2EK3VUdLw"},
    {"title": " 【LIVE】大阪国際空港（伊丹空港）ライブカメラ　＠朝日新聞社格納庫 - YouTube", "category": "空港", "youtubeId": "Tjr2tG_Wg70"},
    {"title": " 【LIVE】 大阪　ライブカメラ　北新地本通　ダーリンビル - YouTube", "category": "道路", "youtubeId": "Xtf16Aa2n3o"},
    {"title": " 大阪府摂津市　府道19号線　リアルタイム ライブ配信　渋滞情報 - YouTube", "category": "道路", "youtubeId": "65mMpFTsYz0"},
    {"title": " 〔LIVE〕JR大阪駅 桜橋口タクシー乗場ライブ中継カメラ（大阪タクシーセンター公式) /OsakaStation SakurabashiGate TaxiStation LiveCamera - YouTube", "category": "鉄道", "youtubeId": "jDCCynfjX9I"},
    {"title": " 宝塚お天気カメラ - YouTube", "category": "その他", "youtubeId": "rPJksdxOggI"},
    {"title": " 【LIVE】神戸ウォーターフロント ＃メリケンパーク＃神戸ポートタワー - YouTube", "category": "観光", "youtubeId": "AU_2zfM4m68"},
    {"title": "  伊丹空港　ライブ配信　2024.05.07　(スカイランドHARADA)　Osaka International Airport　Japan - YouTube", "category": "空港", "youtubeId": "apog1DBabJg"},
    {"title": " 尼崎市立魚つり公園 - YouTube", "category": "海岸", "youtubeId": "2dS0y7TZCPA"},
    {"title": " 湯原温泉お天気ライブカメラ　青空・雨　岡山県真庭市 - YouTube", "category": "観光", "youtubeId": "PbqxYObjHms"},
    {"title": " 【LIVE】岡山後楽園ライブカメラ Okayama Korakuen Garden - YouTube", "category": "観光", "youtubeId": "Mk-_-Nq7Mtw"},
    {"title": " 【LIVE】広島空港ライブカメラ/Hiroshima Airport Plane Spotting - YouTube", "category": "空港", "youtubeId": "UlNoPGKJ_9k"},
    {"title": " しまなみライブカメラ【EBC】 - YouTube", "category": "海岸", "youtubeId": "OV0JEv6C2QQ"},
    {"title": " 【LIVEカメラ】瀬戸大橋ライブカメラ Seto Ohashi Bridge Livecamera - YouTube", "category": "海岸", "youtubeId": "TGxd6RJTLck"},
    {"title": " 八幡浜港フェリーターミナル ライブカメラ 海 4K　Yawatahama Port Ferry Terminal Live camera Sea side - YouTube", "category": "海岸", "youtubeId": "XJ-o3WNR6Fk"},
    {"title": " 関門海峡【LIVE CAMERA】癒しの空間、関門海峡を（門司港から）ライブ配信中！ 船の汽笛が聴けるように生音での配信（壇ノ浦の戦いの場）※チャット参加の方は概要欄一読を🙏 - YouTube", "category": "海岸", "youtubeId": "_r-g8wU-0o8"},
    {"title": " 【NCC】佐世保港ライブ - YouTube", "category": "空港", "youtubeId": "tGaSspbB8wA"},
    {"title": "  【LIVE】沖縄・石垣島（Ishigaki Island) Okinawa JAPAN｜RBC News - YouTube", "category": "海岸", "youtubeId": "MKMk5UqVLcc"},
  ];

  late TabController _tabController;
  int currentVideoIndex = 0;
  String currentCategory = "観光";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    if (kIsWeb) {
      _registerIframeViews();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _registerIframeViews() {
    for (int i = 0; i < cameraData.length; i++) {
      final embedUrl = 'https://www.youtube.com/embed/${cameraData[i]['youtubeId']}?autoplay=1';
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        'youtube-iframe-$i',
        (int viewId) {
          return html.IFrameElement()
            ..src = embedUrl
            ..style.border = 'none';
        },
      );
    }
  }

  /// 現在のカテゴリに一致する動画を取得
  List<Map<String, String>> get filteredVideos {
    return cameraData.where((video) => video['category'] == currentCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final videos = filteredVideos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ライブカメラ"),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            setState(() {
              // タブインデックスに応じたカテゴリを設定
              switch (index) {
                case 0:
                  currentCategory = "観光";
                  break;
                case 1:
                  currentCategory = "海岸";
                  break;
                case 2:
                  currentCategory = "河川";
                case 3:
                  currentCategory = "道路";
                  break;
                case 4:
                  currentCategory = "空港";
                  break;
                case 5:
                  currentCategory = "鉄道";
                  break;
                case 6:
                  currentCategory = "その他";
                  break;
                default:
                  currentCategory = "観光";
              }
              currentVideoIndex = 0; // 新しいカテゴリの最初の動画にリセット
            });
          },
          tabs: const [
            Tab(text: "観光"),
            Tab(text: "海岸"),
            Tab(text: "河川"),
            Tab(text: "道路"),
            Tab(text: "空港"),
            Tab(text: "鉄道"),
            Tab(text: "その他"),
          ],
        ),
      ),
      body: videos.isEmpty
          ? const Center(child: Text("選択したカテゴリに動画がありません"))
          : Column(
              children: [
                // 動画表示
                Expanded(
                  child: kIsWeb
                      ? HtmlElementView(
                          viewType: 'youtube-iframe-${cameraData.indexOf(videos[currentVideoIndex])}')
                      : const Center(child: Text("Webでのみ利用可能")),
                ),
                // 次の動画ボタンとタイトル
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        videos[currentVideoIndex]['title']!,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentVideoIndex = (currentVideoIndex + 1) % videos.length;
                          });
                        },
                        child: const Text("次の動画へ"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
