import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practice/buttons/undo.dart';
import 'package:practice/constant/app_constants.dart';
import 'package:practice/players/player_one.dart';
import 'package:practice/players/player_two.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<int> _grid = [];
  String _activePlayer = "Player One";
  bool _isPlayerOneTruns = true;
  bool isTrue = true;
  bool _gameNotOver = true;
  int _undoVal = -1;
  int _playerPlay = 0;
  bool isLightMode = true;
  @override
  void initState() {
    super.initState();
    _fillList();
  }

  void _fillList() {
    for (int i = 0; i < 10; i++) {
      _grid.add(0);
    }
  }

  void _mark(index) {
    setState(() {
      if (_isPlayerOneTruns && _grid[index] == 0) {
        _grid[index] = 1;
        _gameOver(_activePlayer);
        _activePlayer = "Player Two";
        _playerPlay = 1;
        _isPlayerOneTruns = false;
      } else if (!_isPlayerOneTruns && _grid[index] == 0) {
        _grid[index] = 2;
        _gameOver(_activePlayer);
        _activePlayer = "Player One";
        _playerPlay = 2;
        _isPlayerOneTruns = !_isPlayerOneTruns;
      }

      _undoVal = index;
    });
  }

  _changeMode() {
    setState(() {
      isLightMode = !isLightMode;
    });
  }

  _gameOver(activePlayer) {
    if (_gameIsOver()) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "$activePlayer, won",
              ),
              content: const Text("Do you want to restart"),
              actionsAlignment: MainAxisAlignment.spaceAround,
              backgroundColor: Colors.red,
              contentPadding: const EdgeInsets.only(
                left: 24,
                top: 10,
                bottom: 10,
              ),
              actions: [
                InkWell(
                  onTap: (() {
                    Navigator.pop(context);
                    _startAgain();
                  }),
                  child: const SizedBox(
                    height: 30,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  void _startAgain() {
    setState(() {
      _activePlayer = "Player One";
      _isPlayerOneTruns = true;
      isTrue = true;
      _gameNotOver = true;
      _undoVal = -1;
      _grid.fillRange(0, 9, 0);
    });
  }

  bool _gameIsOver() {
    if (_check()) {
      _gameNotOver = false;
      return true;
    }
    return false;
  }

  void _undo() {
    if (_undoVal == -1) return;
    setState(() {
      _playerPlay = max(_playerPlay, _grid[_undoVal]);
      _grid[_undoVal] = 0;
      _isPlayerOneTruns = (_playerPlay == 1) ? true : false;
      _activePlayer = _playerPlay == 1 ? "Player One" : "Player Two";
    });
  }

  bool _check() {
    bool isSame = false;
    for (int ways = 4; ways > 0 && !isSame; ways--) {
      if (ways == 4) {
        for (int rowNum = 1; rowNum <= 3 && !isSame; rowNum++) {
          if (rowNum == 1) {
            for (int i = 1; i < 3; i++) {
              int val = _grid[0];

              if (_grid[i] != 0 && _grid[i] == val) {
                isSame = true;
              } else {
                isSame = false;
                break;
              }
            }
          } else if (rowNum == 2) {
            for (int i = 4; i < 6; i++) {
              int val = _grid[3];

              if (_grid[i] != 0 && _grid[i] == val) {
                isSame = true;
              } else {
                isSame = false;
                break;
              }
            }
          } else if (rowNum == 3) {
            for (int i = 7; i < 6; i++) {
              int val = _grid[6];

              if (_grid[i] != 0 && _grid[i] == val) {
                isSame = true;
              } else {
                isSame = false;
                break;
              }
            }
          }
        }
      } else if (ways == 3) {
        for (int colNum = 1; colNum <= 3 && !isSame; colNum++) {
          if (colNum == 1) {
            for (int i = 3; i <= 6; i += 3) {
              int val = _grid[0];

              if (_grid[i] != 0 && _grid[i] == val) {
                isSame = true;
              } else {
                isSame = false;
                break;
              }
            }
          } else if (colNum == 2) {
            for (int i = 4; i <= 7; i += 3) {
              int val = _grid[1];

              if (_grid[i] != 0 && _grid[i] == val) {
                isSame = true;
              } else {
                isSame = false;
                break;
              }
            }
          } else if (colNum == 3) {
            for (int i = 5; i <= 9; i += 3) {
              int val = _grid[2];

              if (_grid[i] != 0 && _grid[i] == val) {
                isSame = true;
              } else {
                isSame = false;
                break;
              }
            }
          }
        }
      } else if (ways == 2) {
        for (int i = 4; i <= 6; i += 2) {
          int val = _grid[2];

          if (_grid[i] != 0 && _grid[i] == val) {
            isSame = true;
          } else {
            isSame = false;
            break;
          }
        }
      } else if (ways == 1) {
        for (int i = 4; i <= 8; i += 4) {
          int val = _grid[0];

          if (_grid[i] != 0 && _grid[i] == val) {
            isSame = true;
          } else {
            isSame = false;
            break;
          }
        }
      }
    }
    return isSame;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _changeMode();
            },
            icon: isLightMode
                ? Icon(
                    Icons.dark_mode,
                    color: isLightMode ? Colors.black : Colors.white,
                  )
                : Icon(
                    Icons.light_mode,
                    color: isLightMode ? Colors.black : Colors.white,
                  ),
          ),
        ],
      ),
      backgroundColor: isLightMode ? lightPrimary : darkPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: Visibility(
                visible: _gameNotOver,
                child: Text(
                  _activePlayer,
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 44),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, index) {
                if (_grid[index] == 0) {
                  return GestureDetector(
                    onTap: () {
                      _mark(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isLightMode ? lightPrimary : darkPrimary,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(-3, -3),
                            color: isLightMode ? lightTopShadow : darkTopShadow,
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            offset: const Offset(3, 3),
                            color: isLightMode
                                ? lightBottomShadow
                                : darkBottomShadow,
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (_grid[index] == 1) {
                  return GestureDetector(
                    onTap: () {
                      _mark(index);
                    },
                    child: PlayerOne(
                      isLightMode: isLightMode,
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      _mark(index);
                    },
                    child: PlayerTwo(
                      isLightMode: isLightMode,
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.red,
                  focusColor: Colors.red,
                  onTap: () {
                    _undo();
                  },
                  child: Undo(
                    isLightMode: isLightMode,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
