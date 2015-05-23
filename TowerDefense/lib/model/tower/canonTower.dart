part of tower;

class CanonTower extends Tower{
  int splashRadius;
  
  CanonTower(int x,int y, int range,int attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,target target,damage damage, this.splRad):
    super(x,y,range,attackField,price,sellingPrice,upgradeLevel,attackSpeed,target,damage);
  
}