package ast.operators;

class EqualsNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "==", Left, 10);
    }
}