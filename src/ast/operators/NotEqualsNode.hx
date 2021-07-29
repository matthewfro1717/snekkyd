package ast.operators;

class NotEqualsNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "!=", Left, 10);
    }
}