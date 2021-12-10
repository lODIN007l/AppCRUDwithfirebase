import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productoServicesss = Provider.of<ProductsService>(context);
    final authS = Provider.of<AuthService>(context, listen: false);

    if (productoServicesss.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('productos'),
        leading: IconButton(
          onPressed: () async {
            await authS.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(Icons.login_outlined),
        ),
      ),
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
        onPressed: () {
          productoServicesss.selectedproducto =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
