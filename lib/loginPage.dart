import 'package:flutter/material.dart';
import 'package:flutter_app/homePage.dart' show HomePage;
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.favorite, size: 100, color: Colors.pinkAccent),
              const SizedBox(height: 20),
              const Text(
                'Minha mulher que manda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              const SizedBox(height: 40),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Marido (E-mail)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Colors.pinkAccent),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha de obediência',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Colors.pinkAccent),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  context.go( '/home' );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('SIM, SENHORA!'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Esqueceu a senha? (Peça para ela)',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
