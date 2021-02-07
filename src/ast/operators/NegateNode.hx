package ast.operators;

class NegateNode extends Node {

    public final right:Node;

    public function new(right:Node) {
        this.right = right;
    }

    override public function toString():String {
        return '(-$right)';
    }
}