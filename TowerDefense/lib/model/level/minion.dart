part of level;

/**
   * This class represents a minion object.
   * @author René Kremer
   */
class Minion {
  /**
   * Name of the Minion
   */
  String _name;
  /**
   * Hitpoints of this minion. If <= 0 minion dies
   */
  double _hitpoints;
  /**
   * Armor type of minion
   */
  Armor _armor;
  /**
   * Speed of minion
   */
  Duration _movementSpeed;
  /**
   * Amount of gold dropped on death
   */
  int _droppedGold;
  /**
   * List of conditions of this minion
   */
  List<Condition> _conditions = new List<Condition>();
  /**
   * Position where the minion is
   */
  Field _position;
  /**
   * Bool if the minion has reached the end of the path
   */
  bool _destroyedALife;
  /**
   * Bool if minion is spawned right now or not
   */
  bool _spawned;
  /**
   * Steps the minion took on the path (index for the path)
   */
  int _stepsOnPath;
  /**
   * Timer for the movement of one minion
   */
  Timer _moveTimer;
  /**
   * Path the minion has to walk on
   */
  List<Field> _path;

  /**
   * Constructor for a minion object
   * @param hitpoints - starting hitpoints a minion has
   * @param armor - type of armor a minion has
   * @param movementSpeed - how fast a minion moves
   * @param x - x-coordinate a minion is starting at
   * @param y - y-coordinate a minion is starting at
   */
  Minion(String name, double hitpoints, Armor armor, Duration movementSpeed,
      int droppedGold) {
    this._name = name;
    this._hitpoints = hitpoints;
    this._armor = armor;
    this._movementSpeed = movementSpeed;
    this._droppedGold = droppedGold;
    this._stepsOnPath = 0;
    this._spawned = false;
    this._destroyedALife = false;
  }
/**
   * Method to calculate hitpoints after getting hit by a tower
   * @param damage - damage object the tower is hitting him with
   * @return the remaining hitpoints
   */
  double calculateHitPoints(Target target) {
    double dmgToMinion = 0.0;
    if (target != null) {
      switch (this._armor.value) {
        //Light Armor
        case "light":
          //TODO: getter einbauen
          //DamageType = Siege
          if (target.getDamage().getDamageType() == 1) {
            dmgToMinion = target.getDamage().getDamageValue() * 0.75;
            //DamageType = Piercing
          } else if (target.getDamage().getDamageType() == 2) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.25;
            //DamageType = Fire
          } else if (target.getDamage().getDamageType() == 3) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.25;
            //DamageType = Lightning
          } else if (target.getDamage().getDamageType() == 4) {
            dmgToMinion = target.getDamage().getDamageValue() * 0.75;
          }
          break;
        //Medium Armor
        case "medium":
          //DamageType = Siege
          if (target.getDamage().getDamageType() == 1) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.0;
            //DamageType = Piercing
          } else if (target.getDamage().getDamageType() == 2) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.0;
            //DamageType = Fire
          } else if (target.getDamage().getDamageType() == 3) {
            dmgToMinion = target.getDamage().getDamageValue() * 0.75;
            //DamageType = Lightning
          } else if (target.getDamage().getDamageType() == 4) {
            dmgToMinion = target.getDamage().getDamageValue() * 0.75;
          }
          break;
        //Heavy Armor
        case "heavy":
          //DamageType = Siege
          if (target.getDamage().getDamageType() == 1) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.25;
            //DamageType = Piercing
          } else if (target.getDamage().getDamageType() == 2) {
            dmgToMinion = target.getDamage().getDamageValue() * 0.75;
            //DamageType = Fire
          } else if (target.getDamage().getDamageType() == 3) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.0;
            //DamageType = Lightning
          } else if (target.getDamage().getDamageType() == 4) {
            dmgToMinion = target.getDamage().getDamageValue() * 1.25;
          }
          break;
        default:
          dmgToMinion = target.getDamage().getDamageValue() * 1.0;
          break;
      }
      /* There are conditions to apply */
      if (target.getCondition() != null) {
        bool foundCondition = false;
        /* Minion has condition already? => reset Duration */
        _conditions.forEach((c) {
          if (foundCondition == false) {
            if (c.getIdentifier().compareTo(target.getCondition().getIdentifier()) ==
                0) {
              foundCondition = true;
              c.resetDuration();
            }
          }
        });
        /* Condition is new */
        if (foundCondition == false) {
          _conditions.add(target.getCondition());
        }
      }
      for (int i = 0; i < _conditions.length; i++) {
        dmgToMinion += _conditions.elementAt(i).apply();
        if (_conditions.elementAt(i).getDuration() == 0) _conditions.remove(i);
      }
      this._hitpoints -= dmgToMinion;
      if (this._hitpoints <= 0) {
        this._moveTimer.cancel();
      }
    }
    return this._hitpoints;
  }
  /**
   * Spawns a minion and sets a moveTimer
  */
  void spawn() {
    this._spawned = true;
    if (_moveTimer == null) {
      _moveTimer = new Timer.periodic(_movementSpeed, (_) =>  
        this.move());
        }
    }

/**
   * Method to move a minion on the board
   */
  void move() {
    incStepsOnPath();
    if (this._stepsOnPath >= this._path.length) {
      this._moveTimer = null;
    } else {
      this._position = this._path[this._stepsOnPath];
    }
  }
  /**
   * Increases the counter of steps he took on the path
   */
  void incStepsOnPath() {
    this._stepsOnPath++;
  }
/**
 * Checks if this minion is equal to a given one
 * @param m - Minion to check equality for
 * @return true if it is the same else false
 */
  bool equals(Minion m) {
    bool same;
    int sameConditionCounter = 0;
    /* Check all conditions */
    if(_conditions.length == m._conditions.length){
    for (int i = 0; i < _conditions.length; i++) {
      if (_conditions[i].equals(m.getConditions()[i])) {
        sameConditionCounter++;
      }
    }}
    /* Check the rest of the attributes */
    if ((this._hitpoints == m.getHitpoints() &&
            this._armor.toString().compareTo(m.getArmor().toString()) == 0) &&
        this._movementSpeed == m.getMovementSpeed() &&
        this._position.equals(m.getPosition()) &&
        this._spawned == m.isSpawned() &&
        this._stepsOnPath == m.getStepsOnPath() &&
        sameConditionCounter == _conditions.length) {
      same = true;
    } else {
      same = false;
    }
    return same;
  }

  /**
   * Restarts the move timer
   */
  void restartMoveTimer(){
    if(this._moveTimer == null){
      this._moveTimer = new Timer.periodic(this._movementSpeed, (_) => move());
    }
  }
  /**
   * Stops the move timer
   */
  void stopMoveTimer(){
    if(this._moveTimer != null){
      this._moveTimer.cancel();
      this._moveTimer = null;
    }
  }
  
/**
 * ---------------Getter and Setter Methods---------------------
 */
/**
 * Returns the hitpoints of this minion
 * @return the number of hitpoints
 */
  double getHitpoints() {
    return this._hitpoints;
  }
/**
 * Gets the current position of this minion on the board
 * @return a field object where the minion is
 */
  Field getPosition() {
    return this._position;
  }
/**
 * Checks if the minion is spawned
 * @return true if it is else false
 */
  bool isSpawned() {
    return this._spawned;
  }
/**
 * Returns the number of steps this minion took on the path
 * @return the number of steps
 */
  int getStepsOnPath() {
    return this._stepsOnPath;
  }
  /**
   * Returns  the armor of this minion
   * @return the armor class
   */
  Armor getArmor() {
    return this._armor;
  }
  /**
   * Returns the movement speed of this minion
   * @return the movement speed
   */
  Duration getMovementSpeed() {
    return this._movementSpeed;
  }
  /**
   * Returns a list of all conditions this minion has
   * @return the list of conditions
   */
  List<Condition> getConditions() {
    return this._conditions;
  }
  /**
   * Returns the amount of gold dropped on death
   * @return the amount of gold
   */
  int getDroppedGold() {
    return this._droppedGold;
  }
  /**
   * Returns the name of the minion
   * @return the name
   */
  String getName() {
    return this._name;
  }
  /**
   * Sets the startPosition of this minion
   */
  void setStartPosition() {
    this._position = this._path[0];
  }
  /**
   * Sets the list of fields for the path the minion has to walk
   * @param path is the list of fields
   */
  void setPath(List<Field> path) {
    this._path = path;
  }
  /**
   * Returns the status if the minion has reached the end of the path and therefore destroyed a life
   * @return true if the minion destroyed a life, false if not
   */
  bool getDestroyedALife() {
    return this._destroyedALife;
  }
  /**
   * Sets the bool for destroying a life 
   * @param b is the bool to be set
   */
  void setDestroyedALife(bool b) {
    this._destroyedALife = b;
  }
  /**
   * Returns the path the minion has to follow
   * @return a list of field objects that are path fields
   */
  List<Field> getPath(){
    return this._path;
  }
}
