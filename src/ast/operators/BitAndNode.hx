package ast.operators;

class BitAndNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "&", Left, 11);
    }
}