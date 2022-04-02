import 'package:flutter/cupertino.dart';

import 'data/strings.dart';
import 'user/user.dart';

ValueNotifier<User> userData = ValueNotifier<User>(User(imageUrl: demoImage));

setUser(User user) {
  userData.value = user;
}
