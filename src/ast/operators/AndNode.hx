package ast.operators;

class AndNode extends Node {

    public final left:Node;
    public final right:Node;

    public function new(left:Node, right:Node) {
        this.left = left;
        this.right = right;
    }

    override public function toString():String {
        return '($left && $right)';
    }
}