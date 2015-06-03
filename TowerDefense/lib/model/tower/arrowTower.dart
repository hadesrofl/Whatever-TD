part of tower;
class ArrowTower extends Tower{
  Target target;
  
  ArrowTower(Field attackField,int price,int sellingPrice,
      int upgradeLevel,double attackSpeed,Target target,Damage damage, double basicDamage):
        super(4,attackField,price,sellingPrice,upgradeLevel, basicDamage){
  }
  
}