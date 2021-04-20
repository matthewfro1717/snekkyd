package ast;

class BlockNode extends Node {

    public final body:Array<Node> = [];
    public final parent:BlockNode;
    public var indentWidth = 0;

    public function new(parent:BlockNode) {
        this.parent = parent;

        indentWidth = getIndentWidth();
    }

    function getIndentWidth() {
        return if (parent != null) {
            parent.indentWidth + 1;
        } else {
            indentWidth;
        }
    }

    public function addNode(node:Node) {
        body.push(node);
    }

    function repeatString(r:Int, s:String):String {
        return [for (_ in 0...r) s].join("");
    }

    override public function toString():String {
        final s = new StringBuf();

        if (getIndentWidth() > 0) {
            s.add("{\r\n");
        }
        for (node in body) {
            s.add(repeatString(getIndentWidth(), "    "));
            s.add(node.toString());
            s.add("\r\n");
        }
        s.add(repeatString(getIndentWidth() - 1, "    "));
        if (getIndentWidth() > 0) {
            s.add("}");
        }

        return s.toString();
    }
}