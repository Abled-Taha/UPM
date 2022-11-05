import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:upm/file_manager.dart';
import 'package:upm/screens/home.dart';
import 'package:upm/screens/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Map<String, dynamic> config;

  final TextEditingController controllerEmail =
      TextEditingController.fromValue(const TextEditingValue(text: ""));

  final TextEditingController controllerPassword =
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

  Future login() async {
    try {
      return getData().then((value) async {
        Dio dio = Dio();
        Response response = await dio.get(
            'http://${value["serverIP"]}:${value["port"]}/${value["passwordMain"]}/login/${controllerEmail.text}/${controllerPassword.text}');
        return response;
      });
    } catch (e) {
      showErrorDialog(context, "Connection Error",
          "Please Check Your Internet Connection & Try Again Later");
    }
  }

  @override
  Widget build(BuildContext context) {
    const String name = "Login";
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
                TextField(
                  controller: controllerEmail,
                  decoration: const InputDecoration(
                    labelText: 'Enter Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      Response response = await login();
                      if (response.data == "Done") {
                        showErrorDialog(
                            context, "Done", "You have been Logged In.");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      } else if (response.data == "credentials") {
                        showErrorDialog(context, "Wrong Credentials",
                            "The Credentials You Entered (Username/Password) are incorrect.");
                      }
                    } catch (e) {
                      showErrorDialog(context, "Connection Error",
                          "Please Check Your Internet Connection & Try Again Later");
                    }
                  },
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controllerEmail.text = "test@gmail.com";
                    controllerPassword.text = "test";
                  },
                  child: const Text("Test"),
                )
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
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
