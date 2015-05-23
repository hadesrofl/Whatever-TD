part of level;
/**
 * This class represents a wave object. A wave has a specific number of minions. 
 * Many waves together are one level
 */
class Wave{
  /**
   * Number of the wave
   */
  int waveNumber;
  /**
   * The number of minions of this wave
   */
  int numberOfMinions;
  /**
   * Is this wave the final wave of the level or not
   */
  bool finalWave;
  
  /**
   * Constructor of a wave object
   * @param identifier - number of this wave
   * @param numberOfMinions - how many minions this wave has
   * @param finalWave - true if this is the final wave of the level, false if not
   */
  Wave(int waveNumber, int numberOfMinions, bool finalWave){
    this.waveNumber = waveNumber;
    this.numberOfMinions = numberOfMinions;
    this.finalWave = finalWave;
  }
  /**
   * Method to decrease the number of Minions
   */
  void decMinions(){
    this.numberOfMinions--;
  }
  //---------------Getter and Setter Methods---------------------//
  bool isFinalWave(){
	  return this.finalWave;
  }
  int getWaveNumber(){
	  return this.waveNumber;
	  
  }
}