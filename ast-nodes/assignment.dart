import 'dart:ffi';
import 'index.dart';
import '../utils/index.dart';
import '../errors/index.dart';
import '../lexer/token.dart';
import '../symbol-table/index.dart';
import '../codegen/index.dart';

/// An assignment of the value on the right hand side ([rhs]) to the left hand side ([lhs]).
class Assignment implements Statement {
  ScopeElement scopeMark;

  ModifiablePrimary lhs;
  Expression rhs;

  Assignment(this.lhs, this.rhs);

  factory Assignment.parse(Iterable<Token> tokens) {
    var iter = tokens.iterator;

    if (!iter.moveNext()) {
      throw SyntaxError(iter.current, "Expected an assignment");
    }

    var lhs = ModifiablePrimary.parse(consumeUntil(iter, RegExp(":=\$")));
    checkThis(iter, RegExp(':=\$'), 'Expected ":="');
    iter.moveNext();
    return Assignment(lhs, Expression.parse(consumeFull(iter)));
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (drawDepth('${prefix}Assignment', depth) +
        (this.lhs?.toString(depth: depth + 1, prefix: 'lhs: ') ?? '') +
        (this.rhs?.toString(depth: depth + 1, prefix: 'rhs: ') ?? ''));
  }

  void propagateScopeMark(ScopeElement parentMark) {
    this.scopeMark = parentMark;
    this.lhs.propagateScopeMark(parentMark);
    this.rhs.propagateScopeMark(parentMark);
  }

  void checkSemantics() {
    lhs.checkSemantics();
    rhs.checkSemantics();
    if (lhs.resultType != rhs.resultType) {
      if (lhs.resultType is IntegerType) {
        rhs = ensureType(rhs, IntegerType());
      } else if (lhs.resultType is RealType) {
        rhs = ensureType(rhs, RealType());
      } else if (lhs.resultType is BooleanType) {
        rhs = ensureType(rhs, BooleanType());
      } else {
        throw SemanticError(this,
            'Types ${lhs.resultType.runtimeType} and ${rhs.resultType.runtimeType} are inconvertable!');
      }
    }
  }

  Pointer<LLVMOpaqueValue> generateCode(Module module) {
    // TODO: implement
    return null;
  }
}
