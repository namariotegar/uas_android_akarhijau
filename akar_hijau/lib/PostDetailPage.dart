import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post['posting_title'] ?? 'Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              post['image_url'] != null
                  ? Image.network(post['image_url'])
                  : const Image(
                      image: AssetImage('assets/post_demo.png'),
                    ),
              const SizedBox(height: 16),
              Text(
                post['posting_title'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'By: ${post['author'] ?? 'Unknown'}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Peralatan :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                post['equipment'] ?? 'No equipment listed',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Langkah-langkah :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                post['steps'] ?? 'No steps provided',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
