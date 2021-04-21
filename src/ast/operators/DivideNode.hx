package ast.operators;

class DivideNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "/", Left, 5);
    }
}