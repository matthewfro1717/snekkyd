package ast.datatypes;

import code.Keyword;
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
            final key = cast(k, StringNode);
            if (~/^[a-zA-Z]+$/.match(key.value) && !Keyword.isKeyword(key.value)) {
                s.add(key.value);
            } else {
                s.add(k.toString());
            }
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