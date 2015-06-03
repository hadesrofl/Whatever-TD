part of tower;

class CanonTower extends Tower {
  int splashRadius;
  CanonTower() {
    this.setRange(4);
    this.setPrice(100);
    this.setSellingPrice(70);
    this.setUpgradeLevel(1);
    this.setAttackSpeed(1.1);
    this.setBasicDamage(20.0);
    this.setDmgType(1);
  }
  int getSplashRadius(){
    return this.splashRadius;
  }
  void setSplashRadius(int spR){
    this.splashRadius = spR;
  }
}
