import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
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
              title: Text('Chat'),
              background: Image.network(
                'https://example.com/your_background_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text('Chat screen', style: TextStyle(fontSize: 40)),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text('Item 1'),
                ),
                ListTile(
                  title: Text('Item 2'),
                ),
                ListTile(
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
  runApp(MaterialApp(
    home: Chat(),
  ));
}
