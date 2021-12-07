import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? imageUrl;

  const ProductImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _decoracionImagen(),
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage(imageUrl)),
        ),
      ),
    );
  }

  BoxDecoration _decoracionImagen() => BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);

//obtener iamgen
  Widget getImage(String? picture) {
    if (picture == null)
      return Image(
        image: AssetImage('assets/no-image.png'),
        fit: BoxFit.cover,
      );

    if (picture.startsWith('http'))
      return FadeInImage(
        image: NetworkImage(this.imageUrl!),
        placeholder: AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.cover,
      );

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
