library tower;
import "../level/levelAdmin.dart";
import "../field.dart";

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