import 'var-type.dart';
import 'type-declaration.dart';
import '../print-utils.dart';
import '../symbol-table/scope-element.dart';

/// A type that was specified by the [name].
///
/// Refers to custom types declared with [TypeDeclaration]s.
class NamedType implements VarType {
  ScopeElement scopeMark;

  String name;

  NamedType(this.name);

  String toString({int depth = 0, String prefix = ''}) {
    return drawDepth('${prefix}NamedType("${this.name}")', depth);
  }

  void propagateScopeMark(ScopeElement parentMark) {
    this.scopeMark = parentMark;
  }
}
