// Asteroids = (function() {
  function MovingObject(x, y) {
    this.x = x;
    this.y = y;
  }

  MovingObject.prototype.update = function(velocity) {
    dx = velocity.x;
    dy = velocity.y;
    this.x += dx;
    this.y += dy;
  };

  MovingObject.prototype.isOffScreen = function(ctx) {
    if (this.x < 0 || this.y < 0) || (this.x > 500 || this.y > 500) {
      return true;
    } else {
      return false;
    }
  };

  //need prototype inheritance?
  function Asteroid(x, y, radius) {
    MovingObject.apply(this, arguments);
    this.radius = radius;
    this.velocity = {};
    this.velocity.dx = Math.random() * 2;
    this.velocity.dy = Math.random() * 2;
  };

  // Asteroid.prototype = new MovingObject();

  Asteroid.MAX_RADIUS = 25;
  Asteroid.randomAsteroid = function(maxX, maxY) {
    return new Asteroid(
      maxX * Math.random(),
      maxY * Math.random(),
      Asteroid.MAX_RADIUS * Math.random();
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

  function Game(xDim, yDim, numAsteroids) {
    this.xDim = xDim;
    this.yDim = yDim;
    this.asteroids = [];
    for (var i = 0; i <numAsteroids; i++) {
      this.asteroids.push(Asteroid.randomAsteroid(xDim, yDim));
    }
  };

  Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, this.xDim, this.yDim);

    for (var i = 0; i < this.asteroids.length; i++) {
      console.log(this.asteroids[i]);
      this.asteroids[i].draw(ctx);
    }
  };

  Game.prototype.start = function(canvasEl) {
    var ctx = canvasEl.getContext('2d');
    var that = this;
    window.setInterval(function() {
      that.draw(ctx);
    }, 33);
  };


//   return {
//     Game: Game,
//     MovingObject: MovingObject,
//     Asteroid: Asteroid
//   };
//
// })();