import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:xo_game/components/button.dart';
import 'package:xo_game/components/constants/color.dart';
import 'package:xo_game/components/text_format.dart';
import 'package:xo_game/model/player_model.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';
  const HomePage({super.key});

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

  onBtnCLicked(index, color) {
    if (_boardState[index].isNotEmpty) {
      return;
    }
    if (_counter.isOdd) {
      _boardState[index] = 'X';
      _scoreOne += 2;
      bool win = winnerChecker('X');
      if (win) {
        Alert(
          style: const AlertStyle(
            isOverlayTapDismiss: false,
          ),
          context: context,
          type: AlertType.success,
          title: "Congrats X wins!",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  _scoreOne += 10;
                  resetBoard();
                  Navigator.pop(context);
                });
              },
              width: 120,
              child: const Text(
                "Play again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    } else {
      _boardState[index] = 'O';
      _scoreTwo += 2;
      bool win = winnerChecker('O');
      if (win) {
        Alert(
          style: const AlertStyle(
            isOverlayTapDismiss: false,
          ),
          context: context,
          type: AlertType.success,
          title: "Congrats O wins!",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  _scoreTwo += 10;
                  resetBoard();
                  Navigator.pop(context);
                });
              },
              width: 120,
              child: const Text(
                "Play again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    }

    _counter++;
    if (_counter == 10) {
      Alert(
        style: const AlertStyle(
          isOverlayTapDismiss: false,
        ),
        context: context,
        type: AlertType.warning,
        title: "Nobody wins! retry",
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                resetBoard();
                Navigator.pop(context);
              });
            },
            width: 120,
            child: const Text(
              "Proceed",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }

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
    _counter = 1;
  }

  resetGame() {
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
    _counter = 1;
    _scoreOne = 0;
    _scoreTwo = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var playerModel = ModalRoute.of(context)!.settings.arguments as PlayerModel;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const PoppinsText(
          text: 'XO-Game',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: resetGame,
              child: CircleAvatar(
                backgroundColor: oColor,
                child: Image.asset(
                  'assets/reset.png',
                  width: 40,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: primaryColor,
      ),
      backgroundColor: const Color(0xFFe5e5e5),
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
                        color: const Color(0xFF0077b6),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: xColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: PoppinsText(
                          text: '$_scoreOne',
                          fontWeight: FontWeight.w600,
                          fontS: 25,
                          color: Colors.white,
                        ),
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
                        color: const Color(0xFF0077b6),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: oColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: PoppinsText(
                          text: '$_scoreTwo',
                          fontWeight: FontWeight.w600,
                          fontS: 25,
                          color: Colors.white,
                        ),
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
                  index: 0,
                  color: _boardState[0] == 'X'
                      ? xColor
                      : (_boardState[0] == 'O' ? oColor : primaryColor),
                )),
                Expanded(
                    child: KButton(
                  label: _boardState[1],
                  onPressed: onBtnCLicked,
                  index: 1,
                  color: _boardState[1] == 'X'
                      ? xColor
                      : (_boardState[1] == 'O' ? oColor : primaryColor),
                )),
                Expanded(
                    child: KButton(
                  label: _boardState[2],
                  onPressed: onBtnCLicked,
                  index: 2,
                  color: _boardState[2] == 'X'
                      ? xColor
                      : (_boardState[2] == 'O' ? oColor : primaryColor),
                )),
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
                  index: 3,
                  color: _boardState[3] == 'X'
                      ? xColor
                      : (_boardState[3] == 'O' ? oColor : primaryColor),
                )),
                Expanded(
                    child: KButton(
                  label: _boardState[4],
                  onPressed: onBtnCLicked,
                  index: 4,
                  color: _boardState[4] == 'X'
                      ? xColor
                      : (_boardState[4] == 'O' ? oColor : primaryColor),
                )),
                Expanded(
                    child: KButton(
                  label: _boardState[5],
                  onPressed: onBtnCLicked,
                  index: 5,
                  color: _boardState[5] == 'X'
                      ? xColor
                      : (_boardState[5] == 'O' ? oColor : primaryColor),
                )),
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
                  index: 6,
                  color: _boardState[6] == 'X'
                      ? xColor
                      : (_boardState[6] == 'O' ? oColor : primaryColor),
                )),
                Expanded(
                    child: KButton(
                  label: _boardState[7],
                  onPressed: onBtnCLicked,
                  index: 7,
                  color: _boardState[7] == 'X'
                      ? xColor
                      : (_boardState[7] == 'O' ? oColor : primaryColor),
                )),
                Expanded(
                    child: KButton(
                  label: _boardState[8],
                  onPressed: onBtnCLicked,
                  index: 8,
                  color: _boardState[8] == 'X'
                      ? xColor
                      : (_boardState[8] == 'O' ? oColor : primaryColor),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
