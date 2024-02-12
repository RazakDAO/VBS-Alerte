import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Chat'),
              background: Image.network(
                'https://example.com/your_background_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const ListTile(
                  title: Text('Chat screen', style: TextStyle(fontSize: 40)),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  title: Text('Item 1'),
                ),
                const ListTile(
                  title: Text('Item 2'),
                ),
                const ListTile(
                  title: Text('Item 3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Chat(),
  ));
}
