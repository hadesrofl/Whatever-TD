library control;

import '../model/game/game.dart';
import "../view/view.dart";
import 'dart:async';
import 'package:TowerDefense/model/level/levelAdmin.dart';

class Controller {
  /**
   * Static for identifying a Canon Tower
   */
  static const int _CANONTOWER = 1;
  /**
   * Static for identifying an Arrow Tower
   */
  static const int _ARROWTOWER = 2;
  /**
   * Static for identifying a Fire Tower
   */
  static const int _FIRETOWER = 3;
  /**
   * Static for identifying a Lightning Tower
   */
  static const int _LIGHTNINGTOWER = 4;
  /**
   * The View that has to be updated
   */
  View _view;
  /**
   * The Game which runs the game
   */
  Game _game;
  /**
   * Bool to check if the end of a wave is reached
   */
  bool _endOfWave = false;
  /**
   * Timer to countdown the start of a wave
   */
  Timer _startWave;
  /**
   * Timer to update the minion positions or remove from the board and game
   */
  Timer _updateMinionTimer;
  /**
   * Timer to update the data of the player and the level
   */
  Timer _updatePlayerDataTimer;
  /**
   * Timer to check the end of a wave
   */
  Timer _waveEndTimer;
  /**
   * Counter till a wave starts
   */
  final _startCounter = 15;
  /**
   * List of streams which listen to some buttons like upgrade and sell
   */
  List<StreamSubscription> _streams = new List<StreamSubscription>();
  /**
   * Duration of the waveEndTimer
   */
  Duration _waveEndCheck = const Duration(milliseconds: 1000);
  /**
   * Duration of the updatePlayerDataTimer
   */
  Duration _playerData = const Duration(milliseconds: 1500);
  /**
   * Duration of the updateMinionTimer
   */
  Duration _updateMinion = const Duration(milliseconds: 200);
  /**
   * Duration of the startWaveTimer
   */
  Duration _startWavePhase = const Duration(milliseconds: 1000);
  /**
   * Constructor of the Controller
   * @param levels is a string with the xml file
   */
  Controller(String levels) {
    //Initializing the Game
    _game = new Game(levels);
    _view = new View(_game.getRow(), _game.getCol());
    /* Listener of the start button */
    _view.getStartButton().onClick.listen((ev) {
      _game.setPlayer(_view.getNameInputText());
      _view.createBoard(_game.getRow(), _game.getCol());
      _view.hideStartButton();
      _view.hideNameInput();
      _view.showNavigation();
      _view.showHelpBox();
      _view.setPlayerLabel("Name: " + _game.getPlayer().getName());
      _view.setPointLabel("Points: " + _game.getPlayer().getHighscore().toString());
      _view.setGoldLabel("Gold: " + _game.getPlayer().getGold().toString());
      _view.setLifeLabel("Life: " + _game.getLife().toString());
    });
    
    buyListener();
    sellListener();
    upgradeListener();
    difficultyListener();
    helpListener();
    
/* Listener of the cancel button */
    _view.getCancelButton().onClick.listen((ev) {
      _view.hideBuyMenu();
      _view.hideCancelButton();
      _view.showSellButton();
      _view.showUpgradeButton();
      _view.showBuyButton();
    });
  }
  /**
   * Sets the listener of the stop button
   */
  void stopListener() {
    _view.getStopButton().onClick.listen((ev) {
      stopUpdateMinionTimer();
      stopWaveEndTimer();
      _game.stopGameTimer();
      _game.getLevelAdmin().stopActiveMinions();
      _view.showRestartButton();
      _view.hideStopButton();
      restartListener();
    });
  }
  /**
   * Sets the listener of the restart button 
   */
  void restartListener() {
    _view.getRestartButton().onClick.listen((ev) {
      startUpdateMinionTimer();
      startWaveEndTimer();
      _game.startGameTimer();
      _game.getLevelAdmin().restartActiveMinions();
      _view.hideRestartButton();
      _view.showStopButton();
    });
  }
  /**
   * Sets the listener of the help button
   */
  void helpListener() {
    _view.getHelpButtonGame().onClick.listen((ev) {
      if(_view.isHelpGameHidden()){
        _view.showHelpGame();
      }else{
        _view.hideHelpGame();
      }
    });
    _view.getHelpButtonTower().onClick.listen((ev){
      if(_view.isHelpTowerHidden()){
        _view.showHelpTower();
      }else{
        _view.hideHelpTower();
      }
    });
    _view.getHelpButtonArmor().onClick.listen((ev){
      if(_view.isHelpArmorHidden()){
        _view.showHelpArmor();
      }else{
        _view.hideHelpArmor();
      }
    });
  }
  /**
   * Sets the listener of the difficulty buttons
   */
  void difficultyListener() {
    _view.getEasyButton().onClick.listen((ev) {
      _view.hideDifficultyMenu();
      _game.setDifficulty("easy");
      _game.setTowerAdmin();
      _game.setLevelAdmin();
      _game.setPlayer(_view.getNameInputText());
      this._view.clearBoard();
      setPath();
      startWaveTimer();
    });
    _view.getMediumButton().onClick.listen((ev) {
      _view.hideDifficultyMenu();
      _game.setDifficulty("medium");
      _game.setTowerAdmin();
      _game.setLevelAdmin();
      _game.setPlayer(_view.getNameInputText());
      this._view.clearBoard();
      setPath();
      startWaveTimer();
    });
    _view.getHardButton().onClick.listen((ev) {
      _view.hideDifficultyMenu();
      _game.setDifficulty("hard");
      _game.setTowerAdmin();
      _game.setLevelAdmin();
      _game.setPlayer(_view.getNameInputText());
      this._view.clearBoard();
      setPath();
      startWaveTimer();
    });
  }
  /**
   * Sets the listener of the upgrade button
   */
  void upgradeListener() {
    _view.getUpgradeButton().onClick.listen((ev) {
      bool enoughMoney;
      bool b = true;
      var tmp;

      for (int i = 0; i < _game.getCol(); i++) {
        for (int j = 0; j < _game.getRow(); j++) {
          _streams.add(
              _view.getTableDataInRow(_view.getTableRowInBoard(i), j).onClick.listen((ev) {
            if (b) {
              _game.getTowerAdmin().getAllTower().forEach((tower) {
                if (tower.getPosition() != null &&
                    tower.getPosition().getX() == j &&
                    tower.getPosition().getY() == i) {
                  String id = tower.getPosition().getX().toString() +
                      tower.getPosition().getY().toString();
                  tmp = tower;
                  enoughMoney = _game.getTowerAdmin().upgradeTower(
                      tmp, _game.getPlayer(), _game.getBoard(), _game.getRow(), _game.getCol());
                  if (enoughMoney) _view.upgradeImage(
                      id, tmp.getName(), tmp.getUpgradeLevel());
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
  /**
   * Sets the listener of the sell button
   */
  void sellListener() {
    _view.getSellButton().onClick.listen((ev) {
      _view.hideBuyButton();
      _view.hideUpgradeButton();
      _view.hideSellButton();
      bool check = true;
      for (int i = 0; i < _game.getCol(); i++) {
        for (int j = 0; j < _game.getRow(); j++) {
          _streams.add(
              _view.getTableDataInRow(_view.getTableRowInBoard(i), j).onClick
                  .listen((ev) {
            if (check) {
              var tmp = null;
              _game.getTowerAdmin().getAllTower().forEach((tower) {
                if (tower.getPosition() != null) {
                  if (tower.getPosition().getX() == j &&
                      tower.getPosition().getY() == i) {
                    String id = tower.getPosition().getX().toString() +
                        tower.getPosition().getY().toString();
                    _view.deleteImage(id, tower.getName());
                    tmp = tower;
                  }
                } else {
                  tmp = tower;
                }
              });
              if (tmp != null) _game.getTowerAdmin().sellTower(tmp, _game.getPlayer());
              print(_game.getTowerAdmin().getAllTower().length);
              check = false;
              _view.hideBuyButton();
              _view.showUpgradeButton();
              _view.showSellButton();
            }
            endStreamSubscription();
          }));
        }
      }
    });
  }
  /**
   * Sets the listener of the buy button
   */
  void buyListener() {
    _view.getBuyButton().onClick.listen((ev) {
      _view.hideBuyButton();
      _view.showBuyMenu();
      _view.showArrowTowerButton();
      _view.showCanonTowerButton();
      _view.showLightningTowerButton();
      _view.showFireTowerButton();
      _view.hideSellButton();
      _view.hideUpgradeButton();
      _view.showCancelButton();
    });
    _view.getCanonTowerButton().onClick.listen((ev) => setTowerImg(_CANONTOWER));
    _view.getArrowTowerButton().onClick.listen((ev) => setTowerImg(_ARROWTOWER));
    _view.getFireTowerButton().onClick.listen((ev) => setTowerImg(_FIRETOWER));
    _view.getLightningTowerButton().onClick.listen((ev) => setTowerImg(_LIGHTNINGTOWER));
  }
/**
 * Sets the tower image to a field
 * @param towerDescription is the identifier of a tower type
 */
  void setTowerImg(int towerDescription) {
      _view.hideBuyMenu();
      Field field;
      bool enough;
      for (int i = 0; i < _game.getCol(); i++) {
        for (int j = 0; j < _game.getRow(); j++) {
          _streams.add(
              _view.getTableDataInRow(_view.getTableRowInBoard(i), j).onClick
                  .listen((ev) {
            String f = j.toString() + i.toString();
            field = lookUpField(f);
            switch (towerDescription) {
              case _CANONTOWER:
                enough = _game.getTowerAdmin().buyTower(towerDescription, _game.getPlayer(),
                    field, _game.getBoard(), _game.getRow(), _game.getCol());
                break;
              case _ARROWTOWER:
                enough = _game.getTowerAdmin().buyTower(towerDescription, _game.getPlayer(),
                    field, _game.getBoard(), _game.getRow(), _game.getCol());
                break;
              case _FIRETOWER:
                enough = _game.getTowerAdmin().buyTower(towerDescription, _game.getPlayer(),
                    field, _game.getBoard(), _game.getRow(), _game.getCol());
                break;
              case _LIGHTNINGTOWER:
                enough = _game.getTowerAdmin().buyTower(towerDescription, _game.getPlayer(),
                    field, _game.getBoard(), _game.getRow(), _game.getCol());
                break;
              default:
                break;
            }
            if (enough) {
              _view.showSellButton();
              _view.showUpgradeButton();
              _view.showBuyButton();
              _view..hideCancelButton();
              _view.setImageToView(f, _game.getTowerAdmin().getAllTower().last.getName());
            } else {
              if (towerDescription != 0) {}
            }
            towerDescription = 0;
            endStreamSubscription();
          }));
        }
      }
  }
  /**
   * Looks up a field on the board comparing it to a given string with a field id
   * @param field is a field id as string
   * @return a field object. Null if no field could be matched to the string parameter, else the field object
   */
  Field lookUpField(String field) {
    Field towerField = null;
    _game.getBoard().forEach((f) {
      if (f.getX().toString() == field[0] && f.getY().toString() == field[1]) {
        towerField = f;
        return towerField;
      }
    });
    return towerField;
  }
  /**
   * Ends all listener streams
   */
  void endStreamSubscription() {
    if (!_streams.isEmpty) {
      for (int i = 0; i < _streams.length; i++) {
        _streams[i].cancel();
      }
    }
  }
  /**
   * Sets the path of the game to the game board and view
   */
  void setPath() {
    _game.getBoard().forEach((f) {
      f.setPathField(false);
      f.setCovered(false);
    });
    _game.getLevelAdmin().loadPath(_game.getBoard());
    _game.getBoard().forEach((f) {
      if (f.isPathField()) {
        String id = f.getX().toString() + f.getY().toString();
        _view.setImageToView(id, "Path");
      }
    });
  }
  /**
   * Clears the path of all miniom images
   */
  void clearPath() {
    _game.getLevelAdmin().getPath().forEach((f) {
      String id = f.getX().toString() + f.getY().toString();
      this._game.getLevelAdmin().getCurrentWave().getDistinctMinions().forEach((m){
        _view.deleteImage(
                  id, m.getName());
      });
    });
  }
  /**
   * Starts the wave timer which starts a countdown for the wave
   */
  void startWaveTimer() {
    _view.showTillWaveLabel();
    int counter = this._startCounter;
    startUpdatePlayerDataTimer();
    if (_startWave == null) {
      _startWave = new Timer.periodic((_startWavePhase), (_) {
        if (counter == 0) {
          _game.startGame();
          this._view.setLevelLabel("Level: " + _game.getLevelAdmin().getCurrentLevel().toString());
          this._view.setWaveLabel("Wave: " + _game.getLevelAdmin().getCurrentWave().getWaveNumber().toString());
          this._view.setMinionsLeftLabel("Minions left: " + (_game.getLevelAdmin().getCurrentWave().getNumberOfMinions() - _game.getLevelAdmin().getCurrentWave().getDeadMinions()).toString());
          this.setMinionInfo();
          _startWave.cancel();
          _startWave = null;
          startUpdateMinionTimer();
          startWaveEndTimer();
<<<<<<< HEAD
          _view.showStopButton();
          _view.hideTillWaveLabel();
=======
          _view.stop.hidden = false;
          _view.tillWave.hidden = true;
          _view.timerhr.hidden = true;
>>>>>>> 23f422e865246b45406c0f9ea7ad5581c9d272aa
          stopListener();
          _endOfWave = false;
        } else {
          counter--;
        }
        _view.setTillWaveLabel("Next Wave starts in: " + counter.toString());
      //  if (counter != 0) _view.timerhr.hidden = false;
      });
    }
  }
  /**
   * Sets the tool tip for the minion info images
   */
  void setMinionInfo() {
    this._game.getLevelAdmin().getCurrentWave().getDistinctMinions().forEach((m) {
      String name = m.getName();
      String armor = m.getArmor().value.toString();
      String hitPoints = m.getHitpoints().toString();
      String movementSpeed = (m.getMovementSpeed().inMilliseconds.roundToDouble()/1000).toString();
      String droppedGold = m.getDroppedGold().toString();
      this._view.setMinionToolTip(
          name, armor, hitPoints, movementSpeed, droppedGold);
    });
  }
  /**
   * Starts the updatePlayerDataTimer
   */
  void startUpdatePlayerDataTimer(){
    if (_updatePlayerDataTimer == null) {
      _updatePlayerDataTimer = new Timer.periodic(_playerData, (_) {
        if (!_endOfWave) {
          if(this._game.getLevelAdmin() != null && this._game.getLevelAdmin().getCurrentWave() != null){
            this._game.evaluateKilledMinions(false);
          }
        }
        int gold = _game.getPlayer().getGold();
        _view.setPlayerLabel("Name: " + _game.getPlayer().getName());
        _view.setPointLabel( "Points: " + _game.getPlayer().getHighscore().toString());
        if (gold < 0) {
                 gold = 0;
               }
        _view.setGoldLabel("Gold: " + _game.getPlayer().getGold().toString());
        _view.setLifeLabel("Life: " + _game.getLife().toString());
      });
    }
  }
  /**
   * Stops the updatePlayerDataTimer
   */
  void stopUpdatePlayerDataTimer(){
    if(_updatePlayerDataTimer != null){
      _updatePlayerDataTimer.cancel();
      _updatePlayerDataTimer = null;
    }
  }
  /**
   * Starts the waveEndTimer
   */
  void startWaveEndTimer(){
    if (_waveEndTimer == null) {
           _waveEndTimer = new Timer.periodic(_waveEndCheck, (_) {
             this._view.setMinionsLeftLabel("Minions left: " + (_game.getLevelAdmin().getCurrentWave().getNumberOfMinions() - _game.getLevelAdmin().getCurrentWave().getDeadMinions()).toString());
             if (_game.getLevelAdmin().isLevelEnd() && _game.getLevelAdmin().isFinalLevel() ||
                 _game.getLife() <= 0) {
               clearPath();
               _game.evaluateKilledMinions(true);
               /* Player wins */
               if (_game.getLife() <= 0) {
                 this._view.setPlayerLabel("Game over!");
                 _view.setLifeLabel("Life: " + _game.getLife().toString());
                 /* Player loses */
               } else {
                 this._view.setPlayerLabel("Congratz!");
               }
               _endOfWave = true;
               _game.endOfGame();
               stopWaveEndTimer();
               stopUpdateMinionTimer();
               stopUpdatePlayerDataTimer();
               _view.showDifficultyMenu();
               this._view.hideStopButton();
               this._view.clearMinionToolTip();
             } else if (_game.getLevelAdmin().isLevelEnd() && !_game.getLevelAdmin().isFinalLevel() ||
                 _game.getLevelAdmin().getCurrentWave().isWaveClear()) {
               _endOfWave = true;
               clearPath();
               this.startWaveTimer();
               this._view.hideStopButton();
               this._view.clearMinionToolTip();
             }
           });
         }
  }
  /**
   * Stops the waveEndTimer
   */
  void stopWaveEndTimer(){
    if(_waveEndTimer != null){
      _waveEndTimer.cancel();
      _waveEndTimer = null;
    }
  }
  /**
   * Starts the updateMinionTimer
   */
  void startUpdateMinionTimer(){
    if (_updateMinionTimer == null) {
      _updateMinionTimer = new Timer.periodic(_updateMinion, (_) {
<<<<<<< HEAD
        this._view.setMinionsLeftLabel("Minions left: " + (_game.getLevelAdmin().getCurrentWave().getNumberOfMinions() - _game.getLevelAdmin().getCurrentWave().getDeadMinions()).toString());
=======
        this._view.minionsLeft.innerHtml = "Minions left: " + (_game.getLevelAdmin().getCurrentWave().getNumberOfMinions() - _game.getLevelAdmin().getCurrentWave().getDeadMinions()).toString();
>>>>>>> 23f422e865246b45406c0f9ea7ad5581c9d272aa
        String id;
        Field lastField =
            _game.getLevelAdmin().getPath()[_game.getLevelAdmin().getPath().length - 1];
        List<Minion> deadMinions = new List<Minion>();
        List<Minion> leakedMinions = new List<Minion>();
        /* Delete image on last field of path if there are no active minions */
        if (_game.getLevelAdmin().getActiveMinions().length == 0) {
          id = lastField.getX().toString() + lastField.getY().toString();
          _view.deleteImageOnLastPathField(id);
          for (int i = 0;
              i < _game.getLevelAdmin().getCurrentWave().getMinions().length;
              i++) {
            _view.deleteImage(
                id, _game.getLevelAdmin().getCurrentWave().getMinions()[i].getName());
          }
          /* There are minions on the board */
        } else {
          _game.getLevelAdmin().getActiveMinions().forEach((m) {
            if (m.getDestroyedALife()) {
              leakedMinions.add(m);
              id = lastField.getX().toString() + lastField.getY().toString();
              _view.deleteImageOnLastPathField(id);
            }
            String oldId;
            /* Minion is dead */
            if (m.getHitpoints() <= 0) {
              for(int i = 0; i < 2; i++){
                id = (m.getPosition().getX() - i).toString() +
                                         (m.getPosition().getY() - i).toString();
                _game.getLevelAdmin().getCurrentWave().getDistinctMinions().forEach((m){
                  _view.deleteImage(id, m.getName());
                });
              }
              deadMinions.add(m);
              /* Minion is not dead, move image alongside the minion */
            } else {
              if (m.getStepsOnPath() < _game.getLevelAdmin().getPath().length) {
                if (m.getStepsOnPath() != 0) {
                  oldId = _game.getLevelAdmin().getPath()[m.getStepsOnPath() - 1]
                          .getX()
                          .toString() +
                      m.getPath()[m.getStepsOnPath() - 1].getY().toString();
                  _view.deleteImage(oldId, m.getName());
                }
                id = m.getPosition().getX().toString() +
                    m.getPosition().getY().toString();
                _view.setImageToView(id, m.getName());
                /* Minion leaked, delete image on last field */
              }
            }
          });
        }
        /* Delete Dead Minions from active minion list of the map */
        if (deadMinions.isNotEmpty) {
          deadMinions.forEach((m) {
            _game.getLevelAdmin().getCurrentWave().incDeadMinions();
            _game.getLevelAdmin().getCurrentWave().incDroppedGold(m.getDroppedGold());
            _game.getLevelAdmin().getActiveMinions().remove(m);
          });
        }
        /* remove leaked minions from list of active minions */
        if (leakedMinions.isNotEmpty) {
          leakedMinions.forEach((m) {
            _game.getLevelAdmin().getCurrentWave().incLeakedMinions();
            _game.getLevelAdmin().getActiveMinions().remove(m);
          });
        }
      });
    }
  }
  /**
   * Stops the updateMinionTimer
   */
  void stopUpdateMinionTimer(){
    if(_updateMinionTimer != null){
    _updateMinionTimer.cancel();
    _updateMinionTimer = null; 
    }
  }
  }