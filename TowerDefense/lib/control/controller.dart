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
  List<StreamSubscription> streams = new List<StreamSubscription>();
  Timer updateMinionTimer;
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
      view.nameLabel.innerHtml = "Hello " +
          view.nameInput.value +
          ", you've got " +
          game.player.getHighscore().toString() +
          " Points";
      view.nameInput.hidden = true;
      view.menuContainer.hidden = false;
      view.errorDiv2.hidden = true;
      view.errorDiv.hidden = true;
      updateGold();
    });
    buyListener();
    sellListener();
    upgradeListener();
    difficultyListener();

    view.cancel.onClick.listen((ev) {
      view.buyMenu.hidden = true;
      view.cancel.hidden = true;
      view.sell.hidden = false;
      view.upgrade.hidden = false;
      view.buy.hidden = false;
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
    });
  }
  void difficultyListener() {
    view.easy.onClick.listen((ev) {
      view.hideDifficultyMenu();
      game.setDifficulty("easy");
      game.setLevelAdmin();
      game.startGame();
      gameTriggers();
      setPath();
    });
    view.medium.onClick.listen((ev) {
      view.hideDifficultyMenu();
      game.setDifficulty("medium");
      game.setLevelAdmin();
      game.startGame();
      gameTriggers();
      setPath();
    });
    view.hard.onClick.listen((ev) {
      view.hideDifficultyMenu();
      game.setDifficulty("hard");
      game.setLevelAdmin();
      game.startGame();
      gameTriggers();
      setPath();
    });
  }
  void upgradeListener() {
    view.upgrade.onClick.listen((ev) {
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
      bool enoughMoney;
      bool b = true;
      var tmp;
      endStreamSubscription();
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          streams.add(
              view.board.children.elementAt(i).children.elementAt(j).onClick
                  .listen((ev) {
            if (b) {
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  tmp = tower;
                  enoughMoney = game.tAdmin.upgradeTower(
                      tmp, game.player, game.board, game.row, game.col);
                  if (enoughMoney) {
                    view.upgradeImage(id, tmp.name, tmp.getUpgradeLevel());
                    updateGold();
                  } else {
                    view.errorDiv.hidden = false;
                  }
                }
              });
              b = false;
            }
          }));
        }
      }
    });
  }
  void sellListener() {
    x = view.sell.onClick.listen((ev) {
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
      view.buy.hidden = true;
      view.upgrade.hidden = true;
      view.sell.hidden = true;
      bool check = true;
      endStreamSubscription();
      for (int i = 0; i < game.getCol(); i++) {
        for (int j = 0; j < game.getRow(); j++) {
          streams.add(
              view.board.children.elementAt(i).children.elementAt(j).onClick
                  .listen((ev) {
            if (check) {
              var tmp = null;
              game.tAdmin.allTower.forEach((tower) {
                if (tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  view.deleteImage(id, tower.name);
                  tmp = tower;
                }
              });
              if (tmp != null) game.tAdmin.sellTower(tmp, game.player);
              updateGold();
              check = false;
              view.buy.hidden = false;
              view.upgrade.hidden = false;
              view.sell.hidden = false;
            }
          }));
        }
      }
    });
  }
  void buyListener() {
    view.buy.onClick.listen((ev) {
      view.errorDiv.hidden = true;
      view.errorDiv2.hidden = true;
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
    endStreamSubscription();
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
              updateGold();
              view.sell.hidden = false;
              view.upgrade.hidden = false;
              view.buy.hidden = false;
              view.cancel.hidden = true;
              view.setImageToView(f, game.tAdmin.allTower.last.name);
            } else {
              if (towerDescription != 0) {
                view.errorDiv.hidden = false;
              }
            }
            towerDescription = 0;
          }));
        }
      }
    }
  }
  Field lookUpField(String field) {
    game.board.keys.forEach((f) {
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
    game.board.forEach((f, v) {
      if (f.isPathField()) {
        String id = f.getX().toString() + f.getY().toString();
        view.setImageToView(id, "Path");
      }
    });
  }
  void updateGold() {
    view.px.innerHtml = game.player.getGold().toString();
  }
  void gameTriggers(){

    if(updateMinionTimer == null){
      updateMinionTimer = new Timer.periodic(game.lAdmin.getCurrentWave().getMinions()[0].getMovementSpeed(),(_) {
        String id;
        List<Minion> tmp = new List<Minion>();
        if(game.lAdmin.getMinions().length == 0){
          Field lastField = game.lAdmin.getPath()[game.lAdmin.getPath().length-1];
                  id =  lastField.getX().toString() + lastField.getY().toString();
                view.deleteImage(id, game.lAdmin.getCurrentWave().getMinions()[0].getName());
        }else{
          game.lAdmin.getMinions().forEach((m){
                    String oldId;
                    if(m.getHitpoints() <= 0){
                      id = m.getPosition().getX().toString() + m.getPosition().getY().toString();
                      view.deleteImage(id, m.getName());
                      id= (m.getPosition().getX()-1).toString() + (m.getPosition().getY()-1).toString();
                      view.deleteImage(id, m.getName());
                      tmp.add(m);
                    }else{
                    if(m.getStepsOnPath() < game.lAdmin.getPath().length){
                    if(m.getStepsOnPath() != 0){
                     oldId = game.lAdmin.getPath()[m.getStepsOnPath()-1].getX().toString() + m.path[m.getStepsOnPath()-1].getY().toString();
                               view.deleteImage(oldId, m.getName());
                    }
                    id =  m.getPosition().getX().toString() + m.getPosition().getY().toString();
                    view.setImageToView(id, m.getName());
                    }else if(m.getStepsOnPath() >= game.lAdmin.getPath().length){
                      Field lastField = game.lAdmin.getPath()[game.lAdmin.getPath().length-1];
                      id =  lastField.getX().toString() + lastField.getY().toString();
                    view.deleteImage(id, m.getName());
                    }
                    }});
          
        }
        if(tmp.isNotEmpty){
          tmp.forEach((m){
            game.lAdmin.getCurrentWave().incDeadMinions();
            game.lAdmin.getMinions().remove(m);
          });
        }
        print("List of Minions " + game.lAdmin.getMinions().length.toString());
      }); 
  }
}}
