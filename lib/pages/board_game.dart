import '../general.dart';
import '../model/board.dart';
import '../tmp/elegant_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> with TickerProviderStateMixin {
  final int _columns = 7, _rows = 6;
  final _borderColor = const Color.fromRGBO(0, 85, 245, 1);
  late Board _board = Board(_rows, _columns, () => setState(() {}), _showWinDialog);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    double dimension = width / 7.7;

    return Material(
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: Image.asset('img/board_bg.jpg', height: height, width: width).image, fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              color: Colors.black.withOpacity(.2),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _animatedContainer(_board.p1Turn ? _board.p1.pawnColor : Colors.transparent, _board.p1.name),
                          _animatedContainer(_board.p1Turn ? Colors.transparent : _board.p2.pawnColor, _board.p2.name),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    height: ((width / (_columns + 1)) + 6) * _rows + 6,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 110, 241, 1),
                      border: Border.all(color: _borderColor, width: 5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var j = 0; j < _columns; j++)
                          InkWell(
                            onTap: () => _board.placeAPawn(j),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var i = 0; i < _rows; i++)
                                  AnimatedContainer(
                                    key: _board.widgetsKeys[j][i],
                                    duration: Duration.zero,
                                    decoration: BoxDecoration(
                                      color: _board.boxes[j][i].bg,
                                      borderRadius: BorderRadius.circular(1000),
                                      border: Border.all(color: _borderColor, width: 3.5),
                                    ),
                                    width: dimension,
                                    height: dimension,
                                    child: Container(),
                                  )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  Container()
                ],
              ),
            ),
          ),
          Container()
        ],
      ),
    );
  }

  void _showWinDialog(String str) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: AnimatedEmoji(AnimatedEmojis.confettiBall, size: MediaQuery.sizeOf(context).width / 4),
          content: elegantText("Le $str a gagné !"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _board = Board(_rows, _columns, () => setState(() {}), _showWinDialog));
              },
              child: elegantText("Nouvelle partie", color: Colors.white, size: 16),
            )
          ],
        );
      },
    );
  }

  Widget _animatedContainer(Color color, String name) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: elegantText(name, color: Colors.white),
    );
  }
}
