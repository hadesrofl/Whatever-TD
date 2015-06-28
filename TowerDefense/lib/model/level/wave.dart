part of level;

/**
 * This class represents a wave object. A wave has a specific number of minions. 
 * Many waves together are one level
 */
class Wave {
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
   * the number of slain minions of this wave
   */
  int deadMinions;
  /**
   * Minions leaked to the end of the map
   */
  int leakedMinions;
  /**
   * List of Minions of this wave
   */
  List<Minion> minions = new List<Minion>();

  /**
   * Constructor of a wave object
   * @param identifier - number of this wave
   * @param numberOfMinions - how many minions this wave has
   * @param finalWave - true if this is the final wave of the level, false if not
   */
  Wave(int waveNumber, bool finalWave) {
    this.waveNumber = waveNumber;
    this.finalWave = finalWave;
    this.deadMinions = 0;
    this.leakedMinions = 0;
    this.numberOfMinions = 0;
  }
  /**
   * Method to decrease the number of Minions
   */
  void decMinions() {
    this.numberOfMinions--;
  }
  /**
   * Method to increase the number of slain minions
   */
  void incDeadMinions() {
    this.deadMinions++;
  }
  /**
   * Checks if the wave is clear
   * @return true if all minions are dead else false
   */
  bool isWaveClear() {
    bool waveClear;
    if (numberOfMinions == deadMinions + leakedMinions) {
      waveClear = true;
    } else {
      waveClear = false;
    }
    return waveClear;
  }
  /**
   * ---------------Getter and Setter Methods---------------------
   */
  /**
   * Returns the finalWave as bool
   * @return TRUE if it is the finalWave else FALSE
   */
  bool isFinalWave() {
    return this.finalWave;
  }
  /**
   * Returns the number of the wave
   * @return number of this wave and level
   */
  int getWaveNumber() {
    return this.waveNumber;
  }
  /**
   * Returns the number of total minions of this wave
   * @return number of the minions of this wave
   */
  int getNumberOfMinions() {
    return this.numberOfMinions;
  }
  /**
   * Returns the number of slain minions of this wave
   * @return number of the slain minions
   */
  int getDeadMinions() {
    return this.deadMinions;
  }
  /**
   * Gets a list of all minions but only once
   * @return a list of distinct minions of this wave
   */
  List<Minion> getDistinctMinions(){
    bool found;
    List<Minion> distinct = new List<Minion>();
    if(this.minions.length > 0){
    this.minions.forEach((m){
      found = false;
      /* List is not empty */
      if(distinct.length > 0){
        /* Compare all minions to the already added distinct minions */
        distinct.forEach((dm){
         if(m.getName().compareTo(dm.getName()) == 0){
           found = true;
        }});
      }else{
        found = true;
        distinct.add(m);
      }
      if(found != true){
        distinct.add(m);
      }
    });
    }
    return distinct;
  }
  /**
   * Gets the minions of this wave
   * @return a list of all minions of this wave
   */
  List<Minion> getMinions(){
    return this.minions;
  }
  void addMinion(Minion m){
    this.minions.add(m);
    this.numberOfMinions++;
  }
  void incLeakedMinions(){
    this.leakedMinions++;
  }
}
