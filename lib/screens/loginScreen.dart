// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:vivatech_assignment/common_widgets/commonWidgs.dart';
import 'package:vivatech_assignment/screens/homeScreen.dart';
import 'package:vivatech_assignment/screens/registerScreen.dart';

class LoginScreen extends StatefulWidget {
  String? name;
  String? email;
  String? password;
   LoginScreen({
    Key? key,
    this.name,
    this.email,
    this.password,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Login Page'),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: setWidth(20, context)),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 14),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54))),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              labelText: "Email",
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                              labelText: "Password",
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: setWidth(16.0, context)),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: setWidth(12.0, context)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Log In",
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  if (widget.name != null &&
                                      widget.email != null &&
                                      widget.password != null) {
                                    if (widget.name == _nameController.text &&
                                        widget.email == _emailController.text &&
                                        widget.password ==
                                            _passwordController.text) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              HomeScreen(name: _nameController.text,),
                                        ),
                                      );
                                    }else{
                                       var snackBar = const SnackBar(
                                          content: Text(
                                              'You should not leave any field empty or check your credentials!!'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }

                                    
                                  } else {
                                    var snackBar =
                                       const SnackBar(content: Text('Registration is not done yet!!'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: setWidth(16.0, context)),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: setWidth(12.0, context)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Sign Up",
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                 
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
