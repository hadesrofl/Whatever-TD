part of tower;

class canonTower extends tower{
  int splashRadius;
  
  canonTower(int x,int y, int range,int attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,target target,damage damage, this.splRad):
    super(x,y,range,attackField,price,sellingPrice,upgradeLevel,attackSpeed,target,damage);
  
}