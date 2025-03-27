import 'package:flutter/material.dart';

class repositoryDetailPage extends StatelessWidget {
  const repositoryDetailPage({super.key});

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
