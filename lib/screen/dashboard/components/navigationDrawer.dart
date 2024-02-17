import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget{
  // const NavigationDrawer({Key? key}):super(key:key)

  @override
  Widget build(BuildContext context)=> Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildHeader(context),
        buildMenuItems(context),
      ],
    ),
  );

  Widget buildHeader(BuildContext context)=>Container();

  Widget buildMenuItems(BuildContext context)=>Column(
    children: [
      ListTile(
         leading: const Icon(Icons.home_outlined),
        title: const Text("Home"),
        onTap: (){},
      )
    ],
  );

}