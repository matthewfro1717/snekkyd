package ast.operators;

class BitXorNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "^", Left, 12);
    }
}