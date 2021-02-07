package ast.datatypes;

import haxe.iterators.ArrayIterator;

class ArrayNode extends Node {

    public final values:Array<Node> = [];

    public function new(values:Array<Node>) {
        this.values = values;
    }

    override function toString():String {
        final s = new StringBuf();
        s.add("[");

        final iterator = new ArrayIterator(values);
        for (v in iterator) {
            s.add(v.toString());
            if (iterator.hasNext()) {
                s.add(", ");
            }
        }
        s.add("]");

        return s.toString();
    }
}