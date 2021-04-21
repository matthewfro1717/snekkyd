package ast.operators;

class ModuloNode extends OperatorNode {

    public function new(left:Node, right:Node) {
        super(left, right, "%", Left, 5);
    }
}