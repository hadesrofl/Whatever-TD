part of game;

class Player {
  String _name;
  int _gold;
  int _highscore;

  Player(String name) {
    this.setName(name);
    this.setGold(2000);
    this.setHighscore(0);
  }
  String getName() {
    return this._name;
  }
  void setName(String name) {
    this._name = name;
  }
  int getGold() {
    return this._gold;
  }
  void setGold(int gold) {
    this._gold = gold;
  }
  int getHighscore() {
    return this._highscore;
  }
  void setHighscore(int highscore) {
    this._highscore = highscore;
  }
}
