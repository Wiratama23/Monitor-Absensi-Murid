import 'package:flutter/material.dart';

class BuildTile extends StatelessWidget {
  const BuildTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.tealAccent,
      child: Container(
        height: 80,
        child: const Center(
          child: ListTile(
            leading: Icon(Icons.check_box, color: Colors.green),
            trailing: Text("Absent"),
            title: Text("Jadwal"),
            // tileColor: Colors.deepOrangeAccent,
          ),
        ),
      ),
    );
  }
}