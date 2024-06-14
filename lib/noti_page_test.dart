import 'package:flutter/material.dart';

class NotiPageTest extends StatelessWidget {
  final String title;
  final String body;

  const NotiPageTest({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: $title',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Body: $body', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
