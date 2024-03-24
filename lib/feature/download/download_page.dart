import 'package:flutter/material.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

final List items = [1, 2, 3, 4];
int indexSelected = -1;

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => itemDownload(
              onTap: () {
                setState(() {
                  indexSelected = index;
                });
              },
              isSelected: indexSelected == index,
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: items.length);
  }
}

// ignore: camel_case_types
class itemDownload extends StatelessWidget {
  const itemDownload({super.key, this.isSelected = false, required this.onTap});
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 30,
        width: 200,
        color: isSelected ? Colors.green : Colors.amber,
      ),
    );
  }
}
