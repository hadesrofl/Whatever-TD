part of tower;

class Tower {
  int range;
  int price;
  int sellingPrice;
  int upgradeLevel;
  double attackSpeed;
  Target target;
  Damage damage;
  Field position;
  double basicDamage;
  int damageType;
  List<Field> attackFields;

  Tower() {
    //int price, int sellingPrice, int upgradeLevel,
    //      double basicDamage, int damageType
    //this.setRange(3);
    //this.setPrice(100);
    //this.setSellingPrice(sellingPrice);
    //this.setUpgradeLevel(upgradeLevel);
    //this.setBasicDamage(basicDamage);
    //this.damageType = 1;
  }
/**
 * 
 */
  Target shoot(List<Minion> minions) {
    minions.forEach((minion) {
      attackFields.forEach((fields) {
        if (minion.getPosition().equals(fields)) {
          this.damage = new Damage(this.getBasicDamage(), this.damageType,
              this.abilityCalculation());
          this.target = new Target(this.damage, minion);
          return this.target;
        }
      });
    });
    return null;
  }
  
  void findFieldsToAttack(Map<String, Field> board, final row, final col) {
    int startX = this.getPosition().getX() - this.getRange();
    int startY = this.getPosition().getY() - this.getRange();
    int endX = this.getPosition().getX() + this.getRange();
    int endY = this.getPosition().getY() + this.getRange();

    if (startX < 0) startX = 1;
    if (startY < 0) startY = 1;
    if (endX > row) endX = row;
    if (endY > col) endY = col;
    // runtime O(n^3) because we are working on objects, so we cannot instantiate
    // new field objects
    for (int x = startX; x <= endX; x++) {
      for (int y = startY; y <= endY; y++) {
        board.forEach((str, field) {
          if (field.getX() == x && field.getY() == y) this.attackFields
              .add(field);
        });
      }
    }
  }

  void setCoordinates(Field f) {
    position = f;
  }

  /**
   * Upgrades the tower with the upcoming level factor
   */
  void upgrade() {
    this.setPrice(this.getPrice() + (500 * this.getUpgradeLevel()));
    this.setAttackSpeed(this.getAttackSpeed() * (this.getUpgradeLevel() + 1));
    this.setRange(this.getRange() + (this.getUpgradeLevel() + 1));
    this.setUpgradeLevel(this.getUpgradeLevel() + 1);
    this.setSellingPrice(this.getSellingPrice() * (this.getUpgradeLevel() + 1));
    this.setBasicDamage(this.getBasicDamage() * (this.getUpgradeLevel() + 1));
  }

  bool abilityCalculation() {
    return true;
  }

  // --------------getter-/setter methods-----------------//

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
  void setDmgType(int dmgType){
    this.damageType = dmgType;
  }

  /*
   * 
   */
  int newPriceAfterUpgrade() {
    return this.getPrice() + (this.getUpgradeLevel() * 500);
  }
}
