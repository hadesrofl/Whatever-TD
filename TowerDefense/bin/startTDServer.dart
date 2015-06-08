// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import "package:start/start.dart";

main() {
  start(host: '0.0.0.0', port: 3000).then((Server app) {
      app.static('../build/web');
    });
  }
