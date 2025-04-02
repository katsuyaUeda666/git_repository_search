import 'package:flutter/material.dart';

class RepositoryListPage extends StatelessWidget {
  const RepositoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Search'),
      ),
      body: const Center(
        child: Text('Repository List Page'),
      ),
    );
  }
}
