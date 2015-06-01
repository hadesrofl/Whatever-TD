library tower;
import "../level/levelAdmin.dart";
<<<<<<< HEAD
=======
import "../field.dart";
>>>>>>> bbcda5c47159945bf532e8552d8d20af7baf3e03

part 'target.dart';
part 'damage.dart';
part 'tower.dart';

class TowerAdmin{
  
  List<Tower> allTower;
  
  TowerAdmin(){
    allTower = new List<Tower>();
  }
  /**
   * 
   */
  List<Target> attack(Map<String, Minion> minions){
    List<Target> targets = new List<Target>();
    return targets;
  }
  /**
   * 
   */
  void buyTower(){
    Tower newTower = new Tower();
    allTower.addAll(newTower);
    
  }
  /**
   * 
   */
  void sellTower(){
    
  }
  /**
   * 
   */
  void selectTower(){
    
  }
  /**
   * 
   */
  void upgradeTower(){
    
  }
  
}