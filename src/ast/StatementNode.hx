package ast;

class StatementNode extends Node {

    public final expression:Node;
    
    public function new(expression:Node) {
        this.expression = expression;
    }

    override public function toString():String {
        return '$expression;';
    }
}