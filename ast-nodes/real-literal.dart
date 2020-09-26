import 'primary.dart';
import '../print-utils.dart';
import '../symbol-table/scope-element.dart';

/// A literal floating-point number in code.
class RealLiteral implements Primary {
  ScopeElement scopeMark;

  double value;

  RealLiteral(this.value);

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}RealLiteral(${this.value})', depth);
  }

  void propagateScopeMark(ScopeElement parentMark) {
    this.scopeMark = parentMark;
  }
}
