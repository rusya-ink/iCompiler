import 'var-type.dart';
import '../print-utils.dart';

/// The built-in real type.
class RealType implements VarType {
  RealType();

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}RealType', depth);
  }
}
