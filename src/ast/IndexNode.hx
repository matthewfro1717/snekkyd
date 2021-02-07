package ast;

class IndexNode extends Node {

    public final target:Node;
    public final index:Node;

    public function new(target:Node, index:Node) {
        this.target = target;
        this.index = index;
    }

    override function toString():String {
        return '$target[$index]';
    }
}