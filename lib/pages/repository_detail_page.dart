import 'package:flutter/material.dart';

class RepositoryDetailPage extends StatelessWidget {
  const RepositoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Detail'),
      ),
      body: const Center(
        child: Text('Repository Detail Page'),
      ),
    );
  }
}
