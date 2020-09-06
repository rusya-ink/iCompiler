import 'primary.dart';
import '../print-utils.dart';

/// A literal boolean value in code.
class BooleanLiteral implements Primary {
  bool value;

  BooleanLiteral(this.value);

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}BooleanLiteral(${this.value})', depth);
  }
}
