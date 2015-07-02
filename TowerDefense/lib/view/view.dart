library view;

import "dart:html";

/**
   * This Class handles the appearance of our game and manipulates the DOM-Tree of HTML
   * 
   * @author Florian Winzek, René Kremer
   */
class View {
  /**
   * Buy button
   */
  ButtonElement buy;
  /**
   * Cancel button
   */
  ButtonElement cancel;
  /**
   * Sell button
   */
  ButtonElement sell;
  /**
   * Upgrade button
   */
  ButtonElement upgrade;
  /**
   * Canon Tower buy button
   */
  ButtonElement canonTower;
  /**
   * Arrow Tower buy button
   */
  ButtonElement arrowTower;
  /**
   * Lightning Tower buy button
   */
  ButtonElement lightningTower;
  /**
   * Fire Tower buy button
   */
  ButtonElement fireTower;
  /**
   * Table for the buy menu
   */
  TableElement buyMenu;
  /**
   * Helpbox Element
   */
  Element helpBox;
  /**
   * An inputElement so that the user can type in his name
   */
  InputElement nameInput;
  /**
   * Label for the name and points of a player
   */
  Element playerLabel;
  /**
   * Container of the menu
   */
  Element menuContainer;
/**
   * A start button to start or continue the game
   */
  ButtonElement start;
/**
   * A stop button if the player wants to stop the game
   */
  ButtonElement stop;
/**
   * The board as table. The board has a given size
   */
  TableElement board;
  /**
   * Element to append the board to in the dom tree
   */
  Element boardElement;
  /**
   * Rows for the Board
   */
  int row;
  /**
   * Columns for the Board
   */
  int col;
  /**
   * Button to choose level diffifculty "easy"
   */
  ButtonElement easy;
  /**
   * Button to choose level diffifculty "medium"
   */
  ButtonElement medium;
  /**
   * Button to choose level diffifculty "hard"
   */
  ButtonElement hard;
  /**
   * Element for the difficulty box
   */
  Element difficulty;
  /**
   * Help button of the game help
   */
  ButtonElement helpButtonGame;
  /**
   * Help button of the tower help
   */
  ButtonElement helpButtonTower;
  /**
   * Help button of the armor help
   */
  ButtonElement helpButtonArmor;
  /**
   * Restart button
   */
  ButtonElement restart;
  /**
   * Element for the Countdown till a wave starts
   */
  Element tillWave;
  /**
   * Element for the the help text of the game
   */
  Element helpGame;
  /**
   * Element for the help text of the tower types
   */
  Element helpTower;
  /**
   * Element for help text of the armor types
   */
  Element helpArmor;
  /**
   * Table for the Minion Info
   */
  TableElement minionInfo;
  /**
   * Counter for the current items on the row
   */
  int minionInfoRowCounter = 0;
  /**
   * Label for the points
   */
  Element points;
  /**
   * Label for the gold
   */
  Element gold;
  /**
   * Label for the life
   */
  Element life;
  /**
   * Horizontal line of time
   */
  Element timerhr;
  /**
   * Label for the level
   */
  Element level;
  /**
   * Label for the wave
   */
  Element wave;
  /**
   * Label for the minions that are left of this wave
   */
  Element minionsLeft;
  /**
   * Container for the difficulty button
   */
  Element difficultyContainer;

/**
   * Constructor of the view
   * @param row is the integer of the rows
   * @param col is the integer of the cols
   */
  View(int row, int col) {
    this.row = row;
    this.col = col;
    nameInput = querySelector("#playerName");
    start = querySelector("#start");
    stop = querySelector("#stop");
    boardElement = querySelector("#board");
    playerLabel = querySelector("#playerLabel");
    menuContainer = querySelector("#navigation");
    buyMenu = querySelector("#buyMenu");
    buy = querySelector("#buy");
    cancel = querySelector("#cancel");
    sell = querySelector("#sell");
    upgrade = querySelector("#upgrade");
    canonTower = querySelector("#CanonTower");
    arrowTower = querySelector("#ArrowTower");
    lightningTower = querySelector("#LightningTower");
    fireTower = querySelector("#FireTower");
    easy = querySelector("#easyGame");
    medium = querySelector("#mediumGame");
    hard = querySelector("#hardGame");
    difficulty = querySelector("#difficulty");
    helpButtonGame = querySelector("#helpButtonGame");
    helpBox = querySelector("#helpBox");
    restart = querySelector("#restart");
    tillWave = querySelector("#time");
    helpGame = querySelector("#helpGame");
    minionInfo = querySelector("#minionInfo");
    points = querySelector("#points");
    gold = querySelector("#gold");
    life = querySelector("#life");
    timerhr = querySelector("#timerhr");
    level = querySelector("#level");
    wave = querySelector("#wave");
    minionsLeft = querySelector("#minionsleft");
    helpTower = querySelector("#helpTower");
    helpArmor = querySelector("#helpArmor");
    helpButtonTower = querySelector("#helpButtonTower");
    helpButtonArmor = querySelector("#helpButtonArmor");
    menuContainer.hidden = true;
    buyMenu.hidden = true;
    cancel.hidden = true;
    buy.hidden = true;
    upgrade.hidden = true;
    sell.hidden = true;
    helpButtonGame.hidden = true;
    stop.hidden = true;
    restart.hidden = true;
    helpBox.hidden = true;
    tillWave.hidden = true;
    timerhr.hidden = true;
    helpGame.hidden = true;
    helpTower.hidden = true;
    helpArmor.hidden = true;
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
    this.board = table;
    boardElement.append(this.board);
  }
/**
   * Method to update a board 
   * @param board - contains all current information which shall be displayed in the view
   */
  void updateBoard(Map<String, String> board) {
    for (int i = 0; i < this.board.children.length; i++) {
      for (int j = 0;
          j < this.board.children.elementAt(0).children.length;
          j++) {
        TableCellElement cell =
            this.board.children.elementAt(i).children.elementAt(j);
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
    this.board.children.forEach((c) {
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
    this.board.children.forEach((c) {
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
    this.board.children.forEach((c) {
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
    this.board.children.forEach((c) {
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
    hard.hidden = true;
    medium.hidden = true;
    easy.hidden = true;
    buy.hidden = false;
    sell.hidden = false;
    upgrade.hidden = false;
    difficulty.hidden = true;
  }
  /**
   * Shows the difficulty menu
   * shows the menu with difficulties
   */
  void showDifficultyMenu() {
    hard.hidden = false;
    medium.hidden = false;
    easy.hidden = false;
    buy.hidden = true;
    sell.hidden = true;
    upgrade.hidden = true;
    difficulty.hidden = false;
  }
  /**
   * Sets the tool tip of the towers
   */
  void setTowerToolTip() {
    canonTower.setAttribute("title",
        "Price: 300\nBasicDamage: 7.0\nRange: 2\nDamageType: Siege\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
    arrowTower.setAttribute("title",
        "Price: 150\nBasicDamage: 5.0\nRange: 3\nDamageType: Piercing\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
    fireTower.setAttribute("title",
        "Price: 1000\nBasicDamage: 10.0\nRange: 2\nDamageType: Fire\nSpecial Ability: does dmg/seconds\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
    lightningTower.setAttribute("title",
        "Price: 1000\nBasicDamage: 10.0\nRange: 2\nDamageType: Lightning\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
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
    if (minionInfo.children.length != 0) {
      for (int i = 0; i < minionInfo.children.length; i++) {
        if (minionInfo.children[i].children.length < 4) {
          minionInfo.children[i].append(m);
        } else {
          TableRowElement tr = new TableRowElement();
          this.minionInfo.append(tr);
          tr.append(m);
        }
      }
    } else {
      TableRowElement tr = new TableRowElement();
      this.minionInfo.append(tr);
      tr.append(m);
    }
  }
  /**
   * Clears all minion tool tips
   */
  void clearMinionToolTip() {
    minionInfo.children.clear();
  }
  /**
   * Clears the board of all object images
   */
  void clearBoard() {
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        children.classes.clear();
      });
    });
  }
}
