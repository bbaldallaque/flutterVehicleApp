import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;

  String _password = '';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;
  bool _passwordShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _showLogo(),
          SizedBox(height: 20),
          _showEmail(),
          _showPassword(),
          _showRememberme(),
          _showButtons(),
        ],
      )),
    );
  }

  Widget _showLogo() {
    return Image(
      image: AssetImage('assets/vehicles_logo.png'),
      width: 300,
    );
  }

  Widget _showEmail() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Ingresa tu Email...',
          labelText: 'Email',
          errorText: _emailShowError ? _emailError : null,
          prefixIcon: Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _showPassword() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: !_passwordShow,
        decoration: InputDecoration(
          hintText: 'Ingresa tu contraseña...',
          labelText: 'contraseña',
          errorText: _passwordShowError ? _passwordError : null,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: _passwordShow
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordShow = !_passwordShow;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _showRememberme() {
    return CheckboxListTile(
      title: Text('Recuerdame'),
      value: _rememberme,
      onChanged: (value) {
        setState(() {
          _rememberme = value!;
        });
      },
    );
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: Text('Iniciar Sección'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color(0xFF5DA3FA);
                }),
              ),
              onPressed: () => _login(),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              child: Text('Nuevo usuario'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color(0xFF5DA3FA);
                }),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    if (!_validateFields()) {
      return;
    }
  }

  bool _validateFields() {
    bool hasError = false;

    if (_email.isEmpty) {
      hasError = true;
      _emailShowError = true;
      _emailError = 'Debes de ingresar tu email.';
    } else if (!EmailValidator.validate(_email)) {
      hasError = true;
      _emailShowError = true;
      _emailError = 'Debes de ingresar un email valido.';
    } else {
      _emailShowError = false;
    }

    if (_password.isEmpty) {
      hasError = true;
      _passwordShowError = true;
      _passwordError = 'Debes de ingresar tu contraseña.';
    } else if (_password.length < 6) {
      hasError = true;
      _passwordShowError = true;
      _passwordError =
          'Debes de ingresar una contraseña de al menos 6 caracteres.';
    } else {
      _passwordShowError = false;
    }

    setState(() {});
    return hasError;
  }
}
