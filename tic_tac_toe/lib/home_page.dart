import 'package:flutter/material.dart';

import 'game_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSwitched = false;
  // int turn = 0;
  String activePlayer = 'X';
  String result = ' ';
  bool gameOver = false;
  Game game = Game();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    buildSwitch(context),
                    buildTurn(),
                    buildGrid(context),
                    buildResult(),
                    BuildRestartButton(),
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildSwitch(context),
                          buildTurn(),
                          buildResult(),
                          BuildRestartButton()
                        ],
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: buildGrid(context)),
                  ],
                ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ElevatedButton BuildRestartButton() {
    return ElevatedButton.icon(
        onPressed: () {
          setState(() {
            // turn = 0;
            activePlayer = 'X';
            result = ' ';
            gameOver = false;
            Player.playerO = [];
            Player.playerX = [];
          });
        },
        icon: const Icon(Icons.replay),
        label: const Text('restart the game!'));
  }

  Text buildResult() {
    return Text(
      (Player.playerO.length + Player.playerX.length == 9 &&
              game.checkWinner(activePlayer == 'X' ? 'O' : 'X') == null)
          ? 'It\'s a Draw'
          : gameOver
              ? 'The winner is $result'
              : ' ',
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  Flexible buildGrid(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
        children: List.generate(
          9,
          (index) => InkWell(
            onTap: gameOver ? null : (() => _onTap(index)),
            borderRadius: BorderRadius.circular(15),
            child: Container(
              // height: mq.size.height * 0.5,
              // width: mq.size.width * 0.5,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  Player.playerX.contains(index)
                      ? 'X'
                      : Player.playerO.contains(index)
                          ? 'O'
                          : ' ',
                  style: TextStyle(
                    fontSize: 50,
                    color: Player.playerX.contains(index)
                        ? Theme.of(context).splashColor
                        : Colors.pink,
                  ), //textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildTurn() {
    return Text(
      gameOver ? 'Game over' : 'It\'s $activePlayer turn'.toUpperCase(),
      style: const TextStyle(fontSize: 30),
    );
  }

  SwitchListTile buildSwitch(BuildContext context) {
    return SwitchListTile.adaptive(
      title: const Text(
        'Turn on/off one player',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      activeColor: Theme.of(context).splashColor,
      value: isSwitched,
      onChanged: (newVal) => setState(() {
        isSwitched = newVal;
      }),
    );
  }

  _onTap(int index) async {
    if (Player.playerO.contains(index) || Player.playerX.contains(index)) {
      return;
    }

    game.playGame(activePlayer, index);
    updateState();
    if (isSwitched && !gameOver) {
      await game.autoPlay(activePlayer, index);
      updateState();
    }
  }

  void updateState() {
    setState(() {
      result = game.checkWinner(activePlayer) ?? ' ';
      if (Player.playerO.length + Player.playerX.length == 9 ||
          game.checkWinner(activePlayer) != null) {
        gameOver = true;
      }
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
    });
  }
}
