package ast.operators;

class NotNode extends OperatorNode {

    public function new(right:Node) {
        super(null, right, "!", Right, 3);
    }

    override function toString():String {
        return if (right is EqualsNode) {
            final cRight = cast(right, EqualsNode);
            '${cRight.left} != ${cRight.right}';
        } else {
            if (right is OperatorNode) {
                '!($right)';
            } else {
                '!$right';
            }
        }
    }
}