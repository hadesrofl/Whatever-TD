library control;

import '../model/game/game.dart';
import "../view/view.dart";

// TODO: Problem, ob Eingaben während der Wellen vom Nutzer aus möglich sind
// oder nicht
class Controller {
  View view;
  Game game;
  bool boolean;
  Field towerField;
  String field;
  var setTower;
  var x;
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
      view.errorDiv2.hidden = true;
      view.errorDiv.hidden = true;

      //Start the Game
      game.startGame();
      game.runGame();
    });
    buyListener();
    sellListener();
    upgradeListener();

    view.cancel.onClick.listen((ev) {
      view.buyMenu.hidden = true;
      view.cancel.hidden = true;
      view.sell.hidden = false;
      view.upgrade.hidden = false;
      view.buy.hidden = false;
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
    });
  }
  void upgradeListener() {
    view.upgrade.onClick.listen((ev) {
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
      bool enoughMoney;
      bool b = true;
      var tmp;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            if (b) {
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  tmp = tower;
                  enoughMoney = game.tAdmin.upgradeTower(
                      tmp, game.player, game.board, game.row, game.col);
                  if (enoughMoney) {
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
                  } else {
                    view.errorDiv2.hidden = false;
                    print("Error upgrade");
                  }
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
    x = view.sell.onClick.listen((ev) {
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
      view.buy.hidden = true;
      view.upgrade.hidden = true;
      view.sell.hidden = true;
      bool check = true;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            if (check) {
              var tmp = null;
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
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
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
    });
    var x = view.canonTower.onClick.listen((ev) => setTowerImg(1));
    var y = view.arrowTower.onClick.listen((ev) => setTowerImg(2));
    var z = view.fireTower.onClick.listen((ev) => setTowerImg(3));
    var a = view.lightningTower.onClick.listen((ev) => setTowerImg(4));
  }

  void setTowerImg(int towerDescription) {
    if (boolean) {
      view.buyMenu.hidden = true;
      boolean = false;
      Field field;
      bool enough;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          view.board.children.elementAt(i).children.elementAt(j).onClick
              .listen((ev) {
            String f = j.toString() + i.toString();
            field = lookUpField(f);
            switch (towerDescription) {
              case 1:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              case 2:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              case 3:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              case 4:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              default:
                break;
            }
            if (enough) {
              view.sell.hidden = false;
              view.upgrade.hidden = false;
              view.buy.hidden = false;
              view.cancel.hidden = true;
              view.setTowerImageToTowerField(f, game.images, towerDescription);
            } else {
              if (towerDescription != 0) {
                view.errorDiv.hidden = false;
              }
            }
            towerDescription = 0;
          });
        }
      }
    }
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
}
