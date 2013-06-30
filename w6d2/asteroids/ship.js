function Ship(x, y) {
  MovingObject.apply(this, arguments);
  this.shipL = 25;
  this.shipH = 15;
  this.velocity.dx = 1;
  this.velocity.dy = 1;
};

Ship.prototype = new MovingObject();

Ship.prototype.drawShip = function(context) {
  var centerX = this.x;
  var centerY = this.y;
  var shipL = 25;
  var shipH = 15;
  var shipHatRad = 7;
  context.save();
  context.beginPath();
  context.arc(centerX, centerY - shipH * .5, shipHatRad, Math.PI, 0, false);
  context.strokeStyle = '#DF7401';
  context.lineWidth = shipHatRad;
  context.stroke();

  context.beginPath();
  context.moveTo(centerX - shipL/2, centerY);
  context.lineTo(centerX + shipL/2, centerY);
  context.lineWidth = shipH;
  context.strokeStyle = '#2E2EFE';
  context.lineCap = 'round';
  context.stroke();

  context.restore();
};

Ship.prototype.isHit = function(asteroids) {
  for(var i = 0; i < asteroids.length; i++) {
    var dist = this.countDist(asteroids[i]);
    var shipR = this.shipL/2;
    var asteroidR = asteroids[i].radius;
    if (dist < (shipR + asteroidR)) {
      return true;
    }
  }
  return false;
};

Ship.prototype.rotate = function(change) {
  this.velocity.dx += change;
}

Ship.prototype.countDist = function(asteroid) {
  var x = this.x - asteroid.x;
  var y = this.y - asteroid.y;
  return Math.sqrt((x * x) + (y * y));
};



Ship.prototype.power = function(px, py){
  this.velocity.dx += px;
  this.velocity.dy += py;
  console.log("Moved");
};

Ship.prototype.fireBullet = function(game) {

  bvelo = {};
  bvelo.dx = this.velocity.dx;
  bvelo.dy = this.velocity.dy;

  var bullet = new Bullet(this.x, this.y, bvelo);
  bullet.velocity.dx *= 3;
  bullet.velocity.dy *= 3;
  game.bullets.push(bullet);
}