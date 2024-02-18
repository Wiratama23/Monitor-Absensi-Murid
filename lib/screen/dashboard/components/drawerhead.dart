import 'package:flutter/material.dart';
import 'dart:math' as math;

class BuildHeader extends StatelessWidget {
  BuildHeader({
    Key? key,
    required this.nama,
    required this.image
  }): super(key: key);

  String nama;
  String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.3,
        width: MediaQuery
            .of(context)
            .size
            .height * 0.5,
        // padding: EdgeInsets.only(
        //   top: MediaQuery
        //       .of(context)
        //       .padding
        //       .top * 0.1,
        // ),
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.green
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 150,
                  width: 150,
                  child: image == "unknown" ? Text(image) :Image.network("http://bersekolah.web.id:8002/files/foto/$image", fit: BoxFit.fill),
                ),
              ),
              const SizedBox(height: 15),
              Text(nama,style: const TextStyle(fontSize: 15)),
            ]
        ),
      ),
    );
  }
}
