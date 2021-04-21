package ast.operators;

class GreaterThanOrEqualNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, ">=", Left, 9);
    }
}