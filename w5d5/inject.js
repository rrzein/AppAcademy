function myEach (array, fun) {
	this.new_array = []
	for (var i = 0; i < array.length; i++) {
		this.new_array[i] = fun(array[i])
	}
	return array;
};

function myMap (array,fun) {
	myEach(array,fun);
	return this.new_array;
};

function Inject(array, fun) {
	this.res = array[0]
	myEach(array, fun);
	return this.res;
};

function multiples (value) {
	return value * 2;
};

function add (val) {
	this.res += val;
};
function mult (val) {
	this.res *= val;
};
function sub (val) {
	this.res -= val;
}
function div (val) {
	this.res /= val;
}


// console.log(inject(array1, add));
array = [1, 2, 3, 4, 5]

console.log(myEach(array, multiples));
console.log(myMap(array, multiples));

console.log("Add");
console.log(Inject(array, add));
console.log("");
console.log("Mult");
console.log(Inject(array, mult));
console.log("Sub");
console.log(Inject(array, sub));
console.log("Div");
console.log(Inject(array, div));