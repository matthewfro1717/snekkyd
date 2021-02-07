package ast.operators;

class BitNotNode extends Node {

    public final right:Node;

    public function new(right:Node) {
        this.right = right;
    }

    override public function toString():String {
        return '(~$right)';
    }
}