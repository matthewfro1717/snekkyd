package ast.operators;

class AddNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "+", Left, 6);
    }
}