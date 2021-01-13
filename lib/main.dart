import 'package:flutter/material.dart';
import 'package:quizzler/Questions.dart';
import 'QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scorekeeper = [];
  /*
  List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];
  List<bool> answers = [false, true, true]; */
  static int question_number = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: getText(question_number)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                if (question_number >= 0 &&
                    question_number < quizBrain.length()) {
                  if (quizBrain.getQuestion(question_number).answer) {
                    scorekeeper.add(Icon(
                      Icons.check,
                      color: Colors.green,
                    ));
                  } else {
                    scorekeeper.add(Icon(
                      Icons.close,
                      color: Colors.red,
                    ));
                  }
                }
                question_number += 1;
                takeDecision(question_number);
                print('question number $question_number');
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (question_number >= 0 &&
                    question_number < quizBrain.length()) {
                  if (!quizBrain.getQuestion(question_number).answer) {
                    scorekeeper.add(Icon(
                      Icons.check,
                      color: Colors.green,
                    ));
                  } else {
                    scorekeeper.add(Icon(
                      Icons.close,
                      color: Colors.red,
                    ));
                  }
                }
                question_number += 1;
                takeDecision(question_number);
                print('question number $question_number');
                //The user picked false.
              },
            ),
          ),
        ),
        Row(children: scorekeeper)
      ],
    );
  }

  Text getText(int question_number) {
    if (question_number == -1) {
      return Text(
        'This is where the question text will go.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
        ),
      );
    } else if (question_number >= 0 && question_number < quizBrain.length()) {
      return Text(
        // 'This is where the question text will go.',
        quizBrain.getQuestion(question_number).Question,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
        ),
      );
    } else {
      return Text(
        'Game Over',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
        ),
      );
    }
  }

  void takeDecision(int number) {
    if (number >= quizBrain.length()) {
      // its time to show alert and if user presses button, we will restart quiz
      Alert(
        context: context,
        type: AlertType.error,
        title: "Finished",
        desc: "You have reached the end of the quiz",
        buttons: [
          DialogButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            //   onPressed: () => Navigator.pop(context),
            onPressed: () {
              //   Navigator.of(context, rootNavigator: true).pop('dialog');
              Navigator.pop(context);
              setState(() {
                scorekeeper.clear();
                question_number = 0;
              });
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      setState(() {
        print("yhan aye");
      });
      // we have to set state again
    }
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
