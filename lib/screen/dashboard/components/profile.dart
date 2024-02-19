import 'package:flutter/material.dart';

class Profile extends StatelessWidget{
  const Profile({
    Key? key,
    required this.name,
    this.kelas,
    required this.image,
    this.nis,
  }): super(key: key);

  final String name;
  final String? kelas;
  final String image;
  final String? nis;

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
                    height: 140,
                    width: 110,
                  child: image == "unknown" ? Text(image) :Image.network("http://bersekolah.web.id:8002/files/foto/$image", fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(name),
                if (kelas != null) ...[const SizedBox(height: 10), Text("Kelas - $kelas")],
                if (nis != null) ...[const SizedBox(height: 10), Text("$nis")],
              ],
            )
          ],
        ),
      ),
    );
  }
}