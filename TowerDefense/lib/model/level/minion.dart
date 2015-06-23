part of level;

/**
   * This class represents a minion object.
   */
class Minion {
  /**
   * Name of the Minion
   */
  String name;
  /**
   * Hitpoints of this minion. If <= 0 minion dies
   */
  double hitpoints;
  /**
   * Armor type of minion
   */
  Armor armor;
  /**
   * Speed of minion
   */
  Duration movementSpeed;
  /**
   * Amount of gold dropped on death
   */
  int droppedGold;
  /**
   * List of conditions of this minion
   */
  List<Condition> conditions = new List<Condition>();
  /**
   * Position where the minion is
   */
  Field position;
  /**
   * Bool if the minion has reached the end of the path
   */
  bool destroyedALife;
  /**
   * Bool if minion is spawned right now or not
   */
  bool spawned;
  /**
   * Steps the minion took on the path (index for the path)
   */
  int stepsOnPath;
  /**
   * Timer for the movement of one minion
   */
  Timer moveTimer;
  /**
   * Path the minion has to walk on
   */
  List<Field> path;

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
    this.name = name;
    this.hitpoints = hitpoints;
    this.armor = armor;
    this.movementSpeed = movementSpeed;
    this.droppedGold = droppedGold;
    this.stepsOnPath = 0;
    this.spawned = false;
    this.destroyedALife = false;
  }
/**
   * Method to calculate hitpoints after getting hit by a tower
   * @param damage - damage object the tower is hitting him with
   */
  double calculateHitPoints(Target target) {
    double dmgToMinion = 0.0;
    if (target != null) {
      switch (this.armor.value) {
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
        conditions.forEach((c) {
          if (foundCondition == false) {
            if (c.getIdentifier().compareTo(target.getCondition().identifier) ==
                0) {
              foundCondition = true;
              c.resetDuration();
            }
          }
        });
        /* Condition is new */
        if (foundCondition == false) {
          conditions.add(target.getCondition());
        }
      }
      for (int i = 0; i < conditions.length; i++) {
        dmgToMinion += conditions.elementAt(i).apply();
        if (conditions.elementAt(i).getDuration() == 0) conditions.remove(i);
      }
      this.hitpoints -= dmgToMinion;
      if (this.hitpoints <= 0) {
        this.moveTimer.cancel();
        if (this.hitpoints <= 0) {
          this.moveTimer.cancel();
        }
      }
      return this.hitpoints;
    }
  }
  /**
   * Spawns a minion and sets a moveTimer
  */
  void spawn() {
    this.spawned = true;
    if (moveTimer == null) {
      moveTimer = new Timer.periodic(movementSpeed, (_) { 
        this.move();
          });
      
        }
    }

/**
   * Method to move a minion on the board
   */
  void move() {
    incStepsOnPath();
    if (this.stepsOnPath >= this.path.length) {
      this.moveTimer == null;
    } else {
      this.position = this.path[this.stepsOnPath];
    }
  }
  /**
   * Increases the counter of steps he took on the path
   */
  void incStepsOnPath() {
    this.stepsOnPath++;
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
    if(conditions.length != 0 && m.conditions.length != 0){
    for (int i = 0; i < conditions.length; i++) {
      if (conditions[i].equals(m.getConditions()[i])) {
        sameConditionCounter++;
      }
    }}
    /* Check the rest of the attributes */
    if ((this.hitpoints == m.getHitpoints() &&
            this.armor.toString().compareTo(m.getArmor().toString()) == 0) &&
        this.movementSpeed == m.getMovementSpeed() &&
        this.position.equals(m.getPosition()) &&
        this.spawned == m.isSpawned() &&
        this.stepsOnPath == m.getStepsOnPath() &&
        sameConditionCounter == conditions.length) {
      same = true;
    } else {
      same = false;
    }
    return same;
  }

/**
 * ---------------Getter and Setter Methods---------------------
 */
/**
 * Returns the hitpoints of this minion
 * @return the number of hitpoints
 */
  double getHitpoints() {
    return this.hitpoints;
  }
/**
 * Gets the current position of this minion on the board
 * @return a field object where the minion is
 */
  Field getPosition() {
    return this.position;
  }
/**
 * Checks if the minion is spawned
 * @return true if it is else false
 */
  bool isSpawned() {
    return this.spawned;
  }
/**
 * Returns the number of steps this minion took on the path
 * @return the number of steps
 */
  int getStepsOnPath() {
    return this.stepsOnPath;
  }
  /**
   * Returns  the armor of this minion
   * @return the armor class
   */
  Armor getArmor() {
    return this.armor;
  }
  /**
   * Returns the movement speed of this minion
   * @return the movement speed
   */
  Duration getMovementSpeed() {
    return this.movementSpeed;
  }
  /**
   * Returns a list of all conditions this minion has
   * @return the list of conditions
   */
  List<Condition> getConditions() {
    return this.conditions;
  }
  /**
   * Returns the amount of gold dropped on death
   * @return the amount of gold
   */
  int getDroppedGold() {
    return this.droppedGold;
  }
  /**
   * Returns the name of the minion
   * @return the name
   */
  String getName() {
    return this.name;
  }
  /**
   * Sets the startPosition of this minion
   */
  void setStartPosition() {
    this.position = this.path[0];
  }
  /**
   * Sets the list of fields for the path the minion has to walk
   * @param path is the list of fields
   */
  void setPath(List<Field> path) {
    this.path = path;
  }
  /**
   * Returns the status if the minion has reached the end of the path and therefore destroyed a life
   * @return true if the minion destroyed a life, false if not
   */
  bool getDestroyedALife() {
    return this.destroyedALife;
  }
  /**
   * Sets the bool for destroying a life 
   * @param b is the bool to be set
   */
  void setDestroyedALife(bool b) {
    this.destroyedALife = b;
  }
}
