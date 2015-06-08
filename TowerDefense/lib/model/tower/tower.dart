part of tower;

class Tower {
  /**
   * Name of the Tower
   */
  String name;
  /**
   * 
   */
  int range;
  /**
   * 
   */
  int price;
  /**
   * 
   */
  int sellingPrice;
  /**
   * 
   */
  int upgradeLevel;
  /**
   * 
   */
  double attackSpeed;
  /**
   * 
   */
  Target target;
  /**
   * 
   */
  Damage damage;
  /**
   * 
   */
  Field position;
  /**
   * 
   */
  double basicDamage;
  /**
   * 
   */
  int damageType;
  /**
   * 
   */
  List<Field> attackFields;
  /**
   * 
   */
  bool ability;
  /**
   * 
   */
  int abilityFactor;

  Target shoot(List<Minion> minions) {
    minions.forEach((minion) {
      attackFields.forEach((fields) {
        if (minion.getPosition().equals(fields)) {
          this.damage = new Damage(this.getBasicDamage(), this.damageType,
              this.abilityCalculation());
          this.target = new Target(this.damage, minion);
        }
      });
    });
    return this.target;
  }

  void findFieldsToAttack(Map<Field, String> board, final row, final col) {
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
        board.forEach((field, str) {
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
    this.setUpgradeLevel(this.getUpgradeLevel() + 1);
    this.setPrice(this.getPrice() + (500 * this.getUpgradeLevel()));
    this.setAttackSpeed(this.getAttackSpeed() * (this.getUpgradeLevel()));
    this.setRange(this.getRange() + (this.getUpgradeLevel()));
    this.setSellingPrice(this.getSellingPrice() * (this.getUpgradeLevel()));
    this.setBasicDamage(this.getBasicDamage() * (this.getUpgradeLevel()));
    this.setAbilityFactor(this.getAbilityFactor() + 5);
  }

  bool abilityCalculation() {
    Random r = new Random();
    if (r.nextInt(100) < this.getAbilityFactor()) return true;
    return false;
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
  void setName(String name){
    this.name = name;
  }

  /*
   * TODO: 500 need to be fixed by this.getPrice()
   */
  int newPriceAfterUpgrade() {
    return this.getPrice() + (this.getUpgradeLevel() * 500);
  }
}
