package ast.operators;

class BitNotNode extends OperatorNode {

    public function new(right:Node) {
        super(null, right, "~");
    }

    override public function toString():String {
        return '(~$right)';
    }
}