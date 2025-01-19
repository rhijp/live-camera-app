import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PrefectureListPage extends StatefulWidget {
  const PrefectureListPage({Key? key}) : super(key: key);

  @override
  State<PrefectureListPage> createState() => _PrefectureListPageState();
}

class _PrefectureListPageState extends State<PrefectureListPage> {
  List<List<dynamic>> _cameraData = [];
  Map<String, int> _prefectureCount = {};
  Map<String, List<List<dynamic>>> _prefectureData = {};

  @override
  void initState() {
    super.initState();
    _loadCameraData();
  }

  Future<void> _loadCameraData() async {
    final rawData = await rootBundle.loadString('assets/japan-livecamera_data.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    listData = listData.sublist(1); // ヘッダーを除去

    Map<String, int> prefectureCount = {};
    Map<String, List<List<dynamic>>> prefectureData = {};

    for (var row in listData) {
      String prefecture = row[0] as String; // 1列目が都道府県
      if (!prefectureCount.containsKey(prefecture)) {
        prefectureCount[prefecture] = 0;
        prefectureData[prefecture] = [];
      }
      prefectureCount[prefecture] = prefectureCount[prefecture]! + 1;
      prefectureData[prefecture]!.add(row);
    }

    setState(() {
      _cameraData = listData;
      _prefectureCount = prefectureCount;
      _prefectureData = prefectureData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_prefectureCount.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('都道府県別ライブカメラ')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('都道府県別ライブカメラ')),
      body: ListView(
        children: _prefectureCount.keys.map((prefecture) {
          int count = _prefectureCount[prefecture]!;
          return ListTile(
            title: Text(prefecture),
            trailing: count > 0 ? Text('$count 件') : null,
            onTap: count > 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrefectureDetailPage(
                          prefecture: prefecture,
                          cameras: _prefectureData[prefecture]!,
                        ),
                      ),
                    );
                  }
                : null,
          );
        }).toList(),
      ),
    );
  }
}

class PrefectureDetailPage extends StatelessWidget {
  final String prefecture;
  final List<List<dynamic>> cameras;

  const PrefectureDetailPage({
    Key? key,
    required this.prefecture,
    required this.cameras,
  }) : super(key: key);

  String _getVideoIdFromUrl(String url) {
    final regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$prefectureのライブカメラ')),
      body: ListView.builder(
        itemCount: cameras.length,
        itemBuilder: (context, index) {
          String videoId = _getVideoIdFromUrl(cameras[index][2] as String);
          return YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          );
        },
      ),
    );
  }
}
