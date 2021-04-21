package ast.operators;

class GreaterThanNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, ">", Left, 9);
    }
}