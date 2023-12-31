import 'package:flutter/material.dart';
import 'package:Greengen/apis/api_services.dart';
import 'package:Greengen/widgets/container_button.dart';
import 'package:Greengen/widgets/input_field.dart';

import '../model/user_model.dart';
import 'all_users_scrn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginFunc() async {
    setState(() {
      loading = true;
    });
    if (await UserModel.isConnectedToInternet()) {
      if (_formKey.currentState!.validate()) {
        if (await ApiServices.login(
          email: emailController.text,
          password: passwordController.text,
        )) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AllUsersScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Failed'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Internet Connection'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    ;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  "assets/pictures/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              Container(
                // height: 330,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: Text(
                        "Portale Greengen",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0XFF076D32),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          inputField(
                            context: context,
                            hintText: "pasquale.Greengen@gmail.com",
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          inputField(
                            context: context,
                            hintText: "*******",
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: containerButton(
                          context: context,
                          text: "Accedi",
                          onTap: loginFunc,
                          loading: loading),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Ripristina",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
