import 'package:flutter/material.dart';

import 'sqflite.dart';
import 'shared_preferences.dart';
import 'orm_hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Storage Examples'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Sqflite'),
            Tab(text: 'Shared Preferences'),
            Tab(text: 'ORM Hive'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: SqflitePage(),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SharedPreferencesWidget(),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: OrmHiveWidget(),
          ),
        ],
      ),
    );
  }
}
