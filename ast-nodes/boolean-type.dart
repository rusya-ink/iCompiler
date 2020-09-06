import 'var-type.dart';
import '../print-utils.dart';

/// The built-in boolean type.
class BooleanType implements VarType {
  BooleanType();

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}BooleanType', depth);
  }
}
