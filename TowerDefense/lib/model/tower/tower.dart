part of tower;

/**
 * Instance of a Tower
 * 
 * @author Florian Winzek
 * 
 */
class Tower {
  /**
   * Name of the Tower
   */
  String name;
  /**
   * Range of the Tower
   */
  int range;
  /**
   * Buying price
   */
  int price;
  /**
   * Selling Price
   */
  int sellingPrice;
  /**
   * Level of the Tower
   */
  int upgradeLevel;
  /**
   * Attack Speed
   */
  double attackSpeed;
  /**
   * The Target which the Tower is shooting at
   */
  Target target;
  /**
   * Object of a Damage Class of the Tower
   */
  Damage damage;
  /**
   * Position on the board
   */
  Field position;
  /**
   * basic Damage
   */
  double basicDamage;
  /**
   * given Type of Damage
   */
  int damageType;
  /**
   * all the Fields on the Board, which the Tower can shoot
   */
  List<Field> attackFields = new List<Field>();
  /**
   * a special ability 
   */
  bool ability;
  /**
   * amount of ability power
   */
  int abilityFactor;

  /**
  * Selects a Minion to shoot at
  * 
  * @param minions list of minions which the tower can shoot
  * 
  * @return a Target object with a chosen minion 
  * and damage/condition from the tower
  */
  Target shoot(List<Minion> minions) {
    bool check = false;
    minions.forEach((minion) {
      if (!check) {
        attackFields.forEach((fields) {
          if (!check) {
            if (minion.getPosition().equals(fields)) {
              Condition con = null;
              if (this.getAbility() != null || this.getAbility() != false) {
                this.damage = new Damage(this.getBasicDamage(), this.damageType,
                    this.abilityCalculation());
                if (this.damage.applyCondition == true) {
                  switch (this.name) {
                    case "FireTower":
                      con = new Condition("Fire");
                      break;
                    case "LightningTower":
                      con = new Condition("Lightning");
                      break;
                    default:
                      con = null;
                      break;
                  }
                }
              } else {
                this.damage =
                    new Damage(this.getBasicDamage(), this.damageType, false);
              }
              this.target = new Target(this.damage, minion, con);
              check = true;
            } else {
              this.target = null;
            }
          }
        });
      }
    });
    return this.target;
  }
/**
 * Calculates all the fields on the board which the tower can aim at
 * 
 * @param board the playground
 * @param row number of rows of the board
 * @param col number of colums of the board
 */
  void findFieldsToAttack(Map<Field, String> board, final row, final col) {
    int startX = this.getPosition().getX() - this.getRange();
    int startY = this.getPosition().getY() - this.getRange();
    int endX = this.getPosition().getX() + this.getRange();
    int endY = this.getPosition().getY() + this.getRange();
    if (startX < 0) startX = 0;
    if (startY < 0) startY = 0;
    if (endX > row) endX = row;
    if (endY > col) endY = col;
    // runtime O(n^3) because we are working on objects, so we cannot instantiate
    // new field objects
    for (int x = startX; x <= endX; x++) {
      for (int y = startY; y <= endY; y++) {
        board.forEach((field, str) {
          if (field.getX() == x && field.getY() == y) {
            this.attackFields.add(field);
          }
        });
      }
    }
  }

  /**
   * Upgrades the tower with the upcoming level factor
   */
  void upgrade() {
    this.setUpgradeLevel(this.getUpgradeLevel() + 1);
    this.setPrice(this.getPrice() + (500 * this.getUpgradeLevel()));
    this.setAttackSpeed(this.getAttackSpeed() * (this.getUpgradeLevel()));
    this.setRange(this.getRange() + (this.getUpgradeLevel()));
    this.setSellingPrice(this.getSellingPrice() * (this.getUpgradeLevel()));
    this.setBasicDamage(this.getBasicDamage() * (this.getUpgradeLevel()));
    if (this.name != "ArrowTower") this
        .setAbilityFactor(this.getAbilityFactor() + 5);
  }
/**
 * Checks if the tower can do ability Damage
 */
  bool abilityCalculation() {
    if (this.getAbilityFactor() == null) {
      return false;
    } else {
      Random r = new Random();
      if (r.nextInt(100) < this.getAbilityFactor()) {
        return true;
      } else {
        return false;
      }
    }
  }

  // --------------getter-/setter methods-----------------//

  void setCoordinates(Field f) {
    position = f;
  }
  int getRange() {
    return this.range;
  }
  void setRange(int range) {
    this.range = range;
  }
  int getPrice() {
    return this.price;
  }
  void setPrice(int price) {
    this.price = price;
  }
  int getSellingPrice() {
    return this.sellingPrice;
  }
  void setSellingPrice(int p) {
    this.sellingPrice = p;
  }
  int getUpgradeLevel() {
    return this.upgradeLevel;
  }
  void setUpgradeLevel(int ul) {
    this.upgradeLevel = ul;
  }
  double getAttackSpeed() {
    return this.attackSpeed;
  }
  void setAttackSpeed(double as) {
    this.attackSpeed = as;
  }
  double getBasicDamage() {
    return this.basicDamage;
  }
  void setBasicDamage(double bSD) {
    this.basicDamage = bSD;
  }
  Field getPosition() {
    return this.position;
  }
  void setDmgType(int dmgType) {
    this.damageType = dmgType;
  }
  bool getAbility() {
    return this.ability;
  }
  void setAbility(bool ability) {
    this.ability = ability;
  }
  int getAbilityFactor() {
    return this.abilityFactor;
  }
  void setAbilityFactor(int abF) {
    this.abilityFactor = abF;
  }
  void setName(String name) {
    this.name = name;
  }

  /*
   * TODO: 500 need to be fixed by this.getPrice()
   */
  int newPriceAfterUpgrade() {
    return this.getPrice() + (this.getUpgradeLevel() * 500);
  }
}
