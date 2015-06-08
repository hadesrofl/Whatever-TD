library control;

import "../model/game.dart";
import "../view/view.dart";

class Controller{
  View view;
  Game game;
  Controller(String levels){
    game = new Game(levels);
    view = new View(game.getRow(), game.getCol());
    game.setView(view);
    view.start.onClick.listen((ev){
      view.nameInput.text;
    });
    }
}