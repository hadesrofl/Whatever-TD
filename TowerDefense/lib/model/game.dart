import "tower/towerAdmin.dart";
import "level/levelAdmin.dart";
import "dart:io";

class game{
  TowerAdmin tAdmin;
  LevelAdmin lAdmin;
  File levels;
  Map<String, String> board;
  final row = 22;
  final col = 22;
  
  game(){
    //TODO: Enter concrete FilePath
    levels = new File(Platform.script.toFilePath());;
    tAdmin = new TowerAdmin();
    lAdmin = new LevelAdmin(levels);
    board = new Map<String, String>();
  }
  /**
   * 
   */
  void startGame(){
    
  }
  /**
   * 
   */
  void runGame(){
    
  }
  /**
   * 
   */
  void endOfGame(){
    
  }
  /**
   * 
   */
  void updateView(){
    
  }
  /**
   * 
   */
  void endOfLevel(){
    
  }
  /**
   * 
   */
  void calculateHighScore(){
    
  }
}