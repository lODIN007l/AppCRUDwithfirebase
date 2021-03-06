import 'package:flutter/material.dart';
import 'package:productos_app/providers/loginform_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          CardContainer(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.indigo),
                shape: MaterialStateProperty.all(StadiumBorder())),
            child: Text(
              'Crear una nueva cuenta ',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          //TODO: MANTENER LA REFERENCIA al key
          key: loginForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          //-----------------

          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                //se crea la clase en UI y se hace referencia
                decoration: InputDecorationss.logindecoracion(
                    hintText: 'jhon.doe007@gmail.com',
                    labelText: 'Correo Electronico',
                    iconL: Icons.alternate_email_rounded),
                onChanged: (value) => loginForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo ';
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: true,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                //se crea la clase en UI y se hace referencia
                decoration: InputDecorationss.logindecoracion(
                    hintText: '*****',
                    labelText: 'Contrase??a',
                    iconL: Icons.lock_clock_outlined),
                onChanged: (value) => loginForm.password = value,

                validator: (value) {
                  return (value != null && value.length >= 6)
                      ? null
                      : 'la contrase??a debe ser de 6 carateres ';
                },
              ),
              SizedBox(height: 30),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoadingGet ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: loginForm.isLoadingGet
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          final authS =
                              Provider.of<AuthService>(context, listen: false);
                          if (!loginForm.isValidForm()) return;
                          loginForm.isLoadingSet = false;

                          //TODO VALIDAD SI EL LOGIN ES CORRECTO
                          final String? errormensaje = await authS.loginUser(
                              loginForm.email, loginForm.password);

                          if (errormensaje == null) {
                            //TODO SI ES VALIDO PROCEDEMOS AL A SIGUIENTE PAGINA
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            //TODO MOSTRAR ERROR DE PANTALLA
                            print(errormensaje);
                            NotificationService.ShowSnackBAR(
                                'Usuario o Contrase??a no valido');
                            loginForm.isLoadingSet = true;
                          }
                        })
            ],
          )),
    );
  }
}
