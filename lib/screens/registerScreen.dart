import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vivatech_assignment/common_widgets/commonWidgs.dart';
import 'package:vivatech_assignment/pushNotifications/pushNotifications.dart';
import 'package:vivatech_assignment/screens/loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _hasNameInputError = false;
  bool _hasEmailInputError = false;
  bool _hasPasswordInputError = false;
  bool _hasConfirmPasswordInputError = false;

  var nameValidation = "";
  var emailValidation = "";
  var passwordValidation = "";
  var confirmPasswordValidation = "";

  bool autoValidate = false;
  bool _isSignUp = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Registration Page'),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: setWidth(20, context)),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                labelText: "Name",
                                errorText:
                                    _hasNameInputError ? nameValidation : null,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                              // validateName(value!);
                            },
                            onChanged: (value) {
                              setState(() {
                                _hasNameInputError = isNameValid(value);
                                nameValidation = validateName(value)!;
                              });
                            },
                            focusNode: _nameFocus,
                            onFieldSubmitted: (value) {
                              _nameFocus.unfocus();
                              FocusScope.of(context).requestFocus(_emailFocus);
                            },
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
                                errorText: _hasEmailInputError
                                    ? emailValidation
                                    : null,
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
                            onChanged: (value) {
                              setState(() {
                                _hasEmailInputError = isEmailValid(value);
                                emailValidation = validateEmail(value)!;
                              });
                            },
                            focusNode: _emailFocus,
                            onFieldSubmitted: (value) {
                              _emailFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
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
                                errorText: _hasPasswordInputError
                                    ? passwordValidation
                                    : null,
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
                            onChanged: (value) {
                              setState(() {
                                _hasPasswordInputError = isPasswordValid(value);
                                passwordValidation = validatePassword(value)!;
                              });
                            },
                            obscureText: true,
                            focusNode: _passwordFocus,
                            onFieldSubmitted: (value) {
                              _passwordFocus.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_confirmPasswordFocus);
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
                                errorText: _hasConfirmPasswordInputError
                                    ? confirmPasswordValidation
                                    : null,
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black54))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm your password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _hasConfirmPasswordInputError =
                                    isConfirmPasswordValid(
                                        value, _passwordController.text);
                                confirmPasswordValidation =
                                    validateConfirmPassword(
                                        value, _passwordController.text)!;
                              });
                            },
                            obscureText: true,
                            focusNode: _confirmPasswordFocus,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Submit",
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                     PushNotificationService.showNotification(
                                          'Registration Successfull!!','Welcome ${_nameController.text}',
                                          '');
                                      print("validate");
                                      setState(() {
                                        _isSignUp = true;
                                      });

                                      // Toast.show("Your account registered successfully", context,
                                      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                    } else {
                                      setState(() {
                                        autoValidate = true;
                                      });
                                    }
                                  }),
                            ),
                          ),
                          Visibility(
                            visible: _isSignUp,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: setWidth(16.0, context)),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: setWidth(12.0, context)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Back to Login",
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              LoginScreen(name: _nameController.text,email: _emailController.text,password: _passwordController.text,),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String validateName(String value) {
    var minimumLength = value.length > 3;
    if (value.isEmpty) {
      return "Please enter name";
    } else if (!minimumLength) {
      return "Please enter valid name";
    } else {
      return '';
    }
  }

  bool isNameValid(String value) {
    var minimumLength = value.length > 3;
    if (value.isEmpty) {
      return true;
    } else if (!minimumLength) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter email";
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Please enter valid email';
    } else {
      return '';
    }
  }

  bool isEmailValid(String value) {
    if (value.isEmpty) {
      return true;
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return true;
    }
    return false;
  }

  bool isPasswordValid(String password) {
    if (password.isEmpty) {
      return true;
    } else if (!checkPasswordValidation(password)) {
      return true;
    }
    return false;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter password";
    } else if (!checkPasswordValidation(value)) {
      return "Please enter valid password";
    } else {
      return '';
    }
  }

  static bool isDigit(String s, int idx) =>
      "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;

  bool checkPasswordValidation(String value) {
    bool isValid = false;
    bool hasUppercase = false;
    bool minLength = false;
    bool hasDigits = false;
    bool hasSpecialCharacters = false;
    var character = '';
    var i = 0;
    RegExp regExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (value.isNotEmpty) {
      minLength = value.length >= 8;

      // Check if valid special characters are present
      hasSpecialCharacters = value.contains(regExp);
      while (i < value.length) {
        character = value.substring(i, i + 1);
        //print(character);

        if (isDigit(character, 0)) {
          hasDigits = true;
        } else {
          if (!character.contains(regExp) &&
              character == character.toUpperCase()) {
            hasUppercase = true;
          }
        }
        i++;
      }
    }
    isValid = hasDigits & hasUppercase & minLength & hasSpecialCharacters;
    return isValid;
  }

  String validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return "Please enter confirm password";
    }
    if (confirmPassword != password) {
      return "Password and confirm password should be same";
    } else {
      return '';
    }
  }

  bool isConfirmPasswordValid(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return true;
    }
    if (confirmPassword != password) {
      return true;
    }
    return false;
  }
}
