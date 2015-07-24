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
  String _name;
  /**
   * Range of the Tower
   */
  int _range;
  /**
   * Buying price
   */
  int _price;
  /**
   * Selling Price
   */
  int _sellingPrice;
  /**
   * Level of the Tower
   */
  int _upgradeLevel;
  /**
   * Attack Speed
   */
  double _attackSpeed;
  /**
   * The Target which the Tower is shooting at
   */
  Target _target;
  /**
   * Object of a Damage Class of the Tower
   */
  Damage _damage;
  /**
   * Position on the board
   */
  Field _position;
  /**
   * basic Damage
   */
  double _basicDamage;
  /**
   * given Type of Damage
   */
  int _damageType;
  /**
   * all the Fields on the Board, which the Tower can shoot
   */
  List<Field> _attackFields = new List<Field>();
  /**
   * a special ability 
   */
  bool _ability;
  /**
   * amount of ability power
   */
  int _abilityFactor;

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
        _attackFields.forEach((fields) {
          if (!check) {
            if (minion.getPosition().equals(fields)) {
              Condition con = null;
              if (this.getAbility() != null || this.getAbility() != false) {
                this._damage = new Damage(this.getBasicDamage(), this._damageType,
                    this.abilityCalculation());
                if (this._damage._applyCondition == true) {
                  switch (this._name) {
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
                this._damage =
                    new Damage(this.getBasicDamage(), this._damageType, false);
              }
              this._target = new Target(this._damage, minion, con);
              check = true;
            } else {
              this._target = null;
            }
          }
        });
      }
    });
    return this._target;
  }
/**
 * Calculates all the fields on the board which the tower can aim at
 * 
 * @param board the playground
 * @param row number of rows of the board
 * @param col number of colums of the board
 */
  void findFieldsToAttack(List<Field> board, final row, final col) {
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
        board.forEach((field) {
          if (field.getX() == x && field.getY() == y) {
            this._attackFields.add(field);
          }
        });
      }
    }
  }

  /**
   * Upgrades the tower with the upcoming level factor
   */
  void upgrade() {
    this.setPrice(this.newPriceAfterUpgrade());
    this.setUpgradeLevel(this.getUpgradeLevel() + 1);
    this.setAttackSpeed(this.getAttackSpeed() * (this.getUpgradeLevel()));
    this.setRange(this.getRange() + 1);
    this.setSellingPrice(this.getSellingPrice() * (this.getUpgradeLevel()));
    this.setBasicDamage(this.getBasicDamage() * (this.getUpgradeLevel()));
    if (this._name != "ArrowTower") this
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
    _position = f;
  }
  int getRange() {
    return this._range;
  }
  void setRange(int range) {
    this._range = range;
  }
  int getPrice() {
    return this._price;
  }
  void setPrice(int price) {
    this._price = price;
  }
  int getSellingPrice() {
    return this._sellingPrice;
  }
  void setSellingPrice(int p) {
    this._sellingPrice = p;
  }
  int getUpgradeLevel() {
    return this._upgradeLevel;
  }
  void setUpgradeLevel(int ul) {
    this._upgradeLevel = ul;
  }
  double getAttackSpeed() {
    return this._attackSpeed;
  }
  void setAttackSpeed(double as) {
    this._attackSpeed = as;
  }
  double getBasicDamage() {
    return this._basicDamage;
  }
  void setBasicDamage(double bSD) {
    this._basicDamage = bSD;
  }
  Field getPosition() {
    return this._position;
  }
  void setDmgType(int dmgType) {
    this._damageType = dmgType;
  }
  bool getAbility() {
    return this._ability;
  }
  void setAbility(bool ability) {
    this._ability = ability;
  }
  int getAbilityFactor() {
    return this._abilityFactor;
  }
  void setAbilityFactor(int abF) {
    this._abilityFactor = abF;
  }
  void setName(String name) {
    this._name = name;
  }
  String getName(){
    return this._name;
  }

  /*
   * TODO: 500 need to be fixed by this.getPrice()
   */
  int newPriceAfterUpgrade() {
    return (this.getUpgradeLevel() + 1) * this._price;
  }
}
