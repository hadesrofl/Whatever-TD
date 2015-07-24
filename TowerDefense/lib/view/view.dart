library view;

import "dart:html";

/**
   * This Class handles the appearance of our game and manipulates the DOM-Tree of HTML
   * 
   * @author Florian Winzek, René Kremer
   */
class View {
/**
   * The board as table. The board has a given size
   */
  TableElement _board;
  /**
   * Element to append the board to in the dom tree
   */
  Element _boardElement;
  /**
   * Element for the difficulty box
   */
  Element _difficulty;
  /**
   * Table for the Minion Info
   */
  TableElement _minionInfo;

/**
   * Constructor of the view
   * @param row is the integer of the rows
   * @param col is the integer of the cols
   */
  View(int row, int col) {
    _boardElement = querySelector("#board");
    _difficulty = querySelector("#difficulty");
    _minionInfo = querySelector("#minionInfo");
    hideNavigation();
    hideBuyMenu();
   hideCancelButton();
   hideBuyButton();
    hideUpgradeButton();
    hideSellButton();
    hideStopButton();
    hideRestartButton();
   hideHelpBox();
    hideTillWaveLabel();
    hideHelpGame();
    hideHelpTower();
    hideHelpArmor();
    setTowerToolTip();
  }
/**
   * Method to create a board 
   * @param row is the integer of the rows
   * @param col is the integer of the cols
   */
  void createBoard(int row, int col) {
    final table = new TableElement();
    for (int i = 0; i < row; i++) {
      table.append(new TableRowElement());
      for (int j = 0; j < col; j++) {
        // col.toString() + row.toString()
        final cellElement = new TableCellElement();
        cellElement.id = j.toString() + i.toString();
        table.children.elementAt(i).append(cellElement);
      }
    }
    this._board = table;
    _boardElement.append(this._board);
  }
/**
   * Method to update a board 
   * @param board - contains all current information which shall be displayed in the view
   */
  void updateBoard(Map<String, String> board) {
    for (int i = 0; i < this._board.children.length; i++) {
      for (int j = 0;
          j < this._board.children.elementAt(0).children.length;
          j++) {
        TableCellElement cell =
            this._board.children.elementAt(i).children.elementAt(j);
        cell.setInnerHtml(board[cell.id]);
      }
    }
  }
  /**
   * Sets an image to the view
   * @param id is the field id
   * @param objectName is the name of the object that shall be viewed as image
   */
 void setImageToView(String id, String objectName) {
    this._board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          children.classes.add(objectName);
        }
      });
    });
  }
 /**
  * Deletes an image from the view
   * @param id is the field id
   * @param objectName is the name of the object that shall be viewed as image
  */
  void deleteImage(String id, String objectName) {
    this._board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          children.attributes.remove("data-toggle");
          children.attributes.remove("title");
          if (children.classes.contains(objectName)) {
            children.classes.remove(objectName);
          }
          if (children.classes.contains(objectName + "2")) {
            children.classes.remove(objectName + "2");
          }
          if (children.classes.contains(objectName + "3")) {
            children.classes.remove(objectName + "3");
          }
        }
      });
    });
  }
  /**
   * Deletes an image on the last field of the path
   * @param id is the id of the field
   * Delets images when minions reach their last field on the board
   */
  void deleteImageOnLastPathField(String id) {
    this._board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          if (children.classes.length > 1) {
            children.attributes.remove("data-toggle");
            children.attributes.remove("title");
            children.classes.clear();
            children.classes.add("Path");
          }
        }
      });
    });
  }
  /**
   * Sets an upgrade image of a tower
   * @param id is the id of the field
   * @param towerName is the name of the tower
   * @param level is the number of the level of the tower
   * Sets images when a tower is upgraded
   */
  void upgradeImage(String id, String towerName, int level) {
    this._board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          children.classes.remove(towerName);
          switch (level) {
            case 2:
              children.classes.add(towerName + "2");
              break;
            case 3:
              children.classes.add(towerName + "3");
              break;
          }
        }
      });
    });
  }
  /**
   * Hides the difficulty menu
   * hides the menu with difficulties
   */
  void hideDifficultyMenu() {
   getEasyButton().hidden = true;
   getMediumButton().hidden = true;
   getHardButton().hidden = true;
   showBuyButton();
   showSellButton();
    showUpgradeButton();
    _difficulty.hidden = true;
  }
  /**
   * Shows the difficulty menu
   * shows the menu with difficulties
   */
  void showDifficultyMenu() {
    getEasyButton().hidden = false;
    getMediumButton().hidden = false;
    getHardButton().hidden = false;
    hideBuyButton();
    hideSellButton();
    hideUpgradeButton();
    _difficulty.hidden = false;
  }
  /**
   * Sets the tool tip of the towers
   */
  void setTowerToolTip() {
    getCanonTowerButton().setAttribute("title",
        "Price: 300\nBasicDamage: 7.0\nRange: 2\nDamageType: Siege\nWith Upgrade the values are multiplied by its level and current value(Level 2: x2 etc.)");
    getArrowTowerButton().setAttribute("title",
        "Price: 150\nBasicDamage: 5.0\nRange: 3\nDamageType: Piercing\nWith Upgrade the values are multiplied by its level and current value(Level 2: x2 etc.)");
    getFireTowerButton().setAttribute("title",
        "Price: 600\nBasicDamage: 10.0\nRange: 2\nDamageType: Fire\nSpecial Ability: does dmg/seconds\nWith Upgrade the values are multiplied by its level and current value (Level 2: x2 etc.)");
    getLightningTowerButton().setAttribute("title",
        "Price: 600\nBasicDamage: 10.0\nRange: 2\nDamageType: Lightning\nWith Upgrade the values are multiplied by its level and current value(Level 2: x2 etc.)");
  }
  /**
   * Sets the tool tip of a minion
   * @param name is the name of the minion
   * @param armor is the type of armor 
   * @param hitpoints is the amount of hitpoints it has at max
   * @param movementSpeed is the value of the movement speed in seconds
   * @param droppedGold is the amount of gold a minion drops
   *
   */
  void setMinionToolTip(String name, String armor, String hitpoints,
      String movementSpeed, String droppedGold) {
    TableCellElement m = new TableCellElement();
    m.setAttribute("data-toggle", "tooltip");
    m.setAttribute("title", name +
        "\n Armor= " +
        armor +
        "\n Hitpoints= " +
        hitpoints +
        "\n MovementSpeed= " +
        movementSpeed +
        "\n Dropped Gold= " +
        droppedGold);
    m.classes.add(name);
    if (_minionInfo.children.length != 0) {
      for (int i = 0; i < _minionInfo.children.length; i++) {
        if (_minionInfo.children[i].children.length < 4) {
          _minionInfo.children[i].append(m);
        } else {
          TableRowElement tr = new TableRowElement();
          this._minionInfo.append(tr);
          tr.append(m);
        }
      }
    } else {
      TableRowElement tr = new TableRowElement();
      this._minionInfo.append(tr);
      tr.append(m);
    }
  }
  /**
   * Clears all minion tool tips
   */
  void clearMinionToolTip() {
    _minionInfo.children.clear();
  }
  /**
   * Clears the board of all object images
   */
  void clearBoard() {
    this._board.children.forEach((c) {
      c.children.forEach((children) {
        children.classes.clear();
      });
    });
  }
  /**
   * Shows the Help Game Element
   */
  void showHelpGame(){
    querySelector("#helpGame").hidden = false;
  }
  /**
   * Hides the Help Game Element
   */
  void hideHelpGame(){
    querySelector("#helpGame").hidden = true;
  }
  /**
   * Returns if the element is hidden or not
   * @return true if it is hidden, else false
   */
  bool isHelpGameHidden(){
   return querySelector("#helpGame").hidden;
  }
  /**
   * Shows the Help Tower Element
   */
  void showHelpTower(){
    querySelector("#helpTower").hidden = false;
  }
  /**
   * Hides the Help Tower Element
   */
  void hideHelpTower(){
    querySelector("#helpTower").hidden = true;
  }
  /**
   * Returns if the element is hidden or not
   * @return true if it is hidden, else false
   */
  bool isHelpTowerHidden(){
    return querySelector("#helpTower").hidden;
  }
  /**
   * Shows the Help Armor Element
   */
  void showHelpArmor(){
    querySelector("#helpArmor").hidden = false;
  }
  /**
   * Hides the Help Armor Element
   */
  void hideHelpArmor(){
    querySelector("#helpArmor").hidden = true;
  }
  /**
   * Returns if the element is hidden or not
   * @return true if it is hidden, else false
   */
  bool isHelpArmorHidden(){
    return querySelector("#helpArmor").hidden;
  }
  /**
   * Gets the Help Button for the Game Rules. Can be used to set Listeners
   * @return the Help Button for the Game Rules
   */
  Element getHelpButtonGame(){
    return querySelector("#helpButtonGame");
  }
  /**
   * Gets the Help Button for the Tower Infos. Can be used to set Listeners
   * @return the Help Button for the Tower Infos
   */
  Element getHelpButtonTower(){
   return querySelector("#helpButtonTower");
  }
  /**
   * Gets the Help Button for the Armor Types. Can be used to set Listeners
   * @return the Help Button for the Armor Types
   */
  Element getHelpButtonArmor(){
    return querySelector("#helpButtonArmor");
  }
  /**
   * Shows the Buy Button
   */
  void showBuyButton(){
    querySelector("#buy").hidden = false;
  }
  /**
   * Hides the Buy Button
   */
  void hideBuyButton(){
    querySelector("#buy").hidden = true;
  }
  /**
   * Gets the Buy Button. Can be used to set Listeners
   * @return the buy button
   */
  Element getBuyButton(){
   return querySelector("#buy");
  }
  /**
   * Shows the Arrow Tower Button to buy an Arrow Tower
   */
  void showArrowTowerButton(){
    querySelector("#ArrowTower").hidden = false;
  }
  /**
   * Hides the Arrow Tower Button
   */
  void hideArrowTowerButton(){
    querySelector("#ArrowTower").hidden = true;
  }
  /**
   * Gets the Arrow Tower Button. Can be used to set Listeners
   * @return the Arrow Tower Button
   */
  Element getArrowTowerButton(){
    return querySelector("#ArrowTower");
  }
  /**
   * Shows the Canon Tower Button to buy Canon Towers
   */
  void showCanonTowerButton(){
    querySelector("#CanonTower").hidden = false;
  }
  /**
   * Hides the Canon Tower Button
   */
  void hideCanonTowerButton(){
    querySelector("#CanonTower").hidden = true;
  }
  /**
   * Gets the Canon Tower Button. Can be used to set Listeners
   * @return the Canon Tower Button
   */
  Element getCanonTowerButton(){
    return querySelector("#CanonTower");
  }
  /**
   * Shows the Fire Tower Button
   */
  void showFireTowerButton(){
    querySelector("#FireTower").hidden = false;
  }
  /**
   * Hides the Fire Tower Button
   */
  void hideFireTowerButton(){
    querySelector("#FireTower").hidden = true;
  }
  /**
   * Gets the Fire Tower Button. Can be used to set Listeners
   * @return the Fire Tower Button
   */
  Element getFireTowerButton(){
    return querySelector("#FireTower");
  }
  /**
   * Shows the Lightning Tower Button to buy Lightning Towers
   */
  void showLightningTowerButton(){
    querySelector("#LightningTower").hidden = false;
  }
  /**
   * Hides the Lightning Tower Button
   */
  void hideLightningTowerButton(){
    querySelector("#LightningTower").hidden = true;
  }
  /**
   * Gets the Lightning Tower Button . Can be used to set Listeners
   * @return the Lightning Tower Button
   */
  Element getLightningTowerButton(){
    return querySelector("#LightningTower");
  }
  /**
   * Shows the Cancel Button
   */
  void showCancelButton(){
    querySelector("#cancel").hidden = false;
  }
  /**
   * Hides the Cancel Button
   */
  void hideCancelButton(){
    querySelector("#cancel").hidden = true;
  }
  /**
   * Gets the Cancel Button. Can be used to set listeners
   * @®eturn the Cancel Button
   */
  Element getCancelButton(){
    return querySelector("#cancel");
  }
  /**
   * Shows the Sell Button
   */
  void showSellButton(){
    querySelector("#sell").hidden = false;
  }
  /**
   * Hides the Sell Button
   */
  void hideSellButton(){
    querySelector("#sell").hidden = true;
  }
  /**
   * Gets the Sell Button. Can be used to set Listeners
   * @return the sell button
   */
  Element getSellButton(){
   return querySelector("#sell");
  }
  /**
   * Shows the Upgrade Button
   */
  void showUpgradeButton(){
    querySelector("#upgrade").hidden = false;
  }
  /**
   * Hides the Upgrade Button
   */
  void hideUpgradeButton(){
    querySelector("#upgrade").hidden = true;
  }
  /**
   * Gets the Upgrade Button. Can be used to set Listeners
   * @return the Upgrade Button
   */
  Element getUpgradeButton(){
    return querySelector("#upgrade");
  }
  /**
   * Shows the Start Button
   */
  void showStartButton(){
    querySelector("#start").hidden = false;
  }
  /**
   * Hides the Start Button
   */
  void hideStartButton(){
    querySelector("#start").hidden = true;
  }
  /**
   * Gets the Start Button. Can be used to set Listeners
   * @return the Start Button
   */
  Element getStartButton(){
   return querySelector("#start");
  }
  /**
   * Gets the Easy Difficulty Button. Can be used to set Listeners
   * @return the Easy Button
   */
  Element getEasyButton(){
    return querySelector("#easyGame");
  } 
  /**
   * Gets the Medium Difficulty Button. Can be used to set Listeners
   * @return the Medium Button
   */
Element getMediumButton(){
  return querySelector("#mediumGame");
}
/**
 * Gets the Hard Difficulty Button. Can be used to set Listeners
 * @return the Hard Button
 */
Element getHardButton(){
  return querySelector("#hardGame");
}
  /**
   * Shows the Restart Button
   */
  void showRestartButton(){
    querySelector("#restart").hidden = false;
  }
  /**
   * Hides the Restart Button
   */
  void hideRestartButton(){
    querySelector("#restart").hidden = true;
  }
  /**
   * Gets the Restart Button. Can be used to set Listeners
   * @return the Restart Button
   */
  Element getRestartButton(){
    return  querySelector("#restart");
  }
  /**
   * Shows the Stop Button
   */
  void showStopButton(){
    querySelector("#stop").hidden = false;
  }
  /**
   * Hides the Stop Button
   */
  void hideStopButton(){
    querySelector("#stop").hidden = true;
  }
  /**
   * Gets the Stop Button. Can be used to set Listeners
   * @return the Stop Button
   */
  Element getStopButton(){
   return querySelector("#stop");
  }
  /**
   * Shows the Name Input Element
   */
  void showNameInput(){
    querySelector("#playerName").hidden = false;
  }
  /**
   * Hides the Name Input Element
   */
  void hideNameInput(){
    querySelector("#playerName").hidden = true;
  }
  /**
   * Gets the Text entered into the Name Input Element
   * @return 
   */
  String getNameInputText(){
   InputElement input =  querySelector("#playerName");
   return input.value;
  }
  /**
   * Shows the Navigation Area
   */
  void showNavigation(){
    querySelector("#navigation").hidden = false;
  }
  /**
   * Hides the Navigation Area
   */
  void hideNavigation(){
    querySelector("#navigation").hidden = true;
  }
  /**
   * Shows the Help Box
   */
  void showHelpBox(){
    querySelector("#helpBox").hidden = false;
  }
  /**
   * Hides the Help Box
   */
  void hideHelpBox(){
    querySelector("#helpBox").hidden = true;
  }
  void showTillWaveLabel(){
    querySelector("#time").hidden = false;
    querySelector("#timerhr").hidden = false;
  }
  void hideTillWaveLabel(){
    querySelector("#time").hidden = true;
    querySelector("#timerhr").hidden = true;
  }
  void setTillWaveLabel(String text){
    querySelector("#time").innerHtml = text;
  }
  /**
   * Sets the text for the player label
   * @param text is the text to set 
   */
  void setPlayerLabel(String text){
    querySelector("#playerLabel").innerHtml = text;
  }
  /**
   * Sets the text for the gold label
   * @param text is the text to set
   */
  void setGoldLabel(String text){
    querySelector("#gold").innerHtml = text;
  }
  /**
   * Sets the text for the point label
   * @param text is the text to set
   */
  void setPointLabel(String text){
    querySelector("#points").innerHtml = text;
  }
  /**
   * Sets the text for the life label
   * @param text is the text to set
   */
  void setLifeLabel(String text){
    querySelector("#life").innerHtml = text;
  }
  /**
   * Sets the text for the Level label
   * @param text is the text to set
   */
  void setLevelLabel(String text){
    querySelector("#level").innerHtml = text;
  }
  /**
   * Sets the text for the Wave label
   * @param text is the text to set
   */
  void setWaveLabel(String text){
    querySelector("#wave").innerHtml = text;
  }
  /**
   * Sets the text for the Minions left label
   * @param text is the text to set
   */
  void setMinionsLeftLabel(String text){
    querySelector("#minionsleft").innerHtml = text;
  }
  /**
   * Shows the Buy Menu
   */
  void showBuyMenu(){
    querySelector("#buyMenu").hidden = false;
  }
  /**
   * Hides the Buy Menu
   */
  void hideBuyMenu(){
    querySelector("#buyMenu").hidden = true;
  }
  /**
   * Gets a Table Row Element on the Board
   * @return a Table Row of that index
   */
  Element getTableRowInBoard(int i){
    return _board.children.elementAt(i);
  }
  /**
   * Gets a Table Data Element in the a Table Row Element
   * @return a Table Data Element
   */
  Element getTableDataInRow(Element tableRow, int i){
    return tableRow.children.elementAt(i);
  }
  /**
   * Sets the Game Over Text after the player lost the game
   */
  void setGameOver(){
    querySelector("#gameOver").style.color = "red";
    querySelector("#gameOver").innerHtml = "Game Over!";
  }
  /**
   * Sets the Congratz Text after the player won the game
   */
  void setCongratz(){
    querySelector("#gameOver").style.color = "white";
    querySelector("#gameOver").innerHtml = "Congratz, You won!";
  }
  /**
   * Clears the Game Over Tag
   */
  void clearGameOver(){
    querySelector("#gameOver").innerHtml = "";
  }
}
