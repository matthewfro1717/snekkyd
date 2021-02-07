package ast.datatypes;

class NumberNode extends Node {

    public final value:Float;

    public function new(value:Float) {
        this.value = value;
    }

    override public function toString():String {
        return Std.string(value);
    }
}