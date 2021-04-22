package ast.operators;

// TODO: NOT IMPLEMENTED
enum Associativity {
    Left;
    Right;
}

class OperatorNode extends Node {

    public final left:Node;
    public final right:Node;
    public final symbol:String;
    public final assoc:Associativity;
    public final precedence:Int;

    public function new(left:Node, right:Node, symbol:String, assoc:Associativity, precedence:Int) {
        this.left = left;
        this.right = right;
        this.symbol = symbol;
        this.assoc = assoc;
        this.precedence = precedence;
    }

    override function toString():String {
        final buff = new StringBuf();

        if (left is OperatorNode) {
            final cLeft = cast(left, OperatorNode);
            if (cLeft.precedence > precedence) {
                buff.add('($left)');
            } else {
                buff.add(left.toString());
            }
        } else {
            buff.add(left.toString());
        }

        buff.add(' $symbol ');

        if (right is OperatorNode) {
            final cRight = cast(right, OperatorNode);
            if (cRight.precedence >= precedence) {
                buff.add('($right)');
            } else {
                buff.add(right.toString());
            }
        } else {
            buff.add(right.toString());
        }

        return buff.toString();
    }
}