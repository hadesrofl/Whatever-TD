library view;

import "dart:html";

/**
   * This Class handles the appearance of our game and manipulates the DOM-Tree of HTML
   */
class View {
  ButtonElement buy;
  ButtonElement cancel;
  ButtonElement sell;
  ButtonElement upgrade;
  ButtonElement canonTower;
  ButtonElement arrowTower;
  ButtonElement lightningTower;
  ButtonElement fireTower;
  TableElement buyMenu;
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
  ButtonElement easy;
  ButtonElement medium;
  ButtonElement hard;
  Element p;
  ButtonElement help;
  ButtonElement restart;
  Element time;
  Element helpText;
  TableElement mList;
  int mListRowCounter = 0;
  Element points;
  Element gold;
  Element life;
  Element timerhr;

/**
   * Constructor of the view
   * @param board - this is the datastructure for our board in dart. 
   * It cointains informations about the objects on the board which 
   * will be displayed in the view as images
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
    p = querySelector("#difficulty");
    help = querySelector("#help");
    helpBox = querySelector("#helpBox");
    restart = querySelector("#restart");
    time = querySelector("#time");
    helpText = querySelector("#helpText");
    mList = querySelector("#mList");
    points = querySelector("#points");
    gold = querySelector("#gold");
    life = querySelector("#life");
    timerhr = querySelector("#timerhr");

    menuContainer.hidden = true;
    buyMenu.hidden = true;
    cancel.hidden = true;
    buy.hidden = true;
    upgrade.hidden = true;
    sell.hidden = true;
    help.hidden = true;
    stop.hidden = true;
    restart.hidden = true;
    helpBox.hidden = true;
    time.hidden = true;
    timerhr.hidden = true;
    helpText.hidden = true;
    setToolTip();
  }
/**
   * Method to create a board 
   * @param board - contains all information which shall be displayed in the view
   * @return is a table element for the DOM-Tree
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
   * @param table - Table Element of the Dom Tree to display informations of the board in html
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
  Element setImageToView(String id, String objectName) {
    Element e;
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          children.classes.add(objectName);
          e = children;
        }
      });
    });
    return e;
  }
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
  void hideDifficultyMenu() {
    hard.hidden = true;
    medium.hidden = true;
    easy.hidden = true;
    buy.hidden = false;
    sell.hidden = false;
    upgrade.hidden = false;
    p.hidden = true;
  }
  void showDifficultyMenu() {
    hard.hidden = false;
    medium.hidden = false;
    easy.hidden = false;
    buy.hidden = true;
    sell.hidden = true;
    upgrade.hidden = true;
    p.hidden = false;
  }
  void setToolTip() {
    canonTower.setAttribute("title",
        "Price: 300\nBasicDamage: 7.0\nRange: 2\nDamageType: Siege\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
    arrowTower.setAttribute("title",
        "Price: 150\nBasicDamage: 5.0\nRange: 3\nDamageType: Piercing\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
    fireTower.setAttribute("title",
        "Price: 1000\nBasicDamage: 10.0\nRange: 2\nDamageType: Fire\nSpecial Ability: does dmg/seconds\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
    lightningTower.setAttribute("title",
        "Price: 1000\nBasicDamage: 10.0\nRange: 2\nDamageType: Lightning\nWith Upgrade the values are multiplied by its level(Level 2: x2 etc.)");
  }
  void setMinionToolTip(String name, String armor, String hitpoints,
      String movementSpeed, String droppedGold) {
    /** FIXME! */
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
    if (mList.children.length != 0) {
      for (int i = 0; i < mList.children.length; i++) {
        if (mList.children[i].children.length < 4) {
          mList.children[i].append(m);
        } else {
          TableRowElement tr = new TableRowElement();
          this.mList.append(tr);
          tr.append(m);
        }
      }
    } else {
      TableRowElement tr = new TableRowElement();
      this.mList.append(tr);
      tr.append(m);
    }
  }
  void clearMinionToolTip() {
    mList.children.clear();
  }
  void clearBoard() {
    Element e;
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        children.classes.clear();
      });
    });
  }
}
