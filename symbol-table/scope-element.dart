import 'scope-declaration.dart';
import 'scope-start.dart';
import '../semantic-error.dart';

/// An abstract element in the scope's linked list (scope chain).
abstract class ScopeElement {
  ScopeElement next;

  /// Ensure that no other declaration in the chain has the same [name].
  void ensureNoOther(String name) {
    var item = this;
    while (!(item is ScopeStart)) {
      if (item is ScopeDeclaration && item.declaration.name == name) {
        throw SemanticError(item.declaration, "Another object is declared with the name '$name'");
      }
      item = item.next;
    }
  }
}
