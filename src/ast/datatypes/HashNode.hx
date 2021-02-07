package ast.datatypes;

import haxe.iterators.MapKeyValueIterator;

class HashNode extends Node {
   
    public final values:Map<Node, Node>;

    public function new(values:Map<Node, Node>) {
        this.values = values;
    }

    override function toString():String {
        final s = new StringBuf();

        s.add("{");
        final iterator = new MapKeyValueIterator(values);
        for (k => v in iterator) {
            s.add(k.toString());
            s.add(": ");
            s.add(v.toString());
            if (iterator.hasNext()) {
                s.add(", ");
            }
        }
        s.add("}");

        return s.toString();
    }
}