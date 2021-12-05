import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProdctCard extends StatelessWidget {
  final Product producto;

  const ProdctCard({Key? key, required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _BordesCard(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackGroundImage(producto.picture),
            _productDetails(
              titulo: producto.name,
              subtitulo: producto.id!,
            ),
            Positioned(
                top: 0,
                right: 0,
                child: _priceTag(
                  precioP: producto.price,
                )),
            //condicion paramostrar el widget de disponible cuando el mismo esta o no segun los datos de la base
            if (!producto.available)
              Positioned(top: 0, left: 0, child: _NotAvailble())
          ],
        ),
      ),
    );
  }

  BoxDecoration _BordesCard() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _NotAvailble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25), topLeft: Radius.circular(25))),
    );
  }
}

class _priceTag extends StatelessWidget {
  final double precioP;

  const _priceTag({Key? key, required this.precioP}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$precioP',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

class _productDetails extends StatelessWidget {
  final String titulo;
  final String subtitulo;

  const _productDetails(
      {Key? key, required this.titulo, required this.subtitulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 70,
          decoration: _buildBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subtitulo,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackGroundImage extends StatelessWidget {
  final String? url;

  const _BackGroundImage(this.url);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        //manejo de productos sin imagen con ternario
        child: url == null
            ? Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                //TODO FIX EN CASO DE NO TENER IMAGENES
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
