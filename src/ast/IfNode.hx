package ast;

class IfNode extends Node {

    public final condition:Node;
    public final consequence:BlockNode;
    public final alternative:BlockNode;

    public function new(condition:Node, consequence:BlockNode, alternative:BlockNode) {
        this.condition = condition;
        this.consequence = consequence;
        this.alternative = alternative;
    }

    override function toString():String {
        final s = new StringBuf();

        s.add('if $condition ');
        s.add(consequence.toString());
        if (alternative.body.length > 0) {
            s.add(" else ");
            if (alternative.body.length == 1 && alternative.body[0] is IfNode) {
                final cIf = cast(alternative.body[0], IfNode);
                cIf.alternative.indentWidth = alternative.indentWidth;
                cIf.consequence.indentWidth = alternative.indentWidth;
                alternative.indentWidth--;
                s.add(cIf.toString());
            } else {
                s.add(alternative.toString());
            }
        };

        return s.toString();
    }
}