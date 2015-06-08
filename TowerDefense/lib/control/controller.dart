library control;

import "../model/game.dart";
import "../view/view.dart";

class Controller{
  View view;
  Game game;
  Controller(){
    game = new Game();
    view = new View(game.getRow(), game.getCol());
    game.setView(view);
    
  }
  void listenOnClick(){
    
  }
  void listenOnChane(){
    
  }
}