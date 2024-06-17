import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form/consts/colors.dart';
import 'package:flutter_form/widgets/submit_button.dart';
import 'package:flutter_form/helpers/validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SignUp Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  bool _submitted = false;
  bool _obscureText = true;

  Color _uppercaseHintColor = CustomColors.primaryText;
  Color _lengthHintColor = CustomColors.primaryText;
  Color _digitHintColor = CustomColors.primaryText;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void submitForm() {
    setState(() {
      _submitted = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Now you can use _email and _password for signup
      print('Email: $_email, Password: $_password');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign Up Successful'),
      ));
    }
  }

  void handlePasswordChange(String value) {
    setState(() {
      _lengthHintColor = value.length >= 8 && value.length < 64
          ? CustomColors.success.withOpacity(0.7)
          : CustomColors.primaryText;
      _uppercaseHintColor = RegExp(r'[A-Z]').hasMatch(value)
          ? CustomColors.success.withOpacity(0.7)
          : CustomColors.primaryText;
      _digitHintColor = RegExp(r'[0-9]').hasMatch(value)
          ? CustomColors.success.withOpacity(0.7)
          : CustomColors.primaryText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 120),
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.none,
              alignment: Alignment(0.0, -0.3),
              image: AssetImage("assets/stars.png")),
          gradient: CustomColors.signinContainerBg,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign up',
                  style: TextStyle(
                    color: CustomColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration('Enter your email'),
                          validator: validateEmail,
                          onSaved: (value) => _email = value!,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: _buildPasswordInputDecoration(),
                          onChanged: handlePasswordChange,
                          validator: validatePassword,
                          onSaved: (value) => _password = value!,
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPasswordHintText(
                                  '8 characters or more (no spaces)',
                                  _lengthHintColor),
                              _buildPasswordHintText(
                                  'Uppercase and lowercase letters',
                                  _uppercaseHintColor),
                              _buildPasswordHintText(
                                  'At least one digit', _digitHintColor),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        SubmitButton(title: 'Sign up', onPressed: submitForm),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      errorStyle: const TextStyle(color: CustomColors.error, fontSize: 14),
      focusedErrorBorder: _errorInputBorder(),
      focusedBorder: _outlineInputBorder(),
      enabledBorder: _outlineInputBorder(),
      errorBorder: _errorInputBorder(),
      fillColor: Colors.white,
      hintText: hintText,
      filled: true,
    );
  }

  InputDecoration _buildPasswordInputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      errorStyle: const TextStyle(color: CustomColors.error, fontSize: 14),
      focusedErrorBorder: _errorInputBorder(),
      enabledBorder: _outlineInputBorder(),
      focusedBorder: _outlineInputBorder(),
      errorBorder: _errorInputBorder(),
      hintText: 'Create your password',
      fillColor: Colors.white,
      filled: true,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: CustomColors.greyBlue,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  OutlineInputBorder _errorInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: CustomColors.error),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  Widget _buildPasswordHintText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: _submitted
            ? (color == CustomColors.primaryText ? CustomColors.error : color)
            : color,
      ),
    );
  }
}
