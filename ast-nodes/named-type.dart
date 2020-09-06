import 'var-type.dart';
import 'type-declaration.dart';
import '../print-utils.dart';

/// A type that was specified by the [name].
///
/// Refers to custom types declared with [TypeDeclaration]s.
class NamedType implements VarType {
  String name;

  NamedType(this.name);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}NamedType("${this.name}")', depth);
  }
}
