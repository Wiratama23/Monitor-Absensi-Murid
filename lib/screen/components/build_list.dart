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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Card(
                color: (data[index]['status'] == "Hadir")
                    ? Colors.green
                    : Colors.red,
                child: ListTile(
                  leading: Text("${data[index]['date']}"),
                  title: Text(data[index]['status'] ?? "Default Text"),
                ),
              ),
              const Divider(
                color: Colors.transparent,
                height: 5,
              ),
            ],
          );
        },
      ),
    );
  }
}
