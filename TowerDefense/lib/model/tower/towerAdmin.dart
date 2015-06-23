library tower;

import "../level/levelAdmin.dart";
import "../game/game.dart";
import 'dart:math';

part 'target.dart';
part 'condition.dart';
part 'damage.dart';
part 'tower.dart';
part 'canonTower.dart';
part 'lightningTower.dart';
part 'fireTower.dart';
part 'arrowTower.dart';

class TowerAdmin {
  List<Tower> allTower;
  final int MAX_UPGRADE = 3;
  static const CANONTOWER = 1;
  static const ARROWTOWER = 2;
  static const FIRETOWER = 3;
  static const LIGHTNINGTOWER = 4;

  TowerAdmin() {
    allTower = new List<Tower>();
  }

  /**
   * calculates all the targets which the tower can reach
   */
  Map<Tower, Target> attack(List<Minion> minions) {
    Map<Tower, Target> targets = new Map<Tower, Target>();
    allTower.forEach((tower) {
      Target newTarget = tower.shoot(minions);
      targets.putIfAbsent(tower, () => newTarget);
    });
    return targets;
  }

  /**
   * updates money of the player and adds the new Tower to the AllTower-List
   */
  bool buyTower(int towerDescription, Player player, Field field,
      Map<Field, String> board, final row, final col) {
    bool ausgabe;
    Tower newTower;
    switch (towerDescription) {
      case CANONTOWER:
        newTower = new CanonTower();
        if (!enoughMoney(newTower, player)) {
          print("Not enough money to buy the Tower");
          newTower = null;
          ausgabe = false;
        } else {
          player.setGold(player.getGold() - newTower.getPrice());
          allTower.add(newTower);
          ausgabe = true;
        }
        break;
      case ARROWTOWER:
        newTower = new ArrowTower();
        if (!enoughMoney(newTower, player)) {
          print("Not enough money to buy the Tower");
          newTower = null;
          ausgabe = false;
        } else {
          player.setGold(player.getGold() - newTower.getPrice());
          allTower.add(newTower);
          ausgabe = true;
        }
        break;
      case FIRETOWER:
        newTower = new FireTower();
        if (!enoughMoney(newTower, player)) {
          print("Not enough money to buy the Tower");
          newTower = null;
          ausgabe = false;
        } else {
          player.setGold(player.getGold() - newTower.getPrice());
          allTower.add(newTower);
          ausgabe = true;
        }
        break;
      case LIGHTNINGTOWER:
        newTower = new LightningTower();
        if (!enoughMoney(newTower, player)) {
          print("Not enough money to buy the Tower");
          newTower = null;
          ausgabe = false;
        } else {
          player.setGold(player.getGold() - newTower.getPrice());
          allTower.add(newTower);
          ausgabe = true;
        }
        break;

      default:
        break;
    }
    if (ausgabe == true) {
      ausgabe = setTowerChoords(newTower, field, board, row, col);
    }
    return ausgabe;
  }

  /**
   * deletes the Tower and upgrades the players amount of gold
   */
  void sellTower(Tower tower, Player player) {
    player.setGold(player.getGold() + tower.getSellingPrice());
    tower.getPosition().setCovered(false);
    this.allTower.remove(tower);
    tower = null;
  }

  /**
   * selects the tower by the given field
   */
  bool setTowerChoords(
      Tower tower, Field f, Map<Field, String> board, final row, final col) {
    if (!f.isPathField() && !f.isCovered()) {
      tower.setCoordinates(f);
      tower.findFieldsToAttack(board, row, col);
      f.setCovered(true);
      return true;
    } else {
      print("Tower cannot be placed here");
      return false;
    }
  }
  /**
   * 
   */
  bool upgradeTower(Tower tower, Player player, Map<Field, String> board,
      final row, final col) {
    if (tower.newPriceAfterUpgrade() <= player.getGold() &&
        tower.upgradeLevel < this.MAX_UPGRADE) {
      tower.upgrade();
      tower.findFieldsToAttack(board, row, col);
      player.setGold(player.getGold() - tower.getPrice());
      return true;
    } else {
      print("Not enough Money to upgrade the Tower");
      return false;
    }
  }
}
/**
 * checks if the Player has enough money to buy the tower
 */
bool enoughMoney(Tower tower, Player player) {
  if (player.getGold() < tower.getPrice()) return false;

  return true;
}
