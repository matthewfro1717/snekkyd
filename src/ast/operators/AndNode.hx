package ast.operators;

class AndNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "&&", Left, 14);
    }
}