package object;

enum Object {
    Number(value:Float);
    String(value:String);
    Function(position:Int, parametersCount:Int);
    Null;
    Boolean(value:Bool);
}