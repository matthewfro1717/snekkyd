package ast;

class BlockNode extends Node {

    public final body:Array<Node> = [];
    public final parent:BlockNode;
    public var indentWidth = 0;

    public function new(parent:BlockNode) {
        this.parent = parent;

        if (parent != null) {
            indentWidth = parent.indentWidth + 1;
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

        if (indentWidth > 0) {
            s.add("{\r\n");
        }
        for (node in body) {
            s.add(repeatString(indentWidth, "    "));
            s.add(node.toString());
            s.add("\r\n");
        }
        s.add(repeatString(indentWidth - 1, "    "));
        if (indentWidth > 0) {
            s.add("}");
        }

        return s.toString();
    }
}