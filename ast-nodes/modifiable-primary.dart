import 'primary.dart';
import '../lexer.dart';

/// An abstract writable entity – something that can appear in the LHS of the assignment.
///
/// For example, a variable, a record field or an array slot.
abstract class ModifiablePrimary implements Primary {
  factory ModifiablePrimary.parse(Iterable<Token> tokens) {

  }
}
