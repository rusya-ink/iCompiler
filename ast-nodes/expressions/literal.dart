import 'primary.dart';
import '../types/var-type.dart';
import '../../symbol-table/scope-element.dart';

/// A literal integer number in code.
abstract class Literal implements Primary {
  VarType resultType;
  bool isConstant = true;
  ScopeElement scopeMark;

  double get realValue;

  int get integerValue;

  bool get booleanValue;
}
