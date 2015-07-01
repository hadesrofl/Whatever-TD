library control;

import '../model/game/game.dart';
import "../view/view.dart";
import 'dart:async';
import 'package:TowerDefense/model/level/levelAdmin.dart';

// TODO: Problem, ob Eingaben während der Wellen vom Nutzer aus möglich sind
// oder nicht
class Controller {
  static const int CANONTOWER = 1;
  static const int ARROWTOWER = 2;
  static const int FIRETOWER = 3;
  static const int LIGHTNINGTOWER = 4;
  View view;
  Game game;
  bool boolean;
  Field towerField;
  String field;
  var setTower;
  var x;
  bool endOfWave = false;
  Timer startWave;
  final startCounter = 15;
  List<StreamSubscription> streams = new List<StreamSubscription>();
  Timer updateMinionTimer;
  Timer updatePlayerDataTimer;
  Timer waveEndTimer;
  Duration waveEndCheck = const Duration(milliseconds: 1000);
  Duration playerData = const Duration(milliseconds: 1500);
  Duration updateMinion = const Duration(milliseconds: 200);
  Duration buildingPhase = const Duration(milliseconds: 1000);
  Controller(String levels) {
    //Initializing the Game
    game = new Game(levels);
    view = new View(game.getRow(), game.getCol());
    game.setView(view);
    view.start.onClick.listen((ev) {
      /* TODO: Check for following characters only? a-zA-Z0-9 */
      game.setPlayer(view.nameInput.value);
      view.createBoard(game.getRow(), game.getCol());
      view.start.hidden = true;
      view.nameInput.hidden = true;
      view.menuContainer.hidden = false;
      view.helpBox.hidden = false;
      view.help.hidden = false;
      view.playerLabel.innerHtml = "Name: " + game.player.getName();
      view.points.innerHtml =
          "Points: " + game.player.getHighscore().toString();
      view.gold.innerHtml = "Gold: " + game.player.getGold().toString();
      view.life.innerHtml = "Life: " + game.life.toString();
    });
    buyListener();
    sellListener();
    upgradeListener();
    difficultyListener();
    helpListener();

    view.cancel.onClick.listen((ev) {
      view.buyMenu.hidden = true;
      view.cancel.hidden = true;
      view.sell.hidden = false;
      view.upgrade.hidden = false;
      view.buy.hidden = false;
    });
  }
  void stopListener() {
    view.stop.onClick.listen((ev) {
      stopControllerTimer();
      game.stopGameTimer();
      game.lAdmin.stopActiveMinions();
      view.restart.hidden = false;
      view.stop.hidden = true;
      restartListener();
    });
  }
  void restartListener() {
    view.restart.onClick.listen((ev) {
      startControllerTimer();
      game.startGameTimer();
      game.lAdmin.restartActiveMinions();
      view.restart.hidden = true;
      view.stop.hidden = false;
    });
  }
  void helpListener() {
    view.help.onClick.listen((ev) {
      view.helpText.innerHtml =
          "Towerklassen: There are four kinds of Tower you can buy." +
              "1: CanonTower() 2.ArrowTower() 3.FireTower() 4.LightningTower().";
      view.helpText.hidden = false;
    });
  }
  void difficultyListener() {
    view.easy.onClick.listen((ev) {
      view.hideDifficultyMenu();
      game.setDifficulty("easy");
      game.setTowerAdmin();
      game.setLevelAdmin();
      if (game.player != null) {
        game.player = null;
      }
      game.setPlayer(view.nameInput.value);
      this.view.clearBoard();
      setPath();
      startWaveTimer();
    });
    view.medium.onClick.listen((ev) {
      view.hideDifficultyMenu();
      game.setDifficulty("medium");
      game.setTowerAdmin();
      game.setLevelAdmin();
      if (game.player != null) {
        game.player = null;
      }
      game.setPlayer(view.nameInput.value);
      this.view.clearBoard();
      setPath();
      startWaveTimer();
    });
    view.hard.onClick.listen((ev) {
      view.hideDifficultyMenu();
      game.setDifficulty("hard");
      game.setTowerAdmin();
      game.setLevelAdmin();
      if (game.player != null) {
        game.player = null;
      }
      game.setPlayer(view.nameInput.value);
      this.view.clearBoard();
      setPath();
      startWaveTimer();
    });
  }
  void upgradeListener() {
    view.upgrade.onClick.listen((ev) {
      bool enoughMoney;
      bool b = true;
      var tmp;

      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          streams.add(
              view.board.children.elementAt(i).children.elementAt(j).onClick
                  .listen((ev) {
            if (b) {
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition() != null &&
                    tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  tmp = tower;
                  enoughMoney = game.tAdmin.upgradeTower(
                      tmp, game.player, game.board, game.row, game.col);
                  if (enoughMoney) view.upgradeImage(
                      id, tmp.name, tmp.getUpgradeLevel());
                }
              });
              b = false;
            }
            endStreamSubscription();
          }));
        }
      }
    });
  }
  void sellListener() {
    x = view.sell.onClick.listen((ev) {
      view.buy.hidden = true;
      view.upgrade.hidden = true;
      view.sell.hidden = true;
      bool check = true;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          streams.add(
              view.board.children.elementAt(i).children.elementAt(j).onClick
                  .listen((ev) {
            if (check) {
              var tmp = null;
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition() != null) {
                  if (tower.getPosition().getX() == j &&
                      tower.getPosition().getY() == i) {
                    String id = tower.getPosition().getX().toString() +
                        tower.getPosition().getY().toString();
                    view.deleteImage(id, tower.name);
                    tmp = tower;
                  }
                } else {
                  tmp = tower;
                }
              });
              if (tmp != null) game.tAdmin.sellTower(tmp, game.player);
              print(game.tAdmin.allTower.length);
              check = false;
              view.buy.hidden = false;
              view.upgrade.hidden = false;
              view.sell.hidden = false;
            }
            endStreamSubscription();
          }));
        }
      }
    });
  }
  void buyListener() {
    view.buy.onClick.listen((ev) {
      view.buy.hidden = true;
      view.buyMenu.hidden = false;
      view.arrowTower.hidden = false;
      view.canonTower.hidden = false;
      view.lightningTower.hidden = false;
      view.fireTower.hidden = false;
      view.sell.hidden = true;
      view.upgrade.hidden = true;
      view.cancel.hidden = false;
      boolean = true;
    });
    view.canonTower.onClick.listen((ev) => setTowerImg(CANONTOWER));
    view.arrowTower.onClick.listen((ev) => setTowerImg(ARROWTOWER));
    view.fireTower.onClick.listen((ev) => setTowerImg(FIRETOWER));
    view.lightningTower.onClick.listen((ev) => setTowerImg(LIGHTNINGTOWER));
  }

  void setTowerImg(int towerDescription) {
    if (boolean) {
      view.buyMenu.hidden = true;
      boolean = false;
      Field field;
      bool enough;
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          streams.add(
              view.board.children.elementAt(i).children.elementAt(j).onClick
                  .listen((ev) {
            String f = j.toString() + i.toString();
            field = lookUpField(f);
            switch (towerDescription) {
              case CANONTOWER:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              case ARROWTOWER:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              case FIRETOWER:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              case LIGHTNINGTOWER:
                enough = game.tAdmin.buyTower(towerDescription, game.player,
                    field, game.board, game.getRow(), game.getCol());
                break;
              default:
                break;
            }
            if (enough) {
              view.sell.hidden = false;
              view.upgrade.hidden = false;
              view.buy.hidden = false;
              view.cancel.hidden = true;
              view.setImageToView(f, game.tAdmin.allTower.last.name);
            } else {
              if (towerDescription != 0) {}
            }
            towerDescription = 0;
            endStreamSubscription();
          }));
        }
      }
    }
  }
  Field lookUpField(String field) {
    game.board.forEach((f) {
      if (f.getX().toString() == field[0] && f.getY().toString() == field[1]) {
        towerField = f;
        return towerField;
      }
    });
    return towerField;
  }
  void endStreamSubscription() {
    if (!streams.isEmpty) {
      for (int i = 0; i < streams.length; i++) {
        streams[i].cancel();
      }
    }
  }
  void setPath() {
    game.board.forEach((f) {
      f.pathField = false;
      f.covered = false;
    });
    game.lAdmin.loadPath(game.board);
    game.board.forEach((f) {
      if (f.isPathField()) {
        String id = f.getX().toString() + f.getY().toString();
        view.setImageToView(id, "Path");
      }
    });
  }

  void startControllerTimer() {
    if (updateMinionTimer == null) {
      updateMinionTimer = new Timer.periodic(updateMinion, (_) {
        this.view.minionsleft.innerHtml = "Minions left: " + (game.lAdmin.getCurrentWave().getNumberOfMinions() - game.lAdmin.getCurrentWave().getDeadMinions()).toString();
        String id;
        Field lastField =
            game.lAdmin.getPath()[game.lAdmin.getPath().length - 1];
        List<Minion> deadMinions = new List<Minion>();
        List<Minion> leakedMinions = new List<Minion>();
        /* Delete image on last field of path if there are no active minions */
        if (game.lAdmin.getActiveMinions().length == 0) {
          id = lastField.getX().toString() + lastField.getY().toString();
          view.deleteImageOnLastPathField(id);
          for (int i = 0;
              i < game.lAdmin.getCurrentWave().getMinions().length;
              i++) {
            view.deleteImage(
                id, game.lAdmin.getCurrentWave().getMinions()[i].getName());
          }
          /* There are minions on the board */
        } else {
          game.lAdmin.getActiveMinions().forEach((m) {
            if (m.getDestroyedALife()) {
              leakedMinions.add(m);
              id = lastField.getX().toString() + lastField.getY().toString();
              view.deleteImageOnLastPathField(id);
            }
            String oldId;
            /* Minion is dead */
            if (m.getHitpoints() <= 0) {
              for(int i = 0; i < 2; i++){
                id = (m.getPosition().getX() - i).toString() +
                                         (m.getPosition().getY() - i).toString();
                game.lAdmin.getCurrentWave().getDistinctMinions().forEach((m){
                  view.deleteImage(id, m.getName());
                });
              }
              deadMinions.add(m);
              /* Minion is not dead, move image alongside the minion */
            } else {
              if (m.getStepsOnPath() < game.lAdmin.getPath().length) {
                if (m.getStepsOnPath() != 0) {
                  oldId = game.lAdmin.getPath()[m.getStepsOnPath() - 1]
                          .getX()
                          .toString() +
                      m.path[m.getStepsOnPath() - 1].getY().toString();
                  view.deleteImage(oldId, m.getName());
                }
                id = m.getPosition().getX().toString() +
                    m.getPosition().getY().toString();
                view.setImageToView(id, m.getName());
                /* Minion leaked, delete image on last field */
              }
            }
          });
        }

        /* Delete Dead Minions from active minion list of the map */
        if (deadMinions.isNotEmpty) {
          deadMinions.forEach((m) {
            game.lAdmin.getCurrentWave().incDeadMinions();
            game.lAdmin.getCurrentWave().incDroppedGold(m.getDroppedGold());
            game.lAdmin.getActiveMinions().remove(m);
          });
        }
        /* remove leaked minions from list of active minions */
        if (leakedMinions.isNotEmpty) {
          leakedMinions.forEach((m) {
            game.lAdmin.getCurrentWave().incLeakedMinions();
            game.lAdmin.activeMinions.remove(m);
          });
        }
      });
    }
      if (waveEndTimer == null) {
        waveEndTimer = new Timer.periodic(waveEndCheck, (_) {
          this.view.minionsleft.innerHtml = "Minions left: " + (game.lAdmin.getCurrentWave().getNumberOfMinions() - game.lAdmin.getCurrentWave().getDeadMinions()).toString();
          if (game.lAdmin.isLevelEnd() && game.lAdmin.isFinalLevel() ||
              game.life <= 0) {
            clearPath();
            game.evaluateKilledMinions(true);
            /* Player wins */
            if (game.life <= 0) {
              this.view.playerLabel.innerHtml = "Game over!";
              view.life.innerHtml = "Life: " + game.life.toString();
              /* Player loses */
            } else {
              this.view.playerLabel.innerHtml = "Congratz!";
            }
            endOfWave = true;
            game.endOfGame();
            stopControllerTimer();
            stopUpdatePlayerDataTimer();
            view.showDifficultyMenu();
            this.view.stop.hidden = true;
            this.view.clearMinionToolTip();
          } else if (game.lAdmin.isLevelEnd() && !game.lAdmin.isFinalLevel() ||
              game.lAdmin.getCurrentWave().isWaveClear()) {
            endOfWave = true;
            clearPath();
            this.startWaveTimer();
            this.view.stop.hidden = true;
            this.view.clearMinionToolTip();
          }
        });
      }
  }
  void clearPath() {
    game.lAdmin.getPath().forEach((f) {
      String id = f.getX().toString() + f.getY().toString();
      this.game.lAdmin.getCurrentWave().getDistinctMinions().forEach((m){
        view.deleteImage(
                  id, m.getName());
      });
    });
  }
  void startWaveTimer() {
    view.time.hidden = false;
    int counter = this.startCounter;
    startUpdatePlayerDataTimer();
    if (startWave == null) {
      startWave = new Timer.periodic((buildingPhase), (_) {
        if (counter == 0) {
          game.startGame();
          this.view.level.innerHtml = "Level: " + game.lAdmin.currentLevel.toString();
          this.view.wave.innerHtml = "Wave: " + game.lAdmin.getCurrentWave().getWaveNumber().toString();
          this.view.minionsleft.innerHtml = "Minions left: " + (game.lAdmin.getCurrentWave().getNumberOfMinions() - game.lAdmin.getCurrentWave().getDeadMinions()).toString();
          this.setMinionInfo();
          startWave.cancel();
          startWave = null;
          startControllerTimer();
          view.stop.hidden = false;
          view.time.hidden = true;
          view.timerhr.hidden = true;
          stopListener();
          endOfWave = false;
        } else {
          counter--;
        }
        view.time.innerHtml = "Next Wave starts in: " + counter.toString();
        if (counter != 0) view.timerhr.hidden = false;
      });
    }
  }
  void stopControllerTimer() {
    if(updateMinionTimer != null){
    updateMinionTimer.cancel();
    updateMinionTimer = null; 
    }
    if(waveEndTimer != null){
      waveEndTimer.cancel();
      waveEndTimer = null;
    }
  }
  void setMinionInfo() {
    this.game.lAdmin.currentWave.getDistinctMinions().forEach((m) {
      String name = m.getName();
      String armor = m.getArmor().value.toString();
      String hitPoints = m.getHitpoints().toString();
      String movementSpeed = (m.getMovementSpeed().inMilliseconds.roundToDouble()/1000).toString();
      String droppedGold = m.getDroppedGold().toString();
      this.view.setMinionToolTip(
          name, armor, hitPoints, movementSpeed, droppedGold);
    });
  }
  void startUpdatePlayerDataTimer(){
    if (updatePlayerDataTimer == null) {
      updatePlayerDataTimer = new Timer.periodic(playerData, (_) {
        if (!endOfWave) {
          if(this.game.lAdmin != null && this.game.lAdmin.getCurrentWave() != null){
            this.game.evaluateKilledMinions(false);
          }
        }
        int gold = game.player.getGold();
        if (gold < 0) {
          gold = 0;
        }
        view.playerLabel.innerHtml = "Name: " + game.player.getName();
        view.points.innerHtml =
            "Points: " + game.player.getHighscore().toString();
        view.gold.innerHtml = "Gold: " + game.player.getGold().toString();
        view.life.innerHtml = "Life: " + game.life.toString();
      });
    }
  }
  void stopUpdatePlayerDataTimer(){
    if(updatePlayerDataTimer != null){
      updatePlayerDataTimer.cancel();
      updatePlayerDataTimer = null;
    }
  }
}
