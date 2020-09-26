import 'scope-element.dart';
import 'scope-declaration.dart';
import 'scope-start.dart';
import '../ast-nodes/declaration.dart';

/// The scope of declaring objects.
///
/// Built using a linked list of [ScopeElement]s (the scope chain).
class Scope extends ScopeElement {
  ScopeElement lastChild;

  Scope() {
    lastChild = ScopeStart(this);
  }

  void add(ScopeElement element) {
    element.next = this.lastChild;
    this.lastChild = element;
  }

  ScopeElement addDeclaration(Declaration declaration) {
    var newElement = ScopeDeclaration(declaration);
    this.add(newElement);
    return newElement;
  }

  void addSubscope(Scope subscope) {
    this.add(subscope);
  }
}
