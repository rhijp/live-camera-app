import 'package:flutter/material.dart';
import 'live_camera_page.dart'; // ホーム画面
import 'prefecture_list_page.dart'; // 都道府県一覧画面

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
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const LiveCameraPage(), // ホーム画面
    const PrefectureListPage(), // 都道府県一覧画面
  ];

  final List<String> _titles = ['ホーム', '都道府県一覧'];

  /// メニューバーの項目をタップしたときの処理
  void _onMenuItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // ドロワーを閉じる
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'メニュー',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('ホーム'),
              onTap: () => _onMenuItemTapped(0), // ホーム画面へ移動
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('都道府県一覧'),
              onTap: () => _onMenuItemTapped(1), // 都道府県一覧画面へ移動
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // 現在選択中のページを表示
    );
  }
}
