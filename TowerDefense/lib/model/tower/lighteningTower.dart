part of tower;

class lighteningTower extends tower{
  bool overloaded;
  
  lighteningTower(int x,int y, int range,int attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,target target,damage damage, this.overloaded):
    super(x,y,range,attackField,price,sellingPrice,upgradeLevel,attackSpeed,target,damage);
  
}