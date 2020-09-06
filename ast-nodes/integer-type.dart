import 'var-type.dart';
import '../print-utils.dart';

/// The built-in integer type.
class IntegerType implements VarType {
  IntegerType();

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}IntegerType', depth);
  }
}
