package ast.operators;

class NegateNode extends OperatorNode {

    public function new(right:Node) {
        super(null, right, "-", Right, 3);
    }

    override public function toString():String {
        return if (right is OperatorNode) {
            '-($right)';
        } else {
            '-$right';
        }
    }
}