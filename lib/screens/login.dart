import 'package:flutter/material.dart';
import 'package:greengen/screens/img_upload_scrn.dart';
import 'package:greengen/widgets/container_button.dart';
import 'package:greengen/widgets/input_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.white,
                child: Column(
                  children: [
                    // Text("Portale Greengen",style: Theme.of(context).textTheme.titleMedium,),
                    const Text("Portale Greengen",
                        style: TextStyle(
                          fontSize: 18.0,
                          // fontFamily: "Poppins",
                          color: Color(0XFF076D32),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    inputField(
                        context: context,
                        hintText: "pasquale.greengen@gmail.com",
                        controller: emailController),
                    const SizedBox(
                      height: 15,
                    ),
                    inputField(
                        context: context,
                        hintText: "*******",
                        controller: passwordController,
                        obscureText: true),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: containerButton(
                          context: context,
                          text: "Accedi",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ImageUploadScreen()),
                            );
                          }),
                    ),
                    // TextButton(onPressed: (){}, child: Text(data))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
