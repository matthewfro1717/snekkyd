package ast.operators;

class NotNode extends Node {

    public final right:Node;

    public function new(right:Node) {
        this.right = right;
    }

    override function toString():String {
        return '(!$right)';
    }
}