import "package:TowerDefense/control/controller.dart";
import "dart:html";

main() async{
  String levelFile = await HttpRequest.getString("../level.xml");
  Controller controller = new Controller(levelFile);

}