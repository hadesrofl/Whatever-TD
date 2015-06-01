library tower;
import "../level/levelAdmin.dart";
import "../field.dart";
import "../player.dart";

part 'target.dart';
part 'damage.dart';
part 'tower.dart';
part 'canonTower.dart';
part 'lighteningTower.dart';
part 'fireTower.dart';
part 'arrowTower.dart';

class TowerAdmin{
  
  List<Tower> allTower;
  
  TowerAdmin(){
    allTower = new List<Tower>();
  }
  
  /**
   * calculates all the targets which the tower can reach
   */
  List<Target> attack(Map<String, Minion> minions){
    List<Target> targets = new List<Target>();
    return targets;
  }
  
  /**
   * updates money of the player and adds the new Tower to the AllTower-List
   */
  Tower buyTower(int towerDescription, Player player){
    Tower newTower;
    switch(towerDescription){
      // case 1 = CanonTower
      case 1: 
        newTower = new CanonTower();
        if(!enoughMoney(newTower, player)){
          //TODO: print befehl ausgabe im HTML Dokument evtl returnType bool
          print("Nicht genug Geld vorhanden");
          newTower = null;
        }
        else{
        player.setGold(player.getGold() - newTower.getPrice());
        allTower.add(newTower);
        }
        break;
        // case 2 = ArrowTower
      case 2:
          newTower = new ArrowTower();
         if(!enoughMoney(newTower, player)){
          //TODO: print befehl ausgabe im HTML Dokument evtl returnType bool
          print("Nicht genug Geld vorhanden");
          newTower = null;
         }
         else{
           player.setGold(player.getGold() - newTower.getPrice());
                   allTower.add(newTower);
         }
         break;
        // case 3 = FireTower
      case 3:
         newTower = new FireTower();
        if(!enoughMoney(newTower, player)){
                  //TODO: print befehl ausgabe im HTML Dokument evtl returnType bool
                  print("Nicht genug Geld vorhanden");
                  newTower = null;
                 }
                 else{
                   player.setGold(player.getGold() - newTower.getPrice());
                           allTower.add(newTower);
                 }
        break;
        // case 4 = LighteningTower
      case 4:
         newTower = new LighteningTower();
                if(!enoughMoney(newTower, player)){
                          //TODO: print befehl ausgabe im HTML Dokument evtl returnType bool
                          print("Nicht genug Geld vorhanden");
                          newTower = null;
                         }
                         else{
                           player.setGold(player.getGold() - newTower.getPrice());
                                   allTower.add(newTower);
                         }
       break;    
    
    default: 
      break;
    }
    return newTower;
    
  }
  
  /**
   * deletes the Tower and upgrades the players amount of gold
   */
  void sellTower(Tower tower, Player player){
    player.setGold(player.getGold() + tower.getSellingPrice());
    tower = null;
  }
  
  /**
   * selects the tower by the given field
   */
  bool setTowerChoords(Tower tower, Field f){
    if(!f.isPathField() || !f.isCovered()){
    tower.setCoordinates(f);
    f.setCovered(true);
    return true;
    }
    else{
      print("Tower cannot be placed here");
      return false;
    }
  }
  /**
   * 
   */
  void upgradeTower(){
    
  }
  
}
/**
 * checks if the Player has enough money to buy the tower
 */
bool enoughMoney(Tower tower, Player player){
  if(player.getGold() < tower.getPrice())
    return false;
  
  return true;
}