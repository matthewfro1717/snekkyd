package ast.operators;

class ConcatStringNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "><", Left, 6);
    }
}