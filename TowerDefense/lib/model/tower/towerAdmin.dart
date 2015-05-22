library tower;

import '../level/levelAdmin.dart';

part 'target.dart';
part 'damage.dart';
part 'tower.dart';

class towerAdmin{
  
  List<tower> allTower;
  
  towerAdmin(){
    allTower = new List<tower>();
  }
  /**
   * 
   */
  List<target> attack(Map<String, minion> minions){
    List<target> targets = new List<target>();
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