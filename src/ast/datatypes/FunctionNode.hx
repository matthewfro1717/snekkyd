package ast.datatypes;

import haxe.iterators.ArrayIterator;

class ParameterNode extends VariableNode {

    public function new(name:String) {
        super(name, null);
    }

    override function toString():String {
        final buf = new StringBuf();

        if (mutable) {
            buf.add("mut ");
        }
        buf.add(name);

        return buf.toString();
    }
}

class FunctionNode extends Node {

    public final body:BlockNode;
    public final parameters:Array<ParameterNode>;

    public function new(body:BlockNode, parameters:Array<ParameterNode>) {
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