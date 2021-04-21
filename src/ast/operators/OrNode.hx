package ast.operators;

class OrNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "||", Left, 15);
    }
}