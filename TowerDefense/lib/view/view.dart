library view;

import "dart:html";
import 'package:TowerDefense/model/level/levelAdmin.dart';
import 'package:TowerDefense/model/tower/towerAdmin.dart';
/* TODO: DeathCounter for Minions */

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
  Element nameLabel;
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
  Element errorDiv;
  Element errorDiv2;
  ButtonElement easy;
  ButtonElement medium;
  ButtonElement hard;
  Element p;
  Element px;
  ButtonElement help;
  ButtonElement restart;
  Element time;

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
    nameLabel = querySelector("#player");
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
    errorDiv = querySelector("#errorDiv");
    errorDiv2 = querySelector("#errorDiv2");
    easy = querySelector("#easyGame");
    medium = querySelector("#mediumGame");
    hard = querySelector("#hardGame");
    p = querySelector("#difficulty");
    px = querySelector("#gold");
    help = querySelector("#help");
    helpBox = querySelector("#helpBox");
    restart = querySelector("#restart");
    time = querySelector("#time");

    menuContainer.hidden = true;
    buyMenu.hidden = true;
    cancel.hidden = true;
    errorDiv.hidden = true;
    errorDiv2.hidden = true;
    buy.hidden = true;
    upgrade.hidden = true;
    sell.hidden = true;
    help.hidden = true;
    stop.hidden = true;
    restart.hidden = true;
    helpBox.hidden = true;
    time.hidden = true;
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
  void setImageTower(String id, String objectName, Tower t) {
    Element children = setImageToView(id, objectName);
    setToolTipTower(children, t);
  }
  void setImageMinion(String id, String objectName, Minion m) {
    Element children = setImageToView(id, objectName);
    setToolTipMinion(children, m);
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
  void deleteImageOnLastField(String id) {
    this.board.children.forEach((c) {
      c.children.forEach((children) {
        if (children.id == id) {
          children.attributes.remove("data-toggle");
          children.attributes.remove("title");
          print(children.classes.toString());
          children.classes.clear();
          children.classes.add("Path");
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
  void setToolTipTower(Element child, Tower t) {
    child.setAttribute("data-toggle", "tooltip");
    child.setAttribute("title", "Basic Damage: " + t.basicDamage.toString());
  }
  void setToolTipMinion(Element child, Minion m) {
    child.setAttribute("data-toggle", "tooltip");
    child.setAttribute("title", "ArmorClass: " +
        m.armor.value +
        "HitPoints: " +
        m.hitpoints.toString());
  }
}
