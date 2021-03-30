import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
import 'package:tic_tac_toe/game_button.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GameButton> buttonList;
  var player1;
  var player2;
  var activeplayer;

  @override
  void initState() {
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    activeplayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9)
    ];
    return gameButtons;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activeplayer == 1) {
        gb.text = 'x';
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = '0';
        gb.bg = Colors.blue;
        activeplayer = 1;
        player2.add(gb.id);
      }

      gb.enabled = false;
      int winner = checkWinner();

      if (winner == -1) {
        if (buttonList.every((p) => p.text != '')) {
          showDialog(
              context: context,
              builder: (_) => CustomDialog('Game Tied',
                  'Press the Reset button to start again', resetGame));
        } // else {
        // activeplayer == 2 ? autoPlay() : null;   //for autoplay bot
        //}
      }
    });
  }

  void autoPlay() {
    var emptyCells = List();
    var list = List.generate(9, (i) => i + 1);
    for (var cellId in list) {
      if (!(player1.contains(cellId) || player2.contains(cellId))) {
        emptyCells.add(cellId);
      }
    }
    var r = Random();
    var randomIndex = r.nextInt(emptyCells.length - 1);
    var cellId = emptyCells[randomIndex];
    int i = buttonList.indexWhere((p) => p.id == cellId);
    playGame(buttonList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3))
      winner = 1;
    if (player2.contains(1) && player2.contains(2) && player2.contains(3))
      winner = 2;
    if (player1.contains(4) && player1.contains(5) && player1.contains(6))
      winner = 1;
    if (player2.contains(4) && player2.contains(5) && player2.contains(6))
      winner = 2;
    if (player1.contains(7) && player1.contains(8) && player1.contains(9))
      winner = 1;
    if (player2.contains(7) && player2.contains(8) && player2.contains(9))
      winner = 2;
    if (player1.contains(1) && player1.contains(4) && player1.contains(7))
      winner = 1;
    if (player2.contains(1) && player2.contains(4) && player2.contains(7))
      winner = 2;
    if (player1.contains(2) && player1.contains(5) && player1.contains(8))
      winner = 1;
    if (player2.contains(2) && player2.contains(5) && player2.contains(8))
      winner = 2;
    if (player1.contains(6) && player1.contains(3) && player1.contains(9))
      winner = 1;
    if (player2.contains(6) && player2.contains(3) && player2.contains(9))
      winner = 2;
    if (player1.contains(5) && player1.contains(3) && player1.contains(7))
      winner = 1;
    if (player2.contains(5) && player2.contains(3) && player2.contains(7))
      winner = 2;
    if (player1.contains(1) && player1.contains(5) && player1.contains(9))
      winner = 1;
    if (player2.contains(1) && player2.contains(5) && player2.contains(9))
      winner = 2;

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog("Player 1 Won",
                "Press the Reset button to start again", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialog("Player 2 Won",
                "Press the Reset button to start again", resetGame));
      }
    }
    return winner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9),
                itemBuilder: (context, i) => SizedBox(
                  width: 100,
                  height: 100,
                  child: RaisedButton(
                    padding: EdgeInsets.all(8),
                    onPressed: buttonList[i].enabled
                        ? () => playGame(buttonList[i])
                        : null,
                    child: Text(
                      buttonList[i].text,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: buttonList[i].bg,
                    disabledColor: buttonList[i].bg,
                  ),
                ),
              ),
            ),
            Container(
               padding: EdgeInsets.fromLTRB(70, 0, 0, 120),
              child: Text(
                "Player $activeplayer's Turn",
                style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            RaisedButton(
              color: Colors.indigo[600],
              padding: EdgeInsets.all(20),
              onPressed: resetGame,
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            )
          ],
        ));
  }
}
