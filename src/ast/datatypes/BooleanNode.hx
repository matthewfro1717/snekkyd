package ast.datatypes;

class BooleanNode extends Node {

    public final value:Bool;

    public function new(value:Bool) {
        this.value = value;
    }

    override function toString():String {
        return Std.string(value);
    }
}