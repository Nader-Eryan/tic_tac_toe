import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';
  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void playGame(String activePlayer, int index) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  checkWinner(activePlayer) {
    List<int> playerList =
        activePlayer == 'O' ? Player.playerO : Player.playerX;
    if (playerList.containsAll(0, 1, 2) ||
        playerList.containsAll(3, 4, 5) ||
        playerList.containsAll(6, 7, 8) ||
        playerList.containsAll(0, 3, 6) ||
        playerList.containsAll(1, 4, 7) ||
        playerList.containsAll(2, 5, 8) ||
        playerList.containsAll(0, 4, 8) ||
        playerList.containsAll(2, 4, 6)) {
      return activePlayer;
    }
  }

  autoPlay(activePlayer, index) async {
    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!Player.playerO.contains(i) && !Player.playerX.contains(i)) {
        emptyCells.add(i);
      }
    }
    if (emptyCells.contains(4)) {
      index = 4;
    }
    //attacking 1 H
    else if (Player.playerO.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //attacking 2 H
    else if (Player.playerO.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
    }
    //attacking 3 H
    else if (Player.playerO.containsAll(1, 2) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(4, 5) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsAll(7, 8) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsAll(4, 8) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(4, 6) && emptyCells.contains(2)) {
      index = 2;
    }
    //attacking 4 H
    //attacking 1 V
    else if (Player.playerO.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    }
    //attacking 2 V
    else if (Player.playerO.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    }
    //attacking 3 V
    else if (Player.playerO.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
    }
    //Defense 1 V
    else if (Player.playerX.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    }
    //Defense 2 V
    else if (Player.playerX.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    }
    //Defense 3 V
    else if (Player.playerX.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
    }
    //defense 1
    else if (Player.playerX.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //defense 2
    else if (Player.playerX.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
    }
    //defense 3
    else if (Player.playerX.containsAll(1, 2) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(4, 5) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsAll(7, 8) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(3, 6) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(4, 7) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsAll(5, 8) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsAll(4, 8) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(4, 6) && emptyCells.contains(2)) {
      index = 2;
    }
    //advanced defense 1
    else if (Player.playerX.containsAll(0, 8)) {
      if (emptyCells.contains(1)) {
        index = 1;
      } else if (emptyCells.contains(5)) {
        index = 5;
      } else if (emptyCells.contains(3)) {
        index = 3;
      } else if (emptyCells.contains(7)) {
        index = 7;
      }
    } 
    //advanced defense 2
    else if (Player.playerX.containsAll(2, 6)) {
      if (emptyCells.contains(1)) {
        index = 1;
      } else if (emptyCells.contains(5)) {
        index = 5;
      } else if (emptyCells.contains(3)) {
        index = 3;
      } else if (emptyCells.contains(7)) {
        index = 7;
      }
    } 
     else {
      Random rand = Random();
      int temp = rand.nextInt(emptyCells.length);
      index = emptyCells[temp];
    }

    playGame(activePlayer, index);
  }
}
