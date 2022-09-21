import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presecstores/logic.dart';

class HomePage extends StatelessWidget {
  static TheController processor = Get.put(TheController());
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(child: Container()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: PhysicalModel(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Colors.grey.withOpacity(0.25),
                color: Colors.white.withOpacity(0.85),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 25.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          focusNode: processor.usernameFocNode,
                          controller: processor.emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textCapitalization: TextCapitalization.words,
                          autofocus: true,
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: "Email",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: "Enter your email",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  color: Colors.lightBlue, width: 2.0),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null) {
                              return "Input is requirred";
                            } else if (value.trim().isEmail == false) {
                              return "Incorrect email";
                            }
                          },
                        ),
                      ),
                      TextField(
                        focusNode: processor.passWordNode,
                        controller: processor.passwordController,
                        obscureText: true,
                        onEditingComplete: () {
                          if (processor.passwordController.value.text.isNotEmpty &&
                              processor.emailController.value.text.isEmail &&
                              processor.emailController.value.text.isNotEmpty) {
                            processor.signIn(
                                processor.emailController.value.text,
                                processor.passwordController.value.text);
                          } else {
                            Get.snackbar("Error", "Invalid input",
                                backgroundColor: Colors.red.withOpacity(0.3));
                          }
                        },
                        obscuringCharacter: "+",
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: "Password",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: "Enter your password...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                                color: Colors.lightBlue, width: 2.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  processor.forgetPassword();
                                },
                                child: const Text("Forget Password??")),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                             if (processor.passwordController.value.text.isNotEmpty &&
                              processor.emailController.value.text.isEmail &&
                              processor.emailController.value.text.isNotEmpty) {
                            processor.signIn(
                                processor.emailController.value.text,
                                processor.passwordController.value.text);
                          } else {
                            Get.snackbar("Error", "Invalid input",
                                backgroundColor: Colors.red.withOpacity(0.3));
                          }},
                          child: const Text("Sign In"))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
