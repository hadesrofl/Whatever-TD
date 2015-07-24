import "package:TowerDefense/control/controller.dart";
import "dart:html";
/**
 * @author Florian Winzek, Rene Kremer
 * @version 1.0.1
 * 
  Copyright (c) 2015, Florian Winzek, Rene Kremer. All rights reserved. Use of this source code
  is governed by a BSD-style license that can be found in the LICENSE file.
 */
main() async{
  String levelFile = await HttpRequest.getString("level.xml");
  Controller controller = new Controller(levelFile);


}