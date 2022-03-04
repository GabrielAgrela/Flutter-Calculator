// this calculator was inspited by https://www.geeksforgeeks.org/simple-calculator-app-using-flutter/

import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:function_tree/function_tree.dart';

void main() 
{
  runApp(const Calculator());
}

class Calculator extends StatelessWidget 
{
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return const MaterialApp
    (
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget 
{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{
  String userInput = '';
  String result = '0';

  // Array of buttons
  final List<String> buttons = 
  [
    '+',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    'C',
    '=',
  ];

  @override
  Widget build(BuildContext context) 
  {
    
    return Scaffold
    (
      
      appBar: AppBar
      (
        title: const Text("Calculator"),
      ),
      backgroundColor: const Color.fromARGB(96, 42, 147, 207),
      // column divides the working space, roughly in half, between the calculator "screen" and its buttons
      body: Column
      (
        children: <Widget>
        [
          // Because grid height is fixed, this widget is expanded, this way it occupies all the vertical space left by the grid, no more, no less.
          Expanded
          (
            // column with both user input and result, separeted vertically evenly
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>
              [
                // containter with the operations and user input
                Container
                (
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text
                  (
                    userInput,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                // container with the result of the operations
                Container
                (
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerRight,
                  child: Text
                  (
                    result,
                    style: const TextStyle
                    (
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  ), 
                ) //Result
              ]
            ),
          ),
          // grid is the second half of the column, it's size is always the same
          GridView.builder
          (
            // Padding from all sides excepting top
            padding: const EdgeInsets.fromLTRB(10,0,10,10),
            // I dont want it to be scrollable
            physics: const NeverScrollableScrollPhysics(),
            // I want this grid to mantain its size
            shrinkWrap: true,
            itemCount: buttons.length,
            // type of grid I wanna draw is a fixed 4 column one
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
            (
              crossAxisCount: 4,
            ),
            // build grid with the array of items "buttons"
            itemBuilder: (BuildContext context, int index) 
            {
              // Clear Button
              if (index == 14) 
              {
                return DigitButton
                (
                  buttontapped: () 
                  {
                    setState
                    (
                      () 
                        {
                          userInput = '';
                          result = '0';
                        }
                    );
                  },
                  buttonText: buttons[index],
                  color: Colors.blue[50],
                  textColor: Colors.black,
                );
              }
              // Equal_to Button
              else if (index == 15) 
              {
                return DigitButton
                (
                  buttontapped: 
                  () 
                    {
                      setState
                      (
                        () 
                          {
                            equalPressed();
                          }
                      );
                    },
                  buttonText: buttons[index],
                  color: Colors.orange[700],
                  textColor: Colors.white,
                );
              }

              // other buttons
              else 
              {
                return DigitButton
                (
                  buttontapped:
                  () 
                    {
                      setState
                      (
                        () 
                          {
                            userInput += buttons[index];
                          }
                      );
                    },
                  buttonText: buttons[index],
                  // if button is operator then it's blue, else its white
                  color: isOperator(buttons[index]) ? Colors.blueAccent : Colors.white,
                  textColor: isOperator(buttons[index]) ? Colors.white : Colors.black,
                );
              }
            }),
        ],
      ),
    );
  }

  // if button pressed is an operator return true, else false
  bool isOperator(String x) 
  {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') 
    {
      return true;
    }
     return false;
  }

  // function to calculate the input operation
  void equalPressed() 
  {
    // replace input X's for *'s and interpret and calculate it into an operation, storing as a string
    result = userInput.replaceAll('x', '*').interpret().toInt().toString();  
    
    userInput = result;
  
  }
}
