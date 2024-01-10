import 'package:flutter/material.dart';

class BuildTile extends StatelessWidget {
  const BuildTile({
    Key? key,
    required this.title,
    this.trailing,
    this.leading,
    this.color,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String? trailing;
  final Widget? leading;
  final Color? color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        height: 80,
        child: Center(
          child: ListTile(
            leading: leading,
            trailing: Text(trailing ?? ""),
            title: Text(title ?? ""),
            subtitle: Text(subtitle ?? ""),
          ),
        ),
      ),
    );
  }
}
