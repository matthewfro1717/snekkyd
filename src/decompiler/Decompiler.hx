package decompiler;

import ast.datatypes.FunctionNode.ParameterNode;
import haxe.ds.IntMap;
import haxe.ds.StringMap;
import haxe.io.Path;
#if target.sys
import sys.io.File;
import sys.FileSystem;
#end
import std.BuiltInTable;
import object.Object;
import ast.*;
import ast.datatypes.*;
import ast.operators.*;
import code.OpCode;
import haxe.ds.GenericStack;
import haxe.io.Bytes;
import haxe.zip.Uncompress;
import constant.ConstantPool;
import debug.VariableTable;
import debug.LineNumberTable;
import debug.FileNameTable;
import haxe.io.BytesInput;

class Decompiler {
    
    final fileNameTable:FileNameTable;
    final lineNumberTable:LineNumberTable;
    final variableTable:VariableTable;
    final constantPool:Array<Object>;
    final instructions:Bytes;
    final variableNames:Array<String> = [];
    final fileInfo:Array<String> = [];
    var currentBlock:BlockNode;
    final blocks:StringMap<BlockNode> = new StringMap();
    var opCode:Int;
    var pc = 0;

    final stack:GenericStack<Node> = new GenericStack();
    final functions:Map<Int, FunctionNode> = new Map();
    final variableNodes:IntMap<VariableNode> = new IntMap();

    public function new(fileData:Bytes) {
        final fileData = new BytesInput(fileData);
        final byteCode = if (fileData.readByte() == 1) {
            new BytesInput(Uncompress.run(fileData.readAll()));
        } else {
            new BytesInput(fileData.readAll());
        }
        fileNameTable = new FileNameTable().fromByteCode(byteCode);
        lineNumberTable = new LineNumberTable().fromByteCode(byteCode);
        variableTable = new VariableTable().fromByteCode(byteCode);
        constantPool = ConstantPool.fromByteCode(byteCode);
        instructions = byteCode.read(byteCode.readInt32());
    }

    public function decompile() {
        var lastFileName:String = fileNameTable.resolve(pc);

        while (pc < instructions.length) {
            final fileName = fileNameTable.resolve(pc);

            if (!blocks.exists(fileName)) {
                blocks.set(fileName, new BlockNode(null));
            }

            currentBlock = blocks.get(fileName);

            if (lastFileName != fileName) {
                currentBlock.addNode(new ImportNode(Path.withoutExtension(lastFileName)));
                lastFileName = fileName;
            }

            handleInstruction();
        }
    }

    #if target.sys
    public function save(outDir:String) {
        for (fileName => content in blocks) {
            FileSystem.createDirectory('$outDir/${Path.directory(fileName)}');
            File.saveContent('$outDir/$fileName', content.toString());
        }
    }
    #end

    public function decompileToString():String {
        return currentBlock.toString();
    }

    public function decompileToMap():StringMap<String> {
        final files:StringMap<String> = new StringMap();
        for (fileName => content in blocks) {
            files.set(fileName, content.toString());
        }

        return files;
    }

    function getInt32():Int {
        final value = instructions.getInt32(pc);
        pc += 4;

        return value;
    }

    function handleInstruction() {
        opCode = instructions.get(pc);
        pc++;

        switch (opCode) {
            case OpCode.Duplicate:
                stack.add(stack.first());
            case OpCode.Constant:
                final constantIndex = getInt32();
                final constant = switch (constantPool[constantIndex]) {
                    case Object.Number(value): new NumberNode(value);
                    case Object.Boolean(value): new BooleanNode(value);
                    case Object.Null: new NullNode();
                    case Object.String(value): new StringNode(value);
                    case Object.Function(position, parametersCount):
                        pc = position;
                        final oStackSize = Lambda.count(stack);

                        final jumpIndex = instructions.getInt32(pc - 4);
                        final body = new BlockNode(currentBlock);
                        currentBlock = body;

                        final parameters:Array<ParameterNode> = [];
                        while (pc < jumpIndex) {
                            switch (instructions.get(pc)) {
                                case OpCode.Store if (parameters.length < parametersCount):
                                    pc++;
                                    final index = getInt32();
                                    final name = variableTable.resolveVariableName(index);
                                    final parameterNode = new ParameterNode(name);
                                    parameters.push(parameterNode);
                    
                                    if (!variableNodes.exists(index)) {
                                        variableNodes.set(index, parameterNode);
                                    }
                                case OpCode.Return if (jumpIndex - pc == 1 && Lambda.count(stack) <= oStackSize): // Skip last return of function
                                    pc++;
                                case OpCode.Return if (Lambda.count(stack) <= oStackSize):
                                    stack.add(new NullNode());
                                    handleInstruction();
                                default: handleInstruction();
                            }
                        }
                        currentBlock = body.parent;

                        new FunctionNode(body, parameters);
                }

                stack.add(constant);
            case OpCode.Add:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new AddNode(left, right));
            case OpCode.Subtract:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new SubtractNode(left, right));
            case OpCode.Multiply:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new MultiplyNode(left, right));
            case OpCode.Divide:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new DivideNode(left, right));
            case OpCode.Modulo:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new ModuloNode(left, right));
            case OpCode.LessThan:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new LessThanNode(left, right));
            case OpCode.LessThanOrEqual:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new LessThanOrEqualNode(left, right));
            case OpCode.GreaterThan:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new GreaterThanNode(left, right));
            case OpCode.GreaterThanOrEqual:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new GreaterThanOrEqualNode(left, right));
            case OpCode.BitAnd:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new BitAndNode(left, right));
            case OpCode.BitOr:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new BitOrNode(left, right));
            case OpCode.BitShiftLeft:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new BitShiftLeftNode(left, right));
            case OpCode.BitShiftRight:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new BitShiftRightNode(left, right));
            case OpCode.BitXor:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new BitXorNode(left, right));
            case OpCode.BitNot:
                final right = stack.pop();

                stack.add(new BitNotNode(right));
            case OpCode.Pop:
                final expression = stack.pop();

                currentBlock.addNode(new StatementNode(expression));
            case OpCode.Equals:
                final right = stack.pop();
                final left = stack.pop();

                if (instructions.get(pc) == OpCode.Not) {
                    pc++;
                    stack.add(new NotEqualsNode(left, right));
                } else {
                    stack.add(new EqualsNode(left, right));
                }
            case OpCode.Negate:
                final right = stack.pop();

                stack.add(new NegateNode(right));
            case OpCode.ConcatString:
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new ConcatStringNode(left, right));
            case OpCode.Store:
                final index = getInt32();
                final expression = stack.pop();
                final name = variableTable.resolveVariableName(index);

                if (!variableNodes.exists(index)) {
                    final node = new VariableNode(name, expression);
                    variableNodes.set(index, node);
                    currentBlock.addNode(node);
                } else {
                    variableNodes.get(index).mutable = true;
                    currentBlock.addNode(new VariableAssignNode(name, expression));
                }
            case OpCode.Load:
                final index = getInt32();
                final name = variableTable.resolveVariableName(index);

                stack.add(new IdentNode(name));
            case OpCode.Call:
                final callParametersCount = getInt32();
                final object = stack.pop();

                final parameters:Array<Node> = [];
                for (_ in 0...callParametersCount) {
                    parameters.push(stack.pop());
                }

                stack.add(new CallNode(object, parameters));
            case OpCode.LoadIndex:
                final index = stack.pop();
                final target = stack.pop();

                stack.add(new IndexNode(target, index));
            case OpCode.LoadBuiltIn:
                final builtInIndex = getInt32();

                final name = BuiltInTable.resolveName(builtInIndex);
                stack.add(new IdentNode(name));
            case OpCode.StoreIndex:
                final value = stack.pop();
                final index = stack.pop();
                final target = stack.pop();

                currentBlock.addNode(new IndexAssignNode(target, index, value));
            case OpCode.Array:
                final arrayLength = getInt32();
                final arrayValues:Array<Node> = [];

                for (_ in 0...arrayLength) {
                    arrayValues.push(stack.pop());
                }

                stack.add(new ArrayNode(arrayValues));
            case OpCode.Return:
                final returnValue = stack.pop();

                currentBlock.addNode(new ReturnNode(returnValue));
            case OpCode.Hash:
                final hashLength = getInt32();
                final hashValues:Map<Node, Node> = new Map();

                for (_ in 0...hashLength) {
                    final value = stack.pop();
                    final key = stack.pop();

                    hashValues.set(key, value);
                }

                stack.add(new HashNode(hashValues));
            case OpCode.Jump:
                final jumpPos = getInt32();

                if (jumpPos < pc) {
                    currentBlock.addNode(new ContinueNode());
                } else {
                    currentBlock.addNode(new BreakNode());
                }
            case OpCode.JumpPeek: // OR
                final jumpIndex = getInt32();
                pc++;
                while (pc != jumpIndex) {
                    handleInstruction();
                }
                final right = stack.pop();
                final left = stack.pop();

                stack.add(new OrNode(left, right));
            case OpCode.Not: // AND
                if (instructions.get(pc) == OpCode.JumpPeek) {
                    pc++;
                    final jumpIndex = getInt32();
                    pc++;
                    while (pc != jumpIndex - 5) {
                        handleInstruction();
                    }
                    pc += 6;

                    final right = stack.pop();
                    final left = stack.pop();

                    stack.add(new AndNode(left, right));
                } else {
                    final right = stack.pop();
                    stack.add(new NotNode(right));
                }
            case OpCode.JumpNot:
                final jumpIndex = getInt32();
                final condition = stack.pop();

                final block = new BlockNode(currentBlock);
                final oStackSize = Lambda.count(stack);
                var putOnStack = false;

                currentBlock = block;
                while (pc < jumpIndex) {
                    if (jumpIndex - pc == 5 && instructions.get(pc) == OpCode.Jump) {
                        pc++;
                        final jumpIndex = getInt32();

                        if (jumpIndex >= pc) { // IF
                            if (oStackSize < Lambda.count(stack)) {
                                currentBlock.addNode(stack.pop());
                                putOnStack = true;
                            }

                            final oBlock = currentBlock;
                            final alternative = new BlockNode(currentBlock.parent);
                            currentBlock = alternative;

                            while (pc < jumpIndex) {
                                handleInstruction();
                            }

                            if (oStackSize < Lambda.count(stack)) {
                                currentBlock.addNode(stack.pop());
                                putOnStack = true;
                            }

                            currentBlock = oBlock;
                            currentBlock = block.parent;

                            if (putOnStack) {
                                stack.add(new IfNode(condition, block, alternative));
                            } else {
                                currentBlock.addNode(new IfNode(condition, block, alternative));
                            }
                        } else { // WHILE
                            if (oStackSize < Lambda.count(stack)) {
                                currentBlock.addNode(stack.pop());
                                putOnStack = true;
                            }
                            currentBlock = block.parent;

                            if (putOnStack) {
                                stack.add(new WhileNode(condition, block));
                            } else {
                                currentBlock.addNode(new WhileNode(condition, block));
                            }
                        }
                    } else {
                        handleInstruction();
                    }
                }
        }
    }
}
