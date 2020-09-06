import 'var-type.dart';
import 'variable-declaration.dart';
import '../print-utils.dart';

/// A compound type that has several [fields] inside.
class RecordType implements VarType {
  List<VariableDeclaration> fields;

  RecordType(this.fields);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}RecordType', depth)
      + drawDepth('fields:', depth + 1)
      + this.fields.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
