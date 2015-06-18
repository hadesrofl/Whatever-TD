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
      bool b = true;
      var tmp;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            if (b) {
              print("Feld " +
                  view.board.children.elementAt(i).children.elementAt(j).text +
                  " wurde angeklickt");
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  tmp = tower;
                  print(tmp.name);
                  switch (tmp.name) {
                    case "Canon Tower":
                      view.upgradeImage(
                          id, game.images, 1, tmp.getUpgradeLevel());
                      break;
                    case "Arrow Tower":
                      view.upgradeImage(
                          id, game.images, 2, tower.getUpgradeLevel());
                      break;
                    case "Fire Tower":
                      view.upgradeImage(
                          id, game.images, 3, tower.getUpgradeLevel());
                      break;
                    case "Lightning Tower":
                      view.upgradeImage(
                          id, game.images, 4, tower.getUpgradeLevel());
                      break;
                    default:
                      break;
                  }
                  game.tAdmin.upgradeTower(
                      tmp, game.player, game.board, game.row, game.col);
                }
              });
              b = false;
            }
          });
        }
      }
    });
  }
  void sellListener() {
    view.sell.onClick.listen((ev) {
      bool check = true;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            if (check) {
              var tmp;
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  view.deleteImage(id, game.images);
                  tmp = tower;
                }
              });
              if (tmp != null) game.tAdmin.sellTower(tmp, game.player);
              check = false;
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
                b = game.tAdmin.buyTower(towerDescription, game.player);
                break;
              case 2:
                b = game.tAdmin.buyTower(towerDescription, game.player);
                break;
              case 3:
                b = game.tAdmin.buyTower(towerDescription, game.player);
                break;
              case 4:
                b = game.tAdmin.buyTower(towerDescription, game.player);
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
              towerDescription = 0; // DONE: hier lokale Variable auf 0 setzen
            }
          });
        }
      }
    }
  }
}
