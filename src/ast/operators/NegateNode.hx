package ast.operators;

class NegateNode extends OperatorNode {

    public function new(right:Node) {
        super(null, right, "-");
    }

    override public function toString():String {
        return '(-$right)';
    }
}