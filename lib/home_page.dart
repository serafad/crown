import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart' as cb;
import 'package:chess/chess.dart' as ch;

import 'utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    final size = min(viewport.height, viewport.width);

    return Scaffold(
      appBar: AppBar(
        title: Text("Random Chess"),
      ),
      body: Center(
        child: cb.Chessboard(
          fen: _fen,
          size: size,
          orientation: cb.Color.WHITE,
          onMove: (move) {
            //print(ch.Chess().in_check);
            print(_fen);
            final nextFen = makeMove(_fen, {
              'from': move.from,
              'to': move.to,
              'promotion': 'q',
            });

            if (nextFen != null) {
              setState(() {
                _fen = nextFen;
              });

              Future.delayed(Duration(milliseconds: 300000)).then((_) {
                final nextMove = getRandomMove(_fen);

                if (nextMove != null) {
                  setState(() {
                    _fen = makeMove(_fen, nextMove);
                    
                  });
                }
              });
            }
          },
        ),
      ),
    );
  }
}
