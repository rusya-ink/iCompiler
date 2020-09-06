import 'node.dart';
import 'declaration.dart';
import 'variable-declaration.dart';
import 'type-declaration.dart';
import 'routine-declaration.dart';
import '../lexer.dart';
import '../iterator-utils.dart';
import '../print-utils.dart';

/// A program is a list of [Declaration]s.
///
/// Declarations can be of three types:
///  - [VariableDeclaration]s
///  - [TypeDeclaration]s
///  - [RoutineDeclaration]s
class Program implements Node {
  List<Declaration> declarations;

  Program(this.declarations);

  factory Program.parse(Iterable<Token> tokens) {
    var iterator = tokens.iterator;
    var declarations = <Declaration>[];

    while (iterator.moveNext()) {
      var declarationTokens = consumeUntil(iterator, RegExp("^[\n;]\$"));
      if (declarationTokens.isEmpty) {
        continue;
      }

      declarations.add(Declaration.parse(declarationTokens));
    }

    return Program(declarations);
  }

  String toString({int depth = 0, String prefix = ''}) {
    return (
      drawDepth('${prefix}Program', depth)
      + drawDepth('declarations:', depth + 1)
      + this.declarations.map((node) => node?.toString(depth: depth + 2) ?? '').join('')
    );
  }
}
