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
  String _checkmate(String fen){
final chess = ch.Chess.fromFEN(fen);
    if(chess.in_check){
              return ('benet');
            }
            else{
              return ('annu');
            }

}

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
            ch.Chess game = ch.Chess();
           // game.move(move);
            
            //print(ch.Chess().in_check);
           // final chm = ch.Chess().make_move();
            final nextFen = makeMove(_fen, {
              'from': move.from,
              'to': move.to,
              'promotion': 'q',
            });

              
           

            if (nextFen != null) {
              setState(() {
                _fen = nextFen;
              });
              
              final _ckeck = _checkmate(_fen);
              if(_ckeck == 'benet'){
                print('object');
              }else{
                print('jillu');
              }

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
         // onClick:(){}
        ),
      ),
    );
  }
}
