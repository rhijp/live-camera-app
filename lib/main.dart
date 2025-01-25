import 'package:flutter/material.dart';
import 'live_camera_page.dart';
import 'prefecture_list_page.dart';

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
    const LiveCameraPage(),
    const PrefectureListPage(),
  ];

  final List<String> _titles = ['ライブマップ','ライブマップ'];

  void _onMenuItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      body: Row(
        children: [
          _buildSideMenu(),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildSideMenu() {
    return Container(
      width: 80,
      color: Colors.black,
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () => _onMenuItemTapped(0),
          ),
          const SizedBox(height: 16),
          IconButton(
            icon: const Icon(Icons.map, color: Colors.white),
            onPressed: () => _onMenuItemTapped(1),
          ),
        ],
      ),
    );
  }
}
