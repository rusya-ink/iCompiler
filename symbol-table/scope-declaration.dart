import 'scope-element.dart';
import '../ast-nodes/declaration.dart';

/// An object declaration in some scope.
///
/// Instances of this class are the main objects of scope chains.
class ScopeDeclaration extends ScopeElement {
  Declaration declaration;

  ScopeDeclaration(this.declaration);
}
