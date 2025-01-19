import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      home: const LiveCameraPage(),
    );
  }
}

class LiveCameraPage extends StatefulWidget {
  const LiveCameraPage({Key? key}) : super(key: key);

  @override
  State<LiveCameraPage> createState() => _LiveCameraPageState();
}

class _LiveCameraPageState extends State<LiveCameraPage> {
  List<List<dynamic>> _cameraData = [];
  List<String> _categories = [];
  int _currentCategoryIndex = 0;
  late PageController _verticalController;
  double _currentPage = 0;
  final Map<String, WebViewController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _verticalController = PageController(viewportFraction: 0.75);
    _verticalController.addListener(_onVerticalScroll);
    _loadCameraData();
  }

  @override
  void dispose() {
    _verticalController.dispose();
    super.dispose();
  }

  void _onVerticalScroll() {
    setState(() {
      _currentPage = _verticalController.page ?? 0;
    });
  }

  Future<void> _loadCameraData() async {
    final rawData = await rootBundle.loadString('assets/japan-livecamera_data.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    
    listData = listData.sublist(1);
    
    Set<String> categorySet = {};
    for (var row in listData) {
      categorySet.add(row[3] as String);
    }
    
    setState(() {
      _cameraData = listData;
      _categories = categorySet.toList();
    });
  }

  String _getVideoIdFromUrl(String url) {
    final regExp = RegExp(
      r'(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})');
    final match = regExp.firstMatch(url);
    return (match?.group(1) ?? '');
  }

  String _getEmbedUrl(String videoId) {
  return 'https://www.youtube.com/embed/$videoId?autoplay=0&rel=0&modestbranding=1&enablejsapi=1';
}


  Widget _buildVideoPlayer(String videoUrl, double scale) {
    final videoId = _getVideoIdFromUrl(videoUrl);
    if (videoId.isEmpty) {
      return const Center(
        child: Text('無効なURLです。動画を表示できません。'),
      );
    }
    final String embedUrl = _getEmbedUrl(videoId);

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(embedUrl));

    _controllers[videoId] = controller;

    return Transform.scale(
      scale: scale,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }

  List<List<dynamic>> _getVideosForCategory(String category) {
    return _cameraData.where((row) => row[3] == category).toList();
  }

  Widget _buildVideoItem(List<dynamic> videoData, int index, double currentPage) {
    final double distanceFromCenter = (index - currentPage).abs();
    final double scale = 1.0 - (distanceFromCenter * 0.2).clamp(0.0, 0.4);
    final double opacity = 1.0 - (distanceFromCenter * 0.3).clamp(0.0, 0.7);

    return Opacity(
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: _buildVideoPlayer(
                videoData[2] as String,
                scale,
              ),
            ),
            if (distanceFromCenter < 0.5) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      videoData[1] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'カテゴリ: ${videoData[3]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraData.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('ライブマップ')),
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            _currentCategoryIndex = index;
            _verticalController.jumpToPage(0);
          });
        },
        itemCount: _categories.length,
        itemBuilder: (context, categoryIndex) {
          final categoryVideos = _getVideosForCategory(_categories[categoryIndex]);
          
          return PageView.builder(
            controller: _verticalController,
            scrollDirection: Axis.vertical,
            itemCount: categoryVideos.length,
            itemBuilder: (context, videoIndex) {
              return _buildVideoItem(
                categoryVideos[videoIndex],
                videoIndex,
                _currentPage,
              );
            },
          );
        },
      ),
    );
  }
}