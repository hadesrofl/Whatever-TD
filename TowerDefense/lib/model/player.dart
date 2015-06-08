class Player {
  String name;
  int gold;
  int highscore;

  Player(String name) {
    this.setName(name);
    this.setGold(5000);
    this.setHighscore(0);
  }
  String getName() {
    return this.name;
  }
  void setName(String name) {
    this.name = name;
  }
  int getGold() {
    return this.gold;
  }
  void setGold(int gold) {
    this.gold = gold;
  }
  int getHighscore() {
    return this.highscore;
  }
  void setHighscore(int highscore) {
    this.highscore = highscore;
  }
}
