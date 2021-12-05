import 'package:flutter/material.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productServicio = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProviderr(productServicio.selectedproducto),
      child: _ProdcutScreenBody(productServicio: productServicio),
    );
  }
}

class _ProdcutScreenBody extends StatelessWidget {
  const _ProdcutScreenBody({
    Key? key,
    required this.productServicio,
  }) : super(key: key);

  final ProductsService productServicio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //se soluciono el error de no poder acceder dado q puede volver un null ,situando un ? antes de picture dado ello se maneja el null safety de esa manera
                ProductImage(
                    imageUrl: productServicio.selectedproducto?.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            _ProductForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProviderr>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _bildFormDecoration(),
        child: Form(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: product.name,
              onChanged: (value) => product.name = value,
              validator: (value) {
                if (value == null || value.length < 1) {
                  return 'El nombre es obligatorio';
                }
              },
              decoration: InputDecorationss.logindecoracion(
                  hintText: 'Nombre del producto', labelText: 'Nombre:'),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              initialValue: '${product.price}',
              onChanged: (value) {
                //parsear el precio y validacion incluida
                if (double.tryParse(value) == null) {
                  product.price = 0;
                } else {
                  product.price = double.parse(value);
                }
              },

              //cambiar el tipo de teclado
              keyboardType: TextInputType.number,
              decoration: InputDecorationss.logindecoracion(
                  hintText: '\$150', labelText: 'Precio:'),
            ),
            SizedBox(
              height: 30,
            ),
            SwitchListTile(
              value: product.available,
              onChanged: (value) {},
              title: Text('Disponible'),
              activeColor: Colors.indigo,
            )
          ],
        )),
      ),
    );
  }

  BoxDecoration _bildFormDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
