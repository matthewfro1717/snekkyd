package ast.operators;

class LessThanOrEqualNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "<=", Left, 9);
    }
}