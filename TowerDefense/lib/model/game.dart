import "tower/towerAdmin.dart";
import "level/levelAdmin.dart";
import 'package:html5lib/parser.dart';

class game{
  towerAdmin tAdmin;
  levelAdmin lAdmin;
  var levels;
  Map<String, String> board;
  final row = 22;
  final col = 22;
  
  game(){
    levels = parse(level.xml);
    tAdmin = new towerAdmin();
    lAdmin = new levelAdmin(levels);
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