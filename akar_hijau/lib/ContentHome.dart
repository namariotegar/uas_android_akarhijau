import 'package:flutter/material.dart';

class ContentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:
                Image.asset('assets/banner_atas.png'), // Example banner image
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Posting Terbaru',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          _buildRecentPosts(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement your logic to fetch more posts or navigate to another screen
              },
              child: Text('Other Post'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPosts() {
    // Replace this with actual data fetching logic
    List<Map<String, String>> posts = [
      {
        'title': 'Posting Sampel 1',
        'description': 'Deskripsi posting 1',
        'image': 'assets/banner_akarhijau.png',
      },
      {
        'title': 'Posting Sampel 2',
        'description': 'Deskripsi posting 2',
        'image': 'assets/banner_akarhijau.png',
      },
      {
        'title': 'Posting Sampel 3',
        'description': 'Deskripsi posting 3',
        'image': 'assets/banner_akarhijau.png',
      },
    ];

    return Column(
      children: posts.map((post) => _buildPostItem(post)).toList(),
    );
  }

  Widget _buildPostItem(Map<String, String> post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        child: Column(
          children: [
            Image.asset(post['image']!),
            ListTile(
              title: Text(post['title']!),
              subtitle: Text(post['description']!),
            ),
          ],
        ),
      ),
    );
  }
}
