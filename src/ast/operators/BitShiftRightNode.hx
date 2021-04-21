package ast.operators;

class BitShiftRightNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, ">>", Left, 7);
    }
}