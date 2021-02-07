package ast;

class IdentNode extends Node {

    public final name:String;

    public function new(name:String) {
        this.name = name;
    }

    override function toString():String {
        return name;
    }
}