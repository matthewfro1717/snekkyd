package ast.operators;

class NotNode extends OperatorNode {

    public function new(right:Node) {
        super(null, right, "!");
    }

    override function toString():String {
        return '(!$right)';
    }
}