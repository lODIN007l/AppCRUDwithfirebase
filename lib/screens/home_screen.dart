import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoServicesss = Provider.of<ProductsService>(context);
    if (productoServicesss.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(title: Text('productos')),
      body: ListView.builder(
        //genra los items de acuerdo a lo q tenga en la base
        itemCount: productoServicesss.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            //copia del producto para cargarlo en la pantalla de detalles
            productoServicesss.selectedproducto =
                productoServicesss.products[index].CopyP();

            Navigator.pushNamed(context, 'product');
          },
          //CARgar la data dinamicamente
          child: ProdctCard(
            producto: productoServicesss.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
