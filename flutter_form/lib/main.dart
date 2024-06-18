import 'package:flutter/material.dart';
import 'package:flutter_form/consts/colors.dart';
import 'package:flutter_form/widgets/custom_input.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  InputState _emailState = InputState.initial;
  InputState _passwordState = InputState.initial;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void submitForm() {
    setState(() {
      _emailState = validateEmail(_emailController.text)
          ? InputState.success
          : InputState.error;
      _passwordState = validatePassword(_passwordController.text)
          ? InputState.success
          : InputState.error;
    });

    if (_emailState == InputState.success &&
        _passwordState == InputState.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign Up successful'),
        ),
      );
    }
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
                        TextInputField.email(
                          controller: _emailController,
                          inputState: _emailState,
                          onChanged: (_) =>
                              setState(() => _emailState = InputState.initial),
                        ),
                        const SizedBox(height: 15.0),
                        TextInputField.password(
                          controller: _passwordController,
                          inputState: _passwordState,
                          onChanged: (_) => setState(
                              () => _passwordState = InputState.initial),
                        ),
                        if (_passwordState == InputState.error)
                          const Padding(
                              padding: EdgeInsets.only(left: 20, top: 15),
                              child: Text(
                                'This password doesn\'t look right.\nPlease try again or reset it now.',
                                style: TextStyle(
                                  color: CustomColors.error,
                                ),
                              )),
                        if (_passwordState != InputState.error)
                          ValueListenableBuilder(
                            valueListenable: _passwordController,
                            builder: (context, value, _) => Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildPasswordHintText(
                                        '8 characters or more (no spaces)',
                                        value.text.length >= 8 &&
                                            !value.text.contains(' '),
                                      ),
                                      _buildPasswordHintText(
                                        'Uppercase and lowercase letters',
                                        value.text.contains(RegExp(r'[A-Z]')) &&
                                            value.text
                                                .contains(RegExp(r'[a-z]')),
                                      ),
                                      _buildPasswordHintText(
                                        'At least one digit',
                                        value.text.contains(RegExp(r'[0-9]')),
                                      ),
                                    ],
                                  )),
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

  Widget _buildPasswordHintText(String text, bool isValid) {
    return Text(
      text,
      style: TextStyle(
        color: isValid
            ? CustomColors.success.withOpacity(0.7)
            : CustomColors.primaryText,
      ),
    );
  }
}
