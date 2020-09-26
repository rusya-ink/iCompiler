import 'primary.dart';
import '../print-utils.dart';
import '../symbol-table/scope-element.dart';

/// A literal boolean value in code.
class BooleanLiteral implements Primary {
  ScopeElement scopeMark;

  bool value;

  BooleanLiteral(this.value);

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}BooleanLiteral(${this.value})', depth);
  }

  void propagateScopeMark(ScopeElement parentMark) {
    this.scopeMark = parentMark;
  }
}
