import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> matrixBoard = ['', '', '', '', '', '', '', '', ''];
  bool isPlayerOne = true;

  Map playersScore = {
    'X': 0,
    'O': 0,
  };

  static var customFontWhite = GoogleFonts.coiny(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 20,
  );

  String gameStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Player X',
                          style: customFontWhite,
                        ),
                        Text(
                          playersScore['X'].toString(),
                          style: customFontWhite,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Player O',
                          style: customFontWhite,
                        ),
                        Text(
                          playersScore['O'].toString(),
                          style: customFontWhite,
                        ),
                      ],
                    ),
                  ],
                )),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _onTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: MainColor.primaryColor,
                        ),
                        color: MainColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          matrixBoard[index],
                          style: GoogleFonts.coiny(
                            color: MainColor.primaryColor,
                            letterSpacing: 3,
                            fontSize: 64,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    gameStatus,
                    style: customFontWhite,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _resetGame();
                    },
                    child: const Text(
                      'Reset Game',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: MainColor.secondaryColor,
                      onPrimary: MainColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      if (matrixBoard[index] == '') {
        if (isPlayerOne) {
          matrixBoard[index] = 'X';
        } else {
          matrixBoard[index] = 'O';
        }
      }
      isPlayerOne = !isPlayerOne;
      String player = isPlayerOne ? 'X' : 'O';
      gameStatus = 'Player $player\'s turn';
      _checkWinner();
    });
  }

  // Check if there is a winner in tick-tac-toe game
  void _checkWinner() {
    if (matrixBoard[0] == matrixBoard[1] &&
        matrixBoard[0] == matrixBoard[2] &&
        matrixBoard[0] != '') {
      _showWinnerDialog(matrixBoard[0]);
    } else if (matrixBoard[3] == matrixBoard[4] &&
        matrixBoard[3] == matrixBoard[5] &&
        matrixBoard[3] != '') {
      _showWinnerDialog(matrixBoard[3]);
    } else if (matrixBoard[6] == matrixBoard[7] &&
        matrixBoard[6] == matrixBoard[8] &&
        matrixBoard[6] != '') {
      _showWinnerDialog(matrixBoard[6]);
    } else if (matrixBoard[0] == matrixBoard[3] &&
        matrixBoard[0] == matrixBoard[6] &&
        matrixBoard[0] != '') {
      _showWinnerDialog(matrixBoard[0]);
    } else if (matrixBoard[1] == matrixBoard[4] &&
        matrixBoard[1] == matrixBoard[7] &&
        matrixBoard[1] != '') {
      _showWinnerDialog(matrixBoard[1]);
    } else if (matrixBoard[2] == matrixBoard[5] &&
        matrixBoard[2] == matrixBoard[8] &&
        matrixBoard[2] != '') {
      _showWinnerDialog(matrixBoard[2]);
    } else if (matrixBoard[0] == matrixBoard[4] &&
        matrixBoard[0] == matrixBoard[8] &&
        matrixBoard[0] != '') {
      _showWinnerDialog(matrixBoard[0]);
    } else if (matrixBoard[2] == matrixBoard[4] &&
        matrixBoard[2] == matrixBoard[6] &&
        matrixBoard[2] != '') {
      _showWinnerDialog(matrixBoard[2]);
    } else if (matrixBoard[0] != '' &&
        matrixBoard[1] != '' &&
        matrixBoard[2] != '' &&
        matrixBoard[3] != '' &&
        matrixBoard[4] != '' &&
        matrixBoard[5] != '' &&
        matrixBoard[6] != '' &&
        matrixBoard[7] != '' &&
        matrixBoard[8] != '') {
      _showDrawDialog();
    }
  }

  void _resetGame() {
    setState(() {
      matrixBoard = ['', '', '', '', '', '', '', '', ''];
      isPlayerOne = true;
      gameStatus = 'Player X\'s turn';
    });
  }

  void _showWinnerDialog(winner) {
    print('$winner is the winner!');
    _addScore(winner);
    setState(() {
      gameStatus = 'Player $winner is the winner!';
    });
  }

  void _addScore(String winner) {
    if (playersScore[winner] != null) {
      playersScore[winner] += 1;
    }
  }

  void _showDrawDialog() {
    print('Draw!');
    setState(() {
      gameStatus = 'Draw!';
    });
  }
}
