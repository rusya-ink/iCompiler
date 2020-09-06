import 'var-type.dart';
import '../print-utils.dart';

/// An array type with optional [size].
class ArrayType implements VarType {
  int size;
  VarType elementType;

  ArrayType(this.size, this.elementType);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}ArrayType(size = ${this.size})', depth)
      + (this.elementType?.toString(depth: depth + 1, prefix: 'element type: ') ?? '')
    );
  }
}
