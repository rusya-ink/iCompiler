import 'var-type.dart';
import '../print-utils.dart';

/// The built-in integer type.
class IntegerType implements VarType {
  IntegerType();

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}IntegerType', depth);
  }
}
