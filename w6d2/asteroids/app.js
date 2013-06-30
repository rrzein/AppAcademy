$(function () {
  var canvas = $("<canvas width='" + 500 +
  "' height='" + 500 + "'" +
  "style=\"border:1px solid #000000;\"></canvas>");
  $('body').append(canvas);

  // `canvas.get(0)` unwraps the jQuery'd DOM element;
  new Game(500, 500, 5).start(canvas.get(0));
});



function MovingObject(x, y) {
  this.x = x;
  this.y = y;
  this.velocity = { dx: 0, dy: 0 };
}

MovingObject.prototype.update = function() {
  var dx = this.velocity.dx;
  var dy = this.velocity.dy;
  this.x += dx;
  this.y += dy;
};

MovingObject.prototype.isOffScreen = function() {
  if ((this.x < -10 || this.y < -10) || (this.x > 510 || this.y > 510)) {
    return true;
  } else {
    return false;
  }
};

MovingObject.prototype.correctPosition = function() {

  if (this.x < 0) {
    this.x += 500;
  } else if (this.x > 500) {
    this.x -= 500;
  };

  if (this.y < 0) {
    this.y += 500;
  } else if (this.y >500) {
    this.y -= 500;
  };
};

//need prototype inheritance?
function Asteroid(x, y, radius) {
  MovingObject.apply(this, arguments);
  this.radius = 10;
  this.velocity = {};
  this.velocity.dx = Math.random() * 2 - 1;
  this.velocity.dy = Math.random() * 2 - 1;
};

Asteroid.prototype = new MovingObject();

Asteroid.MAX_RADIUS = 25;
Asteroid.randomAsteroid = function(maxX, maxY) {
  return new Asteroid(
    maxX * Math.random(),
    maxY * Math.random(),
    Asteroid.MAX_RADIUS * Math.random()
  );
};

Asteroid.newEdgeAsteroid = function(maxX, maxY) {
    var x_coords = [0, maxX];
    var x = x_coords[Math.floor(Math.random() * x_coords.length)];
    var y_coords = [0, maxY];
    var y = y_coords[Math.floor(Math.random() * y_coords.length)];

    return new Asteroid(
        x,
        y,
        Asteroid.MAX_RADIUS * Math.random()
      );
    };

Asteroid.prototype.draw = function(ctx) {
  ctx.fillStyle = "green";
  ctx.beginPath();

  ctx.arc(
    this.x,
    this.y,
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

function Ship(x, y) {
  MovingObject.apply(this, arguments);
  this.shipL = 10;
  //this.shipH = 15;
  this.velocity.dx = 1;
  this.velocity.dy = 1;
  this.angle = 3*Math.PI/2
};

Ship.prototype = new MovingObject();

Ship.prototype.drawShip = function(ctx) {
  var centerX = this.x;
  var centerY = this.y;
  var dx = this.velocity.dx;
  var dy = this.velocity.dy;
  var length = Math.sqrt(dx * dx + dy * dy);
  dx /= length;
  dy /= length;
  var shipL = 10;
  var shipH = 15;

  ctx.fillStyle = "blue";
  ctx.beginPath();

  ctx.arc(
    this.x,
    this.y,
    this.shipL,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();

  ctx.fillStyle = "black";
  ctx.beginPath();

  ctx.arc(
    this.x,
    this.y,
    this.shipL/5,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
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

function Bullet(x, y, velocity) {
  this.x = x;
  this.y = y;
  this.velocity = velocity;
  this.speed = 10;
}

Bullet.prototype = new MovingObject();

Bullet.prototype.draw = function(context) {

  var bSize = 1;
  context.beginPath();
  context.moveTo(this.x, this.y);
  context.lineTo(this.x + this.velocity.dx * bSize, this.y + this.velocity.dy * bSize);
  context.lineWidth = 3;
  context.strokeStyle = 'black';
  context.stroke();

};

Bullet.prototype.isHit = function(asteroid) {
  var x = this.x - asteroid.x;
  var y = this.y - asteroid.y;
  var dist = Math.sqrt((x * x) + (y * y));
  if (dist <= asteroid.radius) {
    return true;
  }
  return false;
}

function Game(xDim, yDim, numAsteroids) {
  this.xDim = xDim;
  this.yDim = yDim;
  this.bullets = [];
  this.ship = new Ship(this.xDim/2, this.yDim/2);
  this.asteroids = [];
  for (var i = 0; i <numAsteroids; i++) {
    this.asteroids.push(Asteroid.randomAsteroid(xDim, yDim));
  }
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(0, 0, this.xDim, this.yDim);

  for (var i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].draw(ctx);
  }

  this.ship.drawShip(ctx);

  for (var j = 0; j < this.bullets.length; j++) {
    if (this.bullets[j]) {
      this.bullets[j].draw(ctx);
    }
  }
};

Game.prototype.start = function(canvasEl) {
  var ctx = canvasEl.getContext('2d');
  var that = this;
  this.keys();
  this.interval = window.setInterval(function() {
    that.draw(ctx);
    that.update();
  }, 33);
};

Game.prototype.update = function(){
  for(var i = 0; i < this.asteroids.length; i++){
    if (this.asteroids[i].isOffScreen()) {
      this.asteroids[i] = Asteroid.newEdgeAsteroid(this.xDim, this.yDim);
    };
    this.asteroids[i].update();
  };

  for(var i = 0; i < this.bullets.length; i++) {
    for(var j = 0; j < this.asteroids.length; j++) {
      if (this.bullets[i]) {
        if (this.bullets[i].isHit(this.asteroids[j])) {
        this.bullets.splice(i, 1);
        this.asteroids[j] = Asteroid.newEdgeAsteroid(this.xDim, this.yDim);
        }
      }
    }
  }

  for(var j = 0; j < this.bullets.length; j++){
      if (this.bullets[j].isOffScreen()) {
        this.bullets.splice(j, 1);
      } else {
      this.bullets[j].update();
    };
  };
  //check is ship is off the screen, then
  this.ship.correctPosition();
  this.ship.update();

  if (this.ship.isHit(this.asteroids)) {
    console.log("Hit");
    window.clearInterval(this.interval);
  }

};

Game.prototype.keys = function() {
  var that = this;
  key('a', function() {
    that.ship.power(-1,0);
  });
  key('w', function() {
    that.ship.power(0,-1);
  });
  key('s', function() {
    that.ship.power(0,1);
  });
  key('d', function() {
    that.ship.power(1,0);
  });
  key('left', function() {
    that.ship.rotate(-.5);
  });
  key('right', function() {
    that.ship.rotate(+.5);
  });
  key('space', function() {
    that.ship.fireBullet(that);
    // var bullet = new Bullet()
    //     that.bullets.push();
  });
}