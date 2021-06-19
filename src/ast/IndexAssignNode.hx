package ast;

import ast.datatypes.NumberNode;
import code.Keyword;
import ast.datatypes.StringNode;

class IndexAssignNode extends Node {

    public final target:Node;
    public final index:Node;
    public final value:Node;

    public function new(target:Node, index:Node, value:Node) {
        this.target = target;
        this.index = index;
        this.value = value;
    }

    override function toString():String {
        if (index is StringNode) {
            final cIndex = cast(index, StringNode).value;

            if (!Keyword.isKeyword(cIndex) && ~/^[a-zA-Z]+$/.match(cIndex)) {
                return if (target is NumberNode) {
                    '($target).$cIndex = $value;\r\n'; 
                } else {
                    '$target.$cIndex = $value;\r\n';    
                }
            }
        }
        
        return '$target[$index] = $value;\r\n';    
    }
}