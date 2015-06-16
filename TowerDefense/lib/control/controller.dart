library control;

import '../model/game/game.dart';
import "../view/view.dart";

import "dart:html";
import "dart:async";

// TODO: Problem, ob Eingaben während der Wellen vom Nutzer aus möglich sind
// oder nicht
class Controller {
  View view;
  Game game;
  bool boolean;
  int towerDescription;
  Field towerField;
  String field;
  var setTower;
  var ct, at, lt, ft;
  Controller(String levels) {
    //Initializing the Game
    game = new Game(levels);
    view = new View(game.getRow(), game.getCol());
    game.setView(view);
    view.start.onClick.listen((ev) {
      /* TODO: Check for following characters only? a-zA-Z0-9 */
      game.setPlayer(view.nameInput.value);
      view.createBoard(game.getRow(), game.getCol());
      view.start.hidden = true;
      view.nameLabel.innerHtml = "Hello " +
          view.nameInput.value +
          ", you've got " +
          game.player.getHighscore().toString() +
          " Points";
      view.nameInput.hidden = true;
      view.createHighScoreTable();
      view.menuContainer.hidden = false;

      //Start the Game
      game.startGame();
      game.runGame();
    });
    buyListener();
    sellListener();
    upgradeListener();
  }
  void upgradeListener() {
    view.upgrade.onClick.listen((ev) {
      boolean = true;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            if (boolean) {
              print("Feld " +
                  view.board.children.elementAt(i).children.elementAt(j).text +
                  " wurde angeklickt");
              boolean = false;
            }
          });
        }
      }
    });
  }
  void sellListener() {
    view.sell.onClick.listen((ev) {
      boolean = true;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            if (boolean) {
              print("Feld " +
                  view.board.children.elementAt(i).children.elementAt(j).text +
                  " wurde angeklickt");
              boolean = false;
            }
          });
        }
      }
    });
  }
  void buyListener() {
    view.buy.onClick.listen((ev) {
      view.buy.hidden = true;
      view.buyMenu.hidden = false;
      view.arrowTower.hidden = false;
      view.canonTower.hidden = false;
      view.lightningTower.hidden = false;
      view.fireTower.hidden = false;
      view.sell.hidden = true;
      view.upgrade.hidden = true;
      view.cancel.hidden = false;
      boolean = true;

      view.cancel.onClick.listen((ev) {
        view.buyMenu.hidden = true;
        view.cancel.hidden = true;
        view.sell.hidden = false;
        view.upgrade.hidden = false;
        view.buy.hidden = false;
      });
    });
    ct = view.canonTower.onClick.listen((ev) => setTowerImg(1));
    // hier muss abgefangen werden, wenn der Spieler zu wenig Geld
    // für einen TowerBuy hat

    //TODO: Message, dass der Spieler nicht genügend Geld hat

    at = view.arrowTower.onClick.listen((ev) => setTowerImg(2));

    ft = view.fireTower.onClick.listen((ev) => setTowerImg(3));

    lt = view.lightningTower.onClick.listen((ev) => setTowerImg(4));
  }
  Field lookUpField(String field) {
    game.board.keys.forEach((f) {
      if (f.getX().toString() == field[0] && f.getY().toString() == field[1]) {
        towerField = f;
        return towerField;
      }
    });
    return towerField;
  }
  void setTowerImg(int towerDescription) {
    if (boolean) {
      boolean = false;
      bool b;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            switch (towerDescription) {
              case 1:
                b = game.tAdmin.buyTower(1, game.player);
                ct.cancel();
                break;
              case 2:
                b = game.tAdmin.buyTower(2, game.player);
                at.cancel();
                break;
              case 3:
                b = game.tAdmin.buyTower(3, game.player);
                ft.cancel();
                break;
              case 4:
                b = game.tAdmin.buyTower(4, game.player);
                lt.cancel();
                break;
              default:
                break;
            }
            if (b) {
              field = view.board.children.elementAt(i).children.elementAt(j).id;
              //print(field);
              view.buyMenu.hidden = true;
              view.sell.hidden = false;
              view.upgrade.hidden = false;
              view.buy.hidden = false;
              view.cancel.hidden = true;

              towerField = lookUpField(field);
              print("x");
              print(game.tAdmin.allTower.last);
              game.tAdmin.setTowerChoords(game.tAdmin.allTower.last, towerField,
                  game.board, game.getRow(), game.getCol());
              view.setTowerImageToTowerField(
                  field, game.images, towerDescription);
              print(game.tAdmin.allTower.length);
              b = false;
            }
          });
        }
      }
    }
  }
}
