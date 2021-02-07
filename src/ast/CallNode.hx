package ast;

import haxe.iterators.ArrayIterator;

class CallNode extends Node {

    public final target:Node;
    public final parameters:Array<Node>;

    public function new(target:Node, parameters:Array<Node>) {
        this.target = target;
        this.parameters = parameters;
    }

    override function toString():String {
        final s = new StringBuf();
        s.add('$target(');
        final iterator = new ArrayIterator(parameters);
        for (p in iterator) {
            s.add(p.toString());
            if (iterator.hasNext()) {
                s.add(", ");
            }
        }
        s.add(")");
        
        return s.toString();
    }
}