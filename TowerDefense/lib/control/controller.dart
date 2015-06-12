library control;

import '../model/game/game.dart';
import "../view/view.dart";

import "dart:html";

// TODO: Problem, ob Eingaben während der Wellen vom Nutzer aus möglich sind
// oder nicht
class Controller {
  View view;
  Game game;
  bool boolean = false;
  int towerDescription;
  Field towerField;
  String field;
  Controller(String levels) {
    //Initializing the Game
    game = new Game(levels);
    view = new View(game.getRow(), game.getCol());
    game.setView(view);
    view.createMenu(game.images);
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

      view.cancel.onClick.listen((ev) {
        view.buyMenu.hidden = true;
        view.cancel.hidden = true;
        view.sell.hidden = false;
        view.upgrade.hidden = false;
        view.buy.hidden = false;
      });
      //.first.childNodes
      //List tElem;
      // view.buyMenu.childNodes.forEach((children) =>
      //     children.childNodes.forEach((c) => tElem.addAll(c.childNodes)));
      //  print(tElem);

      view.canonTower.onClick.listen((ev) {
        //print(view.buyMenu.children.elementAt(2).children.elementAt(1).text); => ArrowTower
        bool b = game.tAdmin.buyTower(1, game.player);
        // hier muss abgefangen werden, wenn der Spieler zu wenig Geld
        // für einen TowerBuy hat

        boolean = true;
        if (boolean) {
          for (int i = 0; i < game.getCol(); i++) {
            for (int j = 0; j < game.getRow(); j++) {
              view.board.children.elementAt(i).children.elementAt(j).onClick
                  .listen((ev) {
                field =
                    view.board.children.elementAt(i).children.elementAt(j).id;
                //print(field);
                view.buyMenu.hidden = true;
                view.sell.hidden = false;
                view.upgrade.hidden = false;
                view.buy.hidden = false;
                view.cancel.hidden = true;
                boolean = false;
                towerField = lookUpField(field);
                // print(towerField);
                game.tAdmin.setTowerChoords(game.tAdmin.allTower.last,
                    towerField, game.board, game.getRow(), game.getCol());
                view.setCTowerImageToTowerField(field, game.images);
                //Aufruf an View, welches nun den richtigen Tower an die richtige Stelle
                // setzen muss
              });
            }
          }
        }
        //TODO: Message, dass der Spieler nicht genügend Geld hat
      });
      /** view.arrowTower.onClick.listen((ev) {
        //print(view.buyMenu.children.elementAt(2).children.elementAt(1).text); => ArrowTower
        game.tAdmin.buyTower();
        selectFieldForTower();
        // TODO: setImageToField();

      });
      view.fireTower.onClick.listen((ev) {
        //print(view.buyMenu.children.elementAt(2).children.elementAt(1).text); => ArrowTower
        game.tAdmin.buyTower();
        selectFieldForTower();
        // TODO: setImageToField();
      });
      view.lightningTower.onClick.listen((ev) {
        //print(view.buyMenu.children.elementAt(2).children.elementAt(1).text); => ArrowTower
        game.tAdmin.buyTower();
        selectFieldForTower();
        // TODO: setImageToField();
      });*/
    });
  }
  String selectFieldForTower() {}
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
