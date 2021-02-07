package ast;

class ContinueNode extends Node {

    public function new() {}

    override function toString():String {
        return "continue;";
    }
}