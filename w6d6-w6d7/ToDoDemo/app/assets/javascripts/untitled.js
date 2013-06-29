prototypal inheritance:

function Dog(name) {
	this.name = name;
}

function Cat(name) {
	Dog.apply(this, arguments);
}

Cat.prototype = new Dog("obie");