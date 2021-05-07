import haxe.crypto.Base64;
import ast.BlockNode;
import haxe.ds.StringMap;
import haxe.io.Bytes;
import decompiler.Decompiler;

@:expose
class SnekkyDecompiler {

    public static function decompileBytes(code:Bytes):String {
        final decompiler = new Decompiler(code);
        decompiler.decompile();
        return decompiler.decompileToString();
    }

    public static function decompileBase64(code:String):StringMap<String> {
        final decompiler = new Decompiler(Base64.decode(code));
        decompiler.decompile();
        return decompiler.decompileToMap();
    }

    public static function main() {
        #if target.sys
        final code = sys.io.File.getBytes(Sys.args()[0]);
        final outDir = Sys.args()[1];
        final decompiler = new Decompiler(code);
        decompiler.decompile();
        decompiler.save(outDir);
        #end
    }
}
