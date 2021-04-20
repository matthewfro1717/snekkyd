package ast.operators;

class LessThanOrEqualNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "<=");
    }

    override public function toString():String {
        return '($left <= $right)';
    }
}