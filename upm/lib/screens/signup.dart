import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:upm/file_manager.dart';
import 'package:upm/screens/home.dart';
import 'package:upm/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late Map<String, dynamic> config;

  final TextEditingController controllerEmail =
      TextEditingController.fromValue(const TextEditingValue(text: ""));

  final TextEditingController controllerUsername =
      TextEditingController.fromValue(const TextEditingValue(text: ""));

  final TextEditingController controllerPassword =
      TextEditingController.fromValue(const TextEditingValue(text: ""));

  final TextEditingController controllerRePassword =
      TextEditingController.fromValue(const TextEditingValue(text: ""));

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getData() async {
    config = await const FileStorage().readConfig();
    return config;
  }

  showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(
          content,
        ),
      ),
    );
  }

  Future reg() async {
    try {
      return getData().then((value) async {
        Dio dio = Dio();
        Response response = await dio.get(
            'http://${value["serverIP"]}:${value["port"]}/${value["passwordMain"]}/reg/${controllerEmail.text}/${controllerPassword.text}/${controllerUsername.text}');
        return response;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    const String name = "Sign Up";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: controllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email (Only @email, @gmail or @hotmail)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerUsername,
                  decoration: const InputDecoration(
                    labelText: 'Enter Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: controllerRePassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Re-Enter Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!controllerEmail.text.endsWith("@gmail.com") &
                        !controllerEmail.text.endsWith("@gmail.com ") &
                        !controllerEmail.text.endsWith("@email.com") &
                        !controllerEmail.text.endsWith("@email.com ") &
                        !controllerEmail.text.endsWith("@hotmail.com") &
                        !controllerEmail.text.endsWith("@hotmail.com ")) {
                      if (controllerEmail.text.endsWith(" ")) {
                        controllerEmail.text =
                            controllerEmail.text.replaceAll(" ", "");
                      }
                      showErrorDialog(context, 'Unknown Email Address',
                          'Try Changing the Email to one of the Providers we Support.');
                    } else if ((controllerPassword.text !=
                            controllerRePassword.text) |
                        controllerPassword.text.isEmpty) {
                      showErrorDialog(context, 'Passwords Do not Match/Empty',
                          'Please Re-Type your Passwords as they do not Match, or are Empty');
                    } else {
                      try {
                        Response response = await reg();
                        if (response.data == "done") {
                          showErrorDialog(context, "Done",
                              "Your Account has been Created, please Log in");
                        } else if (response.data == "key") {
                          showErrorDialog(
                              context,
                              "Incorrect API Key/Main Server Password",
                              "The API Key (Main Server Password) is Incorrect. Kindly, Ensure the Key.");
                        } else if (response.data == "email") {
                          showErrorDialog(context, "Account Already Exists",
                              "An Account already exists with this Email");
                        } else if (response.data == "username") {
                          showErrorDialog(context, "Account Already Exists",
                              "An Account already exists with this Username");
                        }
                      } catch (e) {
                        showErrorDialog(context, "Network Error",
                            "Please Check Your Internet Connection & try again later");
                      }
                    }
                  },
                  child: const Text("Sign Up"),
                ),
                ElevatedButton(
                    onPressed: () {
                      controllerEmail.text = "test@gmail.com";
                      controllerUsername.text = "test";
                      controllerPassword.text = "test";
                      controllerRePassword.text = "test";
                    },
                    child: const Text("Test"))
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
            ListTile(
              title: const Text('Sign In'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
