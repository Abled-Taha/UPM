import 'package:flutter/material.dart';
import 'package:upm/screens/home.dart';
import 'package:upm/screens/signup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String name = "Login";
    return Scaffold(
      appBar: AppBar(
        title: const Text(name),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 200),
        child: Center(
          child: Column(
            children: const [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: null,
                child: Text("Login"),
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
