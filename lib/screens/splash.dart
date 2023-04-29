import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:event_notifier/screens/login.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          
            decoration: const BoxDecoration(
              gradient:  LinearGradient(colors: [
                Color.fromARGB(255, 167, 209, 244),
                Color.fromARGB(255, 237, 169, 192),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
              ),
            ),
            
            child: Center(
              child: Column(children:[
               const  SizedBox(height: 40,),
               const  Text('EVENT NOTIFIER',style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Cabin-Bold',
                 
                ),),
                const SizedBox(height: 9,),
                const Text('All event notification at one place',style: TextStyle(
                  fontSize: 17,
                ),),
                const  SizedBox(height: 70,),
      
              Image.asset('assets/images/logo_real.jpg',
              fit: BoxFit.cover,
              height: 200,
              width: 200,
              ),
              const SizedBox(height: 40,),
               ElevatedButton(onPressed: (){}, child: Text('Get Started',),)

              ])
             
            ),
          ),
      ),
      );
      
    
  }
  Future<void> gotoLogin() async{
    await Future.delayed(Duration(milliseconds: 1500));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx)=> ScreenLogin(),
        ),
      );
  }
}