library control;

import '../model/game/game.dart';
import "../view/view.dart";

import "dart:html";

class Controller {
  View view;
  Game game;
  Controller(String levels) {
    game = new Game(levels);
    view = new View(game.getRow(), game.getCol());
    game.setView(view);
    view.createMenu();
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
    });
    view.buy.onClick.listen((ev) {
      view.arrowTower.hidden = false;
      view.canonTower.hidden = false;
      view.lighteningTower.hidden = false;
      view.fireTower.hidden = false;
    });
  }
}
