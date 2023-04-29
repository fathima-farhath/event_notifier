import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenLogin extends StatelessWidget {
   ScreenLogin({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController()
;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username'
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border:  OutlineInputBorder(),
                hintText: 'Password'
              ),
            ),

             const SizedBox(
              height: 20,
            ),

            ElevatedButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.check), 
              label: const Text('Login'))
          ],),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx){
    final _username = _usernameController.text;
    final _password = _passwordController.text;

    // if(_username == _password){
    //   //goto home
    // }else{

    // }
  }
}