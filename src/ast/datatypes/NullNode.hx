package ast.datatypes;

class NullNode extends Node {

    public function new() {}

    override function toString():String {
        return "null";
    }
}