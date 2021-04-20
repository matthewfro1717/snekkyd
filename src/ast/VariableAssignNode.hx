package ast;

import ast.operators.OperatorNode;

class VariableAssignNode extends Node {

    public final name:String;
    public final value:Node;

    public function new(name:String, value:Node) {
        this.name = name;
        this.value = value;
    }

    override function toString():String {
        if (value is OperatorNode) {
            final op = cast(value, OperatorNode);
            if (op.left is IdentNode) {
                final left = cast(op.left, IdentNode);
                if (left.name == name && op.symbol != "><") {
                    return '$name ${op.symbol}= ${op.right};\r\n';
                }
            }
        }

        return '$name = $value;\r\n';
    }
}