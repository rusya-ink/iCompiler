import 'primary.dart';
import '../print-utils.dart';

/// A literal floating-point number in code.
class RealLiteral implements Primary {
  double value;

  RealLiteral(this.value);

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}RealLiteral(${this.value})', depth);
  }
}
