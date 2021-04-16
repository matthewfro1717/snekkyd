import haxe.io.Bytes;
import decompiler.Decompiler;

@:expose
class SnekkyDecompiler {

    public function decompileBytes(code:Bytes):String {
        final decompiler = new Decompiler(code);
        return decompiler.decompileToString();
    }

    public static function main() {
        #if target.sys
        final code = sys.io.File.getBytes(Sys.args()[0]);
        final outDir = Sys.args()[1];
        final decompiler = new Decompiler(code);
        decompiler.decompile(outDir);
        #end
    }
}