package ast.operators;

class MultiplyNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "*", Left, 5);
    }
}