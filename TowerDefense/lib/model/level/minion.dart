part of level;


/**
   * This class represents a minion object.
   */
 class Minion{
	/**
   * Hitpoints of this minion. If <= 0 minion dies
   */ 
  double hitpoints;
  /**
   * Armor type of minion
   */ 
  Armor armor;
  /**
   * Speed of minion
   */ 
  double movementSpeed;
  /**
   * List of conditions of this minion
   */ 
  List<Condition> conditions = new List<Condition>();
  /**
   * X-Coordinate for this minion on our board
   */ 
  int x;
  /**
   * Y-Coordinate for this mininon on our board
   */ 
  int y;
  /**
   * Counter of rounds this minion is alive
   */ 
  int roundCounter;
  /**
   * Bool if minion is spawned right now or not
   */ 
  bool spawned;
  
  /**
   * Constructor for a minion object
   * @param hitpoints - starting hitpoints a minion has
   * @param armor - type of armor a minion has
   * @param movementSpeed - how fast a minion moves
   * @param x - x-coordinate a minion is starting at
   * @param y - y-coordinate a minion is starting at
   */ 
Minion(double hitpoints, Armor armor, double movementSpeed, int x, int y){
  this.hitpoints = hitpoints;
  this.armor = armor;
  this.movementSpeed = movementSpeed;
  this.x = x;
  this.y = y;
  this.roundCounter = 1;
  this.spawned = true;
}
/**
   * Method to calculate hitpoints after getting hit by a tower
   * @param damage - damage object the tower is hitting him with
   */ 
void calculateHitPoints(Damage damage){
	double dmgToMinion = 0.0;
	switch(this.armor.value){
		//Light Armor
		case 1:
			//DamageType = Siege
			if(damage.damageType == 1){
				dmgToMinion = damage.getDamage() * 0.75;
			//DamageType = Piercing	
			}else if(damage.damageType == 2){
				dmgToMinion = damage.getDamage() * 1.25;
			//DamageType = Fire	
			}else if(damage.damageType == 3){
				dmgToMinion = damage.getDamage() * 1.25;
			//DamageType = Lightning
			}else if(damage.damageType == 4){
				dmgToMinion = damage.getDamage() * 0.75;
			}
			break;
		//Medium Armor
		case 2:
			//DamageType = Siege
			if(damage.damageType == 1){
				dmgToMinion = damage.getDamage() * 1.0;
			//DamageType = Piercing	
			}else if(damage.damageType == 2){
				dmgToMinion = damage.getDamage() * 1.0;
			//DamageType = Fire	
			}else if(damage.damageType == 3){
				dmgToMinion = damage.getDamage() * 0.75;
			//DamageType = Lightning
			}else if(damage.damageType == 4){
				dmgToMinion = damage.getDamage() * 0.75;
			}
			break;
		//Heavy Armor
		case 3:
		//DamageType = Siege
			if(damage.damageType == 1){
				dmgToMinion = damage.getDamage() * 1.25;
			//DamageType = Piercing	
			}else if(damage.damageType == 2){
				dmgToMinion = damage.getDamage() * 0.75;
			//DamageType = Fire	
			}else if(damage.damageType == 3){
				dmgToMinion = damage.getDamage() * 1.0;
			//DamageType = Lightning
			}else if(damage.damageType == 4){
				dmgToMinion = damage.getDamage() * 1.25;
			}
			break;
		default:
		dmgToMinion = damage.getDamage() * 1.0;
		break;
	}
	if(damage.applyCondition == true){
		if(damage.damageType == 3){
			//TODO: List contains Fire Condition? => reset Duration
			conditions.add(new Condition("Fire"));
		}else if(damage.damageType == 4){
			//TODO: List contains Lightning Condition? => reset Duration
			conditions.add(new Condition("Lightning"));
		}
	}
	for(int i = 0; i < conditions.length;i++){
		dmgToMinion += conditions.elementAt(i).apply();
		if(conditions.elementAt(i).getDuration() == 0) conditions.remove(i);
	}
	this.hitpoints -= dmgToMinion;
}
/**
   * Method to move a minion on the board
   */ 
void move(){
	if(roundCounter > 1) spawned = false;
	//TODO: Do Fancy Movement Stuff
	incRounds();
}
/**
   * Method to increment round counter
   */ 
void incRounds(){
	this.roundCounter++;
}
//---------------Getter and Setter Methods---------------------//
double getHitpoints(){
	return this.hitpoints;
}
int getX(){
	return this.x;
}
void setX(int x){
	this.x = x;
}
int getY(){
	return this.y;
}
void setY(int y){
	this.y = y;
}
}