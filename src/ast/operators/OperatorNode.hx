package ast.operators;

class OperatorNode extends Node {

    public final left:Node;
    public final right:Node;
    public final symbol:String;

    public function new(left:Node, right:Node, symbol:String) {
        this.left = left;
        this.right = right;
        this.symbol = symbol;
    }
}