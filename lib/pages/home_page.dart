import 'package:flutter/material.dart';
import 'package:xo_game/components/button.dart';
import 'package:xo_game/components/text_format.dart';
import 'package:xo_game/model/player_model.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _scoreOne = 0;

  int _scoreTwo = 0;

  int _counter = 1;

  List<String> _boardState = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  onBtnCLicked(index) {
    if (_boardState[index].isNotEmpty) {
      return;
    }
    if (_counter.isOdd) {
      _boardState[index] = 'X';
      _scoreOne += 2;
      bool win = winnerChecker('X');
      if (win) {
        _scoreOne += 10;
        resetBoard();
      }
    } else {
      _boardState[index] = 'O';
      _scoreTwo += 2;
      bool win = winnerChecker('O');
      if (win) {
        _scoreTwo += 10;
        resetBoard();
      }
    }

    _counter++;

    setState(() {});
  }

  bool winnerChecker(String symbol) {
    for (int i = 0; i < 9; i += 3) {
      if (symbol == _boardState[i] &&
          symbol == _boardState[i + 1] &&
          symbol == _boardState[i + 2]) {
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (symbol == _boardState[i] &&
          symbol == _boardState[i + 3] &&
          symbol == _boardState[i + 6]) {
        return true;
      }
    }
    if (symbol == _boardState[0] &&
        symbol == _boardState[4] &&
        symbol == _boardState[8]) {
      return true;
    }
    if (symbol == _boardState[2] &&
        symbol == _boardState[4] &&
        symbol == _boardState[6]) {
      return true;
    }
    return false;
  }

  resetBoard() {
    _boardState = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
    _counter = 0;
  }

  @override
  Widget build(BuildContext context) {
    var playerModel = ModalRoute.of(context)!.settings.arguments as PlayerModel;
    return Scaffold(
      appBar: AppBar(
        title: PoppinsText(
          text: 'XO-Game',
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Color(0xFFa8dadc),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PoppinsText(
                        text: playerModel.playerOneName,
                        fontWeight: FontWeight.w600,
                        fontS: 25,
                        color: Color(0xFF0077b6),
                      ),
                      PoppinsText(
                        text: '$_scoreOne',
                        fontWeight: FontWeight.w600,
                        fontS: 25,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PoppinsText(
                        text: playerModel.playerTwoName,
                        fontWeight: FontWeight.w600,
                        fontS: 25,
                        color: Color(0xFF0077b6),
                      ),
                      PoppinsText(
                        text: '$_scoreTwo',
                        fontWeight: FontWeight.w600,
                        fontS: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: KButton(
                        label: _boardState[0],
                        onPressed: onBtnCLicked,
                        index: 0)),
                Expanded(
                    child: KButton(
                        label: _boardState[1],
                        onPressed: onBtnCLicked,
                        index: 1)),
                Expanded(
                    child: KButton(
                        label: _boardState[2],
                        onPressed: onBtnCLicked,
                        index: 2)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: KButton(
                        label: _boardState[3],
                        onPressed: onBtnCLicked,
                        index: 3)),
                Expanded(
                    child: KButton(
                        label: _boardState[4],
                        onPressed: onBtnCLicked,
                        index: 4)),
                Expanded(
                    child: KButton(
                        label: _boardState[5],
                        onPressed: onBtnCLicked,
                        index: 5)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: KButton(
                        label: _boardState[6],
                        onPressed: onBtnCLicked,
                        index: 6)),
                Expanded(
                    child: KButton(
                        label: _boardState[7],
                        onPressed: onBtnCLicked,
                        index: 7)),
                Expanded(
                    child: KButton(
                        label: _boardState[8],
                        onPressed: onBtnCLicked,
                        index: 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
