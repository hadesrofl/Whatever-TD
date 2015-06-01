part of tower;
class ArrowTower extends Tower{
  
  ArrowTower(Field attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,Target target,Damage damage):
        super(4,attackField,price,sellingPrice,upgradeLevel);
}