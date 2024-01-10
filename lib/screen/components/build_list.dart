import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
  const BuildList({
    Key? key,
    this.gridCrossAxisCount = 1,
    required this.data,
  }) : super(key: key);

  final int gridCrossAxisCount;
  //declaration of data but must final and compatible with const
  final List<String> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //how to get index value for this itemBuilder
      itemCount: data.length,
      itemBuilder: (context, index) => GridView.count(
        crossAxisCount: gridCrossAxisCount,
        children: [
          //creating childern based on gridviewcrossaxiscount but stil using listview builder
          Card(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(child: Text('Item $index')),
          )
        ],
      ),
    );
  }
}
