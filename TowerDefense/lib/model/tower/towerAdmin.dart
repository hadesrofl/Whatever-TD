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

/**
 * Administration class for all the tower
 * 
 * @author Florian Winzek
 */
class TowerAdmin {
  /**
   * List with all tower
   */
  List<Tower> allTower;
  /**
   * max level number
   */
  final int MAX_UPGRADE = 3;
  /**
   * Identifier for a CanonTower
   */
  static const CANONTOWER = 1;
  /**
   * Identifier for an ArrowTower
   */
  static const ARROWTOWER = 2;
  /**
   * Identifier for a FireTower
   */
  static const FIRETOWER = 3;
  /**
   * Identifier for a LigthningTower
   */
  static const LIGHTNINGTOWER = 4;
  /**
   * Constructor 
   */
  TowerAdmin() {
    allTower = new List<Tower>();
  }

  /**
   * Calculates all the targets which the tower can reach
   * 
   * @param minions list of all minions
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
   * 
   * @param towerDescription Identifier to build a new Tower
   * @param player player of the game
   * @param field the position on the board where the tower should be placed
   * @param board the playground
   * @param row number of rows of the board
   * @param col number of colums of the board
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
   * 
   * @param tower the tower which should be deleted
   * @player player current player of the game
   */
  void sellTower(Tower tower, Player player) {
    player.setGold(player.getGold() + tower.getSellingPrice());
    tower.getPosition().setCovered(false);
    this.allTower.remove(tower);
    tower = null;
  }

  /**
   * selects the tower by the given field
   * 
   * @param tower the tower which should be placed
   * @param f the field on which the tower should be placed
   * @param board the playground
   * @param row number of rows of the board
   * @param col number of colums of the board
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
   * upgrades a special tower
   * 
   * @param tower tower which should be upgraded
   * @param player current player of the game
   * @param board the playground
   * @param row number of rows of the board
   * @param col number of colums of the board
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
 * 
 * @param tower current tower to buy
 * @param player current player of the game
 */
bool enoughMoney(Tower tower, Player player) {
  if (player.getGold() < tower.getPrice()) return false;

  return true;
}
