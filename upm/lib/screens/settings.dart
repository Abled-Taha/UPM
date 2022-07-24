import 'package:flutter/material.dart';
import 'package:upm/file_manager.dart';
import 'package:upm/screens/home.dart';
import 'package:upm/screens/login.dart';
import 'package:upm/screens/signup.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Map<String, dynamic> config;
  TextEditingController controllerServerIP = TextEditingController.fromValue(
      const TextEditingValue(text: "initValue"));
  TextEditingController controllerPort = TextEditingController.fromValue(
      const TextEditingValue(text: "initValue"));

  @override
  void initState() {
    super.initState();
    config = {};
    getData().then((value) {
      setState(() {
        controllerServerIP.text = value["serverIP"];
        controllerPort.text = value["port"].toString();
      });
    });
  }

  Future<Map<String, dynamic>> getData() async {
    config = await const FileStorage().readConfig();
    return config;
  }

  @override
  Widget build(BuildContext context) {
    const String name = "Settings";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: controllerServerIP,
                decoration: const InputDecoration(
                  labelText: 'Server IP',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: controllerPort,
                decoration: const InputDecoration(
                  labelText: 'Server Port',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: (() {
                  config = {
                    "serverIP": controllerServerIP.text,
                    "port": controllerPort.text,
                  };
                  const FileStorage().writeConfig(config);
                }),
                child: const Text("Save"),
              )
            ],
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
