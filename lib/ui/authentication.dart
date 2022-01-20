import 'package:cryto_wallet/net/flutter_fire.dart';
import 'package:cryto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({ Key? key }) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.blueAccent
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailField,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                hintText: 'example@gmail.com',
                hintStyle: TextStyle(
                  color: Colors.white
                )
              )
            ),
            TextFormField(
              controller: passwordField,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                hintText: '.......',
                hintStyle: TextStyle(
                  color: Colors.white
                )
              )
            ),
            const SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await signIn(emailField.text, passwordField.text);
                  if(shouldNavigate ){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeView()));
                  }
                },
                child: Text('Login'),
              ),
            ),
            const SizedBox(height: 10,),
             Container(
              width: MediaQuery.of(context).size.width/2,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldNavigate = await register(emailField.text, passwordField.text);
                  if(shouldNavigate ){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeView()));                  }
                },
                child: Text('Register'),
              ),
            ),
          ],
        )
      ),
    );
  }
}