package ast;

import ast.datatypes.StringNode;

class IndexNode extends Node {

    public final target:Node;
    public final index:Node;

    public function new(target:Node, index:Node) {
        this.target = target;
        this.index = index;
    }

    override function toString():String {
        return if (Std.is(index, StringNode)) {
            final cIndex = cast(index, StringNode).value;
            '$target.$cIndex';
        } else {
            '$target[$index]';    
        }
    }
}