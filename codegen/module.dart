import 'dart:ffi';
import 'dart:io' show Platform;
import 'memory-manager.dart';
import 'package:ffi/ffi.dart';
import 'llvm.dart';

String getLlvmPath() {
  if (Platform.isLinux) {
    return '/usr/lib/libLLVM-10.so';
  } else if (Platform.isMacOS) {
    return '/usr/local/Cellar/llvm/10.0.1_1/lib/libLLVM.dylib ';
  } else if (Platform.isWindows) {
    return 'C:/Program Files/LLVM/bin/LLVM-C.dll';
  }
  throw Exception('Platform not supported');
}

final llvm = LLVM(DynamicLibrary.open(getLlvmPath()));


/// A wrapper around the LLVM Module for easier use.
class Module {
  Pointer<LLVMOpaqueContext> context;
  Pointer<LLVMOpaqueBuilder> builder;
  Pointer<LLVMOpaqueModule> _module;

  Module(String name) {
    this.context = llvm.LLVMContextCreate();
    this._module = llvm.LLVMModuleCreateWithNameInContext(
      MemoryManager.getCString(name),
      this.context,
    );
    this.builder = llvm.LLVMCreateBuilderInContext(this.context);
  }

  Pointer<LLVMOpaqueValue> addRoutine(String name, Pointer<LLVMOpaqueType> type) {
    return llvm.LLVMAddFunction(this._module, MemoryManager.getCString(name), type);
  }

  Pointer<LLVMOpaqueValue> getLastRoutine() {
    return llvm.LLVMGetLastFunction(this._module);
  }

  /// Get the string representation of the module.
  ///
  /// This includes metadata like the name as well as the instruction dump.
  String toString() {
    var stringPtr = llvm.LLVMPrintModuleToString(this._module);
    var representation = Utf8.fromUtf8(stringPtr.cast<Utf8>());
    llvm.LLVMDisposeMessage(stringPtr);
    return representation;
  }

  /// Free the memory occupied by this module.
  void dispose() {
    llvm.LLVMDisposeModule(this._module);
    llvm.LLVMDisposeBuilder(this.builder);
    llvm.LLVMContextDispose(this.context);
  }
}
