import 'package:path/path.dart' as path;

sealed class Images {
  static const basePath = 'assets/images/';
  static final iconPath = path.join(basePath, "cute-zucchini.png");
}
