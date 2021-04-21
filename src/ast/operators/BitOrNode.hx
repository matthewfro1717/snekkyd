package ast.operators;

class BitOrNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "|", Left, 13);
    }
}