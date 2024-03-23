import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final String item = items.removeAt(oldIndex);
              items.insert(newIndex, item);
            });
          },
          children: List.generate(
            items.length,
            (index) => Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.all(10),
              color: index.isOdd ? Colors.green : Colors.red,
              key: Key('$index'),
              child: Text(items[index]),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
