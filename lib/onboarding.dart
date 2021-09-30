import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'Views/ButtonWidget.dart';
import 'Views/login_view.dart';

class OnboardingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(0,100,0,30),
        child: Column(
          children: <Widget> [
            Text('ImageApp',style: TextStyle(color: Color.fromARGB(
                240, 90, 59, 2),
                fontFamily: 'Helvetica',
                fontSize: 50
            ),
            ), SizedBox(height: 20),
            // Text('Добро пожаловать!',style: TextStyle(color: Color.fromARGB(
            //     240, 3, 13, 14),
            //     fontFamily: 'Helvetica',
            //     fontSize: 30
            // ),
            // ),
            Text('Добро пожаловать!',style: TextStyle(color: Color.fromARGB(
                240, 3, 13, 14),
                fontFamily: 'Helvetica',
                fontSize: 22
            ),
            ),
            Flexible(child: IntroScreen()) ],
        ),
      ),
    );

  }
}


class IntroScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) => SafeArea(
    child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Делитесь фотографиями',
          body: 'и оценивайте фотографии других',
          image: Image.asset('res/images/onboarding1.gif'),
        ),
        PageViewModel(
          title: 'Удивите всех!',
          body: 'Попробуйте прямо сейчас!',
          // footer: ButtonWidget(
          //   text: 'Start Reading',
          //   onClicked: () => goToHome(context),
          // ),
          image: Image.asset('res/images/onboarding2.gif'),
        ),
      ],
      done: Text('Начать') ,
      onDone: () => goToHome(context),
      next: Icon(Icons.arrow_forward),
      onChange: (index) => print('Page $index selected'),
      globalBackgroundColor: Colors.white,
      animationDuration: 1000,
    ),
  );
}

void goToHome(context) => Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => LoginPage()),
);