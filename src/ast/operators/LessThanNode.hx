package ast.operators;

class LessThanNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "<", Left, 9);
    }
}