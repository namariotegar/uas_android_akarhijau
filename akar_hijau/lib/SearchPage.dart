import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PostDetailPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> posts = [];
  List<dynamic> filteredPosts = [];
  bool isLoading = true;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchPosts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _searchPosts);
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.125.48:3001/api/search'));

      if (response.statusCode == 200) {
        setState(() {
          posts = jsonDecode(response.body);
          filteredPosts = posts;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load posts. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred while fetching posts: $e';
      });
    }
  }

  void _searchPosts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPosts = posts.where((post) {
        final title = post['posting_title']?.toLowerCase() ?? '';
        final name = post['author']?.toLowerCase() ?? '';
        final equipment = post['equipment']?.toLowerCase() ?? '';
        final steps = post['steps']?.toLowerCase() ?? '';
        return title.contains(query) ||
            name.contains(query) ||
            equipment.contains(query) ||
            steps.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                fillColor: Color.fromARGB(255, 239, 239, 239),
                filled: true,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    final post = filteredPosts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailPage(post: post),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: post['image_url'] != null
                                      ? NetworkImage(post['image_url'])
                                      : const AssetImage('assets/post_demo.png')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post['posting_title'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      post['author'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    // const SizedBox(height: 8),
                                    // Text(
                                    //   post['equipment'] ?? '',
                                    //   style: const TextStyle(
                                    //     fontSize: 14,
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 8),
                                    // Text(
                                    //   post['steps'] ?? '',
                                    //   style: const TextStyle(
                                    //     fontSize: 14,
                                    //   ),
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 5,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SearchPage(),
  ));
}
