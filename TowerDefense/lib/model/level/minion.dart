part of level;

/**
   * This class represents a minion object.
   */
class Minion {
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
  double movementSpeed;
  /**
   * List of conditions of this minion
   */
  List<Condition> conditions = new List<Condition>();
  /**
   * X-Coordinate for this minion on our board
   */
  /*
   int x;
    */
  /**
   * Y-Coordinate for this mininon on our board
   */
  /*
   int y;
   */
  /**
   * Position where the minion is
   */
  Field position;
  /**
   * Counter of rounds this minion is alive
   */
  int roundCounter;
  /**
   * Bool if minion is spawned right now or not
   */
  bool spawned;
  /**
   * Steps the minion took on the path (index for the path)
   */
  int stepsOnPath;

  /**
   * Constructor for a minion object
   * @param hitpoints - starting hitpoints a minion has
   * @param armor - type of armor a minion has
   * @param movementSpeed - how fast a minion moves
   * @param x - x-coordinate a minion is starting at
   * @param y - y-coordinate a minion is starting at
   */
  Minion(double hitpoints, Armor armor, double movementSpeed) {
    this.hitpoints = hitpoints;
    this.armor = armor;
    this.movementSpeed = movementSpeed;
    this.roundCounter = 0;
    this.stepsOnPath = 0;
    this.spawned = false;
  }
/**
   * Method to calculate hitpoints after getting hit by a tower
   * @param damage - damage object the tower is hitting him with
   */
  double calculateHitPoints(Damage damage) {
    double dmgToMinion = 0.0;
    switch (this.armor.value) {
      //Light Armor
      case 1:
        //DamageType = Siege
        if (damage.damageType == 1) {
          dmgToMinion = damage.getDamage() * 0.75;
          //DamageType = Piercing
        } else if (damage.damageType == 2) {
          dmgToMinion = damage.getDamage() * 1.25;
          //DamageType = Fire
        } else if (damage.damageType == 3) {
          dmgToMinion = damage.getDamage() * 1.25;
          //DamageType = Lightning
        } else if (damage.damageType == 4) {
          dmgToMinion = damage.getDamage() * 0.75;
        }
        break;
      //Medium Armor
      case 2:
        //DamageType = Siege
        if (damage.damageType == 1) {
          dmgToMinion = damage.getDamage() * 1.0;
          //DamageType = Piercing
        } else if (damage.damageType == 2) {
          dmgToMinion = damage.getDamage() * 1.0;
          //DamageType = Fire
        } else if (damage.damageType == 3) {
          dmgToMinion = damage.getDamage() * 0.75;
          //DamageType = Lightning
        } else if (damage.damageType == 4) {
          dmgToMinion = damage.getDamage() * 0.75;
        }
        break;
      //Heavy Armor
      case 3:
        //DamageType = Siege
        if (damage.damageType == 1) {
          dmgToMinion = damage.getDamage() * 1.25;
          //DamageType = Piercing
        } else if (damage.damageType == 2) {
          dmgToMinion = damage.getDamage() * 0.75;
          //DamageType = Fire
        } else if (damage.damageType == 3) {
          dmgToMinion = damage.getDamage() * 1.0;
          //DamageType = Lightning
        } else if (damage.damageType == 4) {
          dmgToMinion = damage.getDamage() * 1.25;
        }
        break;
      default:
        dmgToMinion = damage.getDamage() * 1.0;
        break;
    }
    /* There are conditions to apply */
    if (damage.applyCondition == true) {
      bool foundCondition = false;
      /* Case: Fire */
      if (damage.damageType == 3) {
        /* Minion has condition already? => reset Duration */
        conditions.forEach((c) {
          if (foundCondition == false) {
            if (c.getIdentifier().compareTo("Fire") == 0) {
              foundCondition = true;
              c.resetDuration();
            }
          }
        });
        /* Condition is new */
        if (foundCondition == false) {
          conditions.add(new Condition("Fire"));
        }
        /* Case: Lightning */
      } else if (damage.damageType == 4) {
        /* Minion has condition already? => reset Duration */
        conditions.forEach((c) {
          if (foundCondition == false) {
            if (c.getIdentifier().compareTo("Lightning") == 0) {
              foundCondition = true;
              c.resetDuration();
            }
          }
        });
        /* Condition is new */
        if (foundCondition == false) {
          conditions.add(new Condition("Lightning"));
        }
      }
      for (int i = 0; i < conditions.length; i++) {
        dmgToMinion += conditions.elementAt(i).apply();
        if (conditions.elementAt(i).getDuration() == 0) conditions.remove(i);
      }
      this.hitpoints -= dmgToMinion;
    }
    return this.hitpoints;
  }
  /**
   * Marks the minion as spawned
   */
  void spawn() {
    this.spawned = true;
  }
/**
   * Method to move a minion on the board
   */
  void move(Field position) {
    /** TODO: Check if this is all */
    this.position = position;
    incStepsOnPath();
    incRounds();
  }
/**
   * Method to increment round counter
   */
  void incRounds() {
    this.roundCounter++;
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
    for (int i = 0; i < conditions.length; i++) {
      if (conditions[i].equals(m.getConditions()[i])) {
        sameConditionCounter++;
      }
    }
    /* Check the rest of the attributes */
    if ((this.hitpoints == m.getHitpoints() &&
            this.armor.toString().compareTo(m.getArmor().toString()) == 0) &&
        this.movementSpeed == m.getMovementSpeed() &&
        this.position.equals(m.getPosition()) &&
        this.roundCounter == m.getRoundCounter() &&
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
/*
int getX(){
	return this.x;
}
void setX(int x){
	this.x = x;
}

int getY(){
	return this.y;
}
void setY(int y){
	this.y = y;
}
 */
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
  double getMovementSpeed() {
    return this.movementSpeed;
  }
  /**
   * Returns the round counter of this minion
   * @return the round counter
   */
  int getRoundCounter() {
    return this.roundCounter;
  }
  /**
   * Returns a list of all conditions this minion has
   * @return the list of conditions
   */
  List<Condition> getConditions() {
    return this.conditions;
  }
}
