function Cat(name, owner) {
	this.name = name;
	this.owner = owner;
};

Cat.prototype.cute_statement = function() {
	return this.owner + " loves " + this.name;
};

var cat1 = new Cat("earl", "olena");
console.log(cat1);
console.log(cat1.cute_statement());

Cat.prototype.cute_statement = function() {
	return "everyone loves " + this.name;
};

var cat2 = new Cat("gizmo", "ricky");
console.log(cat1.cute_statement());
console.log(cat2.cute_statement());

Cat.prototype.meow = function() {
	console.log("Meow");
};

cat1.meow();
cat2.meow();
console.log("Second set of meows")
cat1.meow = function() {
	console.log("Meow meow");
}

cat1.meow();
cat2.meow();
