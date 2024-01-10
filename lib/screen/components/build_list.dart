import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
  const BuildList({
    Key? key,
    this.gridCrossAxisCount = 1,
    required this.data,
  }) : super(key: key);

  final int gridCrossAxisCount;
  //declaration of data but must final and compatible with const
  final List<Map<String, String>> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              color: Colors.deepOrangeAccent,
              child: ListTile(
                leading: Text('${data.length - index}.'),
                title: Text('${data[index]}.'),
              ),
            ),
            const Divider(
              color: Colors.blue,
              height: 3,
            ),
          ],
        );
      },
    );
  }
}
