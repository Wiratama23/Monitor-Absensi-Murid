import 'package:flutter/material.dart';

class Profile extends StatelessWidget{
  const Profile({
    Key? key,
    required this.name,
    required this.kelas,
    required this.image,
    required this.nis,
  }): super(key: key);

  final String name;
  final String kelas;
  final String image;
  final String nis;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 2.0,
          left: 16.0,
          right: 16.0
      ),
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(image, fit: BoxFit.fill)
                ),
              ),
            ),
            const SizedBox(width: 40),
            Column(
              children: [
                Text(name),
                SizedBox(height: 10),
                Text("Kelas - $kelas"),
                SizedBox(height: 10),
                Text(nis)
              ],
            )
          ],
        ),
      ),
    );
  }
}