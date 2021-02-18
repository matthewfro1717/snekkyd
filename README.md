# Snekky Decompiler

A tool which can be used to decompile Snekky bytecode files (`.bite` extension). Still in early development.

## Installation
Download the latest version for your operating system of choice from the [releases page](https://github.com/snekkylang/decompiler/releases) or the latest build from the [actions tab](https://github.com/snekkylang/decompiler/actions).

## Usage
```
snekkyd <input> <out_folder>
```

## Examples
<table>
<tr>
<th>
Source
</th>
<th>
Decompiled
</th>
</tr>

<tr>
<td>
<pre>
let fact = func(n) {
&nbsp;&nbsp;&nbsp;&nbsp;return if n <= 1 {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1
&nbsp;&nbsp;&nbsp;&nbsp;} else {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;n * fact(n - 1)
&nbsp;&nbsp;&nbsp;&nbsp;};
};
</pre>
</td>

<td>
<pre>
mut fact = func(n) {
&nbsp;&nbsp;&nbsp;&nbsp;return if (n <= 1) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1
&nbsp;&nbsp;&nbsp;&nbsp;} else {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(n * fact((n - 1)))
&nbsp;&nbsp;&nbsp;&nbsp;};
};
</pre>
</td>

<td>
</tr>

<tr>
<td>
<pre>
for let i in 0...10 {
&nbsp;&nbsp;&nbsp;Sys.println(i);
}
</pre>
</td>

<td>
<pre>
mut var0 = Range.Exclusive(0, 10).Iterator();
&nbsp;
while var0.hasNext() {
&nbsp;&nbsp;&nbsp;&nbsp;mut i = var0.next();
&nbsp;&nbsp;&nbsp;&nbsp;Sys.println(i);
}
</pre>
</td>
</tr>

<tr>
<td>
<pre>
for let i in 0..100 {
&nbsp;&nbsp;&nbsp;&nbsp;Sys.println(when {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i % 3 == 0 && i % 5 == 0 => "FizzBuzz"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i % 3 == 0 => "Fizz"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i % 5 == 0 => "Buzz"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else => i
&nbsp;&nbsp;&nbsp;&nbsp;});
}
</pre>
</td>

<td>
<pre>
mut var0 = Range.Inclusive(0, 100).Iterator();
&nbsp;
while var0.hasNext() {
&nbsp;&nbsp;&nbsp;&nbsp;mut i = var0.next();
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;Sys.println(if (((i % 3) == 0) && ((i % 5) == 0)) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"FizzBuzz"
&nbsp;&nbsp;&nbsp;&nbsp;} else {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if ((i % 3) == 0) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"Fizz"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if ((i % 5) == 0) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"Buzz"
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;} else {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
&nbsp;&nbsp;&nbsp;&nbsp;});
}
</pre>
</td>
</tr>

<tr>
<td>
<pre>
let animals = [
&nbsp;&nbsp;&nbsp;&nbsp;{
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: "axolotl",
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cool: true
&nbsp;&nbsp;&nbsp;&nbsp;},
&nbsp;&nbsp;&nbsp;&nbsp;{
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name: "stork",
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cool: false
&nbsp;&nbsp;&nbsp;&nbsp;}
];
&nbsp;
let [axolotl, stork] = animals;
let {name} = axolotl;
&nbsp;&nbsp;&nbsp;
Sys.println(name);
</pre>
</td>

<td>
<pre>
mut animals = [{cool: true, name: "axolotl"}, {cool: false, name: "stork"}];
&nbsp;
mut var1 = animals;
&nbsp;
mut axolotl = var1[0];
&nbsp;
mut stork = var1[1];
&nbsp;
mut var4 = axolotl;
&nbsp;
mut name = var4.name;
&nbsp;
Sys.println(name);
</pre>
</td>
</tr>
</table>