package ast;

class IndexAssignNode extends Node {

    public final target:Node;
    public final index:Node;
    public final value:Node;

    public function new(target:Node, index:Node, value:Node) {
        this.target = target;
        this.index = index;
        this.value = value;
    }

    override function toString():String {
        return '$target[$index] = $value;\r\n';
    }
}