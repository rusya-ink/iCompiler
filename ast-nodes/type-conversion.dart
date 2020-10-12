import 'dart:ffi';
import 'index.dart';
import '../utils/index.dart';
import '../symbol-table/index.dart';
import '../codegen/index.dart';

class TypeConversion implements Expression {
  Expression expression;
  VarType resultType;
  bool isConstant;
  ScopeElement scopeMark;

  TypeConversion(this.expression, this.resultType)
      : isConstant = expression.isConstant;

  @override
  void checkSemantics() {}

  @override
  void propagateScopeMark(ScopeElement parentMark) {
    this.scopeMark = parentMark;
    this.expression.propagateScopeMark(parentMark);
  }

  @override
  String toString({int depth = 0, String prefix = ''}) {
    return (drawDepth(
            '${prefix}TypeConversion(${this.resultType.runtimeType})', depth) +
        (this.expression?.toString(depth: depth + 1, prefix: '') ?? ''));
  }

  @override
  Literal evaluate() {
    return (this.expression.evaluate());
  }

  Pointer<LLVMOpaqueValue> generateCode(Module module) {
    // TODO: fix rounding when converting 3.6 to real
    var srcType = this.expression.resultType.resolve();
    var dstType = this.resultType;

    if (dstType is RealType) {
      if (srcType is IntegerType) {
        return llvm.LLVMBuildSIToFP(
          module.builder,
          this.expression.generateCode(module),
          this.resultType.getLlvmType(module),
          MemoryManager.getCString('integer->real'),
        );
      }
      if (srcType is BooleanType) {
        return llvm.LLVMBuildUIToFP(
          module.builder,
          this.expression.generateCode(module),
          this.resultType.getLlvmType(module),
          MemoryManager.getCString('boolean->real'),
        );
      }
      return null;
    }

    if (srcType is RealType && dstType is IntegerType) {
      return llvm.LLVMBuildFPToSI(
        module.builder,
        this.expression.generateCode(module),
        this.resultType.getLlvmType(module),
        MemoryManager.getCString('real->integer'),
      );
    }

    return llvm.LLVMBuildBitCast(
      module.builder,
      this.expression.generateCode(module),
      this.resultType.getLlvmType(module),
      MemoryManager.getCString('type-conversion'),
    );
  }
}
