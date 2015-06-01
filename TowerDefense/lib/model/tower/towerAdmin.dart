library tower;
import "../level/levelAdmin.dart";

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