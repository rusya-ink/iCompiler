import 'modifiable-primary.dart';
import '../print-utils.dart';

/// A variable reference by [name] – for either reading or writing.
class Variable implements ModifiablePrimary {
  String name;

  Variable(this.name);

  // TODO: implement .parse()

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}Variable("${this.name}")', depth);
  }
}
