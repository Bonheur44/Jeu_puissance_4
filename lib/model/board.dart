import 'box.dart';
import 'player.dart';
import '../general.dart';
import 'package:flutter/material.dart';

class Board {
  late Player p1;
  late Player p2;
  bool p1Turn = true;
  late void Function() refresh;
  final List<List<Box>> boxes = [];
  final List<List<GlobalKey>> widgetsKeys = [];
  late void Function(String msg) showWinDialog;

  Board(int rows, int columns, void Function() refreshFunction, void Function(String msg) winDialog) {
    p1 = Player(pawnColor: const Color.fromRGBO(255, 192, 0, 1), name: "Joueur n°1");
    p2 = Player(pawnColor: const Color.fromRGBO(255, 74, 68, 1), name: "Joueur n°2");
    refresh = refreshFunction;
    showWinDialog = winDialog;
    boxes.clear();
    for (var i = 0; i < columns; i++) {
      List<Box> list = [];
      for (var j = 0; j < rows; j++) {
        list.add(Box(xCoordinate: j, yCoordinate: i));
      }
      boxes.add(list);
    }
    widgetsKeys.clear();

    for (var j = 0; j < columns; j++) {
      List<GlobalKey> list = [];
      for (var i = 0; i < rows; i++) {
        list.add(GlobalKey());
      }
      widgetsKeys.add(list);
    }
  }

  void toggleBox(int i, int j, {bool last = false}) {
    boxes[j][i].bg = p1Turn ? p1.pawnColor : p2.pawnColor;
    refresh();
  }

  void placeAPawn(int j) {
    if (boxes[j][0].bg != unselectedBoxBg) return;
    int i = 0;
    while ((i + 1) < 6 && boxes[j][i + 1].bg == unselectedBoxBg) {
      i++;
    }
    toggleBox(i, j, last: true);
    // for (var i = 0; i < 6; i++) {
    //   if (boxes[j][i].bg == unselectedBoxBg) {
    //     if (i + 1 < 6) {
    //       toggleBox(i, j, last: boxes[j][i + 1].bg != unselectedBoxBg);
    //     } else {
    //       toggleBox(i, j, last: true);
    //     }
    //   }
    // }
    if (p1Turn) {
      p1.pawnsNumber--;
    } else {
      p2.pawnsNumber--;
    }
    if (winHorizontally() || winVertically() || winDiagonally()) {
      showWinDialog(p1Turn ? p1.name : p2.name);
      return;
    }
    p1Turn = !p1Turn;
  }

  bool winVertically() {
    int nbr = 0;
    Color currentColor = p1Turn ? p1.pawnColor : p2.pawnColor;
    for (var j = 0; j < 7; j++) {
      nbr = 0;
      for (var i = 0; i < 6; i++) {
        if (boxes[j][i].bg == currentColor) {
          nbr++;
        } else {
          nbr = 0;
        }
        if (nbr == 4) return true;
      }
    }
    return false;
  }

  bool winHorizontally() {
    int nbr = 0;
    Color currentColor = p1Turn ? p1.pawnColor : p2.pawnColor;
    for (var i = 0; i < 6; i++) {
      nbr = 0;
      for (var j = 0; j < 7; j++) {
        if (boxes[j][i].bg == currentColor) {
          nbr++;
        } else {
          nbr = 0;
        }
        if (nbr == 4) return true;
      }
    }
    return false;
  }

  bool winDiagonally() {
    int nbr = 0, k = 0, l = 0;
    Color currentColor = p1Turn ? p1.pawnColor : p2.pawnColor;
    for (var i = 0; i < 6; i++) {
      nbr = 0;
      for (var j = 0; j < 7; j++) {
        k = i;
        l = j;
        nbr = 0;
        while (k < 6 && l < 7) {
          if (boxes[l][k].bg == currentColor) {
            nbr++;
          } else {
            nbr = 0;
          }
          if (nbr == 4) return true;
          k++;
          l++;
        }
        k = i;
        l = j;
        nbr = 0;
        while (k >= 0 && l < 7) {
          if (boxes[l][k].bg == currentColor) {
            nbr++;
          } else {
            nbr = 0;
          }
          if (nbr == 4) return true;
          k--;
          l++;
        }
      }
    }
    return false;
  }
}
