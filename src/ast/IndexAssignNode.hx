package ast;

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
        if (Std.is(index, StringNode)) {
            final cIndex = cast(index, StringNode).value;

            if (!Keyword.isKeyword(cIndex)) {
                return '$target.$cIndex = $value;\r\n';
            }
        } 
        
        return '$target[$index] = $value;\r\n';    
    }
}