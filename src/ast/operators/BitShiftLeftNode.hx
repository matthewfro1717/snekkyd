package ast.operators;

class BitShiftLeftNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "<<", Left, 7);
    }
}