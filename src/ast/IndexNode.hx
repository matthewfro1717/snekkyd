package ast;

import ast.datatypes.NumberNode;
import ast.operators.OperatorNode;
import code.Keyword;
import ast.datatypes.StringNode;

class IndexNode extends Node {

    public final target:Node;
    public final index:Node;

    public function new(target:Node, index:Node) {
        this.target = target;
        this.index = index;
    }

    override function toString():String {
        if (index is StringNode) {
            final cIndex = cast(index, StringNode).value;

            if (!Keyword.isKeyword(cIndex) && ~/^[a-zA-Z]+$/.match(cIndex)) {
                return if (target is NumberNode || target is OperatorNode) {
                    '($target).$cIndex';
                } else {
                    '$target.$cIndex';
                }
            }
        }

        return '$target[$index]';    
    }
}