package ast.datatypes;

import haxe.iterators.ArrayIterator;

class FunctionNode extends Node {

    public final body:BlockNode;
    public final parameters:Array<Node>;

    public function new(body:BlockNode, parameters:Array<Node>) {
        this.body = body;
        this.parameters = parameters;
    }

    override function toString():String {
        final s = new StringBuf();
        s.add("func(");
        final iterator = new ArrayIterator(parameters);
        for (p in iterator) {
            s.add(p.toString());
            if (iterator.hasNext()) {
                s.add(", ");
            }
        }
        s.add(") ");
        s.add(body.toString());

        return s.toString();
    }
}