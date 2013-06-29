surrogate inheritance
function Animal() {};
function Cat() {
	Animal.apply(this, arguments)
};
function Dummy(){
};

Dummy.prototype = Animal.prototype;
Dummy.prototype.constructor = Cat;
Cat.prototype = new Dummy();