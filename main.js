// Generated by CoffeeScript 1.6.3
(function() {
  var global;

  enchant();

  global = this;

  window.onload = function() {
    var BOUNCE, Cloud, Floor, GAME_HEIGHT, GAME_WIDTH, GRAVITY, LIO_DEFAULT_Y, Lio, MAX_LIO_NUM, Score, Sun, game, game_is_over, game_over, img, lio, lio_imgs, lio_vertex, score, _i, _len;
    GAME_WIDTH = 320;
    GAME_HEIGHT = 320;
    GRAVITY = 5;
    BOUNCE = 0.10;
    LIO_DEFAULT_Y = 30;
    MAX_LIO_NUM = 7;
    lio = null;
    score = null;
    game_is_over = false;
    lio_imgs = [
      {
        width: 80,
        height: 50,
        url: "img/lio00.png"
      }, {
        width: 35,
        height: 50,
        url: "img/lio01.png"
      }, {
        width: 52,
        height: 50,
        url: "img/lio02.png"
      }, {
        width: 56,
        height: 50,
        url: "img/lio03.png"
      }, {
        width: 77,
        height: 50,
        url: "img/lio04.png"
      }, {
        width: 56,
        height: 60,
        url: "img/lio05.png"
      }, {
        width: 59,
        height: 50,
        url: "img/lio06.png"
      }, {
        width: 69,
        height: 60,
        url: "img/lio07.png"
      }
    ];
    lio_vertex = [
      [
        {
          x: 20.281690140845086,
          y: 15.774647887323965
        }, {
          x: -4.507042253521121,
          y: 22.535211267605632
        }, {
          x: -36.05633802816901,
          y: -2.253521126760546
        }, {
          x: -31.549295774647874,
          y: -20.281690140845058
        }, {
          x: 4.507042253521149,
          y: -20.281690140845058
        }, {
          x: 20.281690140845086,
          y: -11.267605633802816
        }
      ], [
        {
          x: 6.956521739130437,
          y: 24.34782608695653
        }, {
          x: -6.956521739130409,
          y: 22.608695652173935
        }, {
          x: -17.391304347826065,
          y: -10.434782608695627
        }, {
          x: -12.173913043478251,
          y: -19.13043478260869
        }, {
          x: 1.7391304347826235,
          y: -24.347826086956502
        }, {
          x: 13.913043478260875,
          y: -22.608695652173907
        }, {
          x: 15.652173913043498,
          y: -6.956521739130409
        }
      ], [
        {
          x: 22.85714285714286,
          y: 5.4421768707483125
        }, {
          x: 22.85714285714286,
          y: 14.149659863945573
        }, {
          x: -7.61904761904762,
          y: 22.85714285714286
        }, {
          x: -25.03401360544217,
          y: -1.0884353741496398
        }, {
          x: -20.680272108843525,
          y: -20.680272108843525
        }, {
          x: -7.61904761904762,
          y: -22.85714285714286
        }
      ], [
        {
          x: 25.034013605442198,
          y: 18.503401360544217
        }, {
          x: -3.265306122448976,
          y: 22.85714285714286
        }, {
          x: -22.85714285714286,
          y: 9.795918367346957
        }, {
          x: -22.85714285714286,
          y: -3.265306122448976
        }, {
          x: -11.972789115646265,
          y: -22.85714285714286
        }, {
          x: -5.442176870748284,
          y: -22.85714285714286
        }, {
          x: 18.503401360544217,
          y: -7.61904761904762
        }
      ], [
        {
          x: 33.74149659863946,
          y: 9.795918367346957
        }, {
          x: 27.210884353741505,
          y: 20.680272108843553
        }, {
          x: 3.265306122448976,
          y: 18.503401360544217
        }, {
          x: -29.387755102040813,
          y: 5.4421768707483125
        }, {
          x: -35.918367346938766,
          y: -3.265306122448976
        }, {
          x: -35.918367346938766,
          y: -20.680272108843525
        }, {
          x: -3.265306122448976,
          y: -22.85714285714286
        }, {
          x: 29.387755102040813,
          y: -5.442176870748284
        }
      ], [
        {
          x: 24.109589041095887,
          y: 13.150684931506845
        }, {
          x: -15.342465753424648,
          y: 28.49315068493152
        }, {
          x: -26.30136986301369,
          y: 8.76712328767124
        }, {
          x: 6.575342465753437,
          y: -26.30136986301369
        }, {
          x: 19.72602739726028,
          y: -28.493150684931493
        }, {
          x: 26.30136986301369,
          y: -15.342465753424648
        }
      ], [
        {
          x: -5.442176870748284,
          y: 22.85714285714286
        }, {
          x: -25.03401360544217,
          y: 11.972789115646265
        }, {
          x: -11.972789115646265,
          y: -16.32653061224488
        }, {
          x: 14.149659863945573,
          y: -22.85714285714286
        }, {
          x: 27.210884353741505,
          y: -18.503401360544217
        }, {
          x: 22.85714285714286,
          y: -1.0884353741496398
        }
      ], [
        {
          x: 20.680272108843553,
          y: 16.32653061224491
        }, {
          x: -33.74149659863944,
          y: 27.210884353741505
        }, {
          x: -18.503401360544217,
          y: -16.32653061224488
        }, {
          x: 20.680272108843553,
          y: -27.210884353741477
        }, {
          x: 31.56462585034015,
          y: -16.32653061224488
        }
      ]
    ];
    Lio = enchant.Class.create(PhyPolygonSprite, {
      initialize: function(x, y) {
        var img, lio_num, v, vertex, _i, _len, _ref;
        if (x == null) {
          x = GAME_WIDTH / 2;
        }
        if (y == null) {
          y = LIO_DEFAULT_Y;
        }
        lio_num = [0, 1, 2, 4, 5, 6, 7][Math.floor(Math.random() * MAX_LIO_NUM)];
        img = lio_imgs[lio_num];
        vertex = [];
        _ref = lio_vertex[lio_num];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          v = _ref[_i];
          vertex.push(new b2Vec2(v.x, v.y));
        }
        PhyPolygonSprite.call(this, img.width, img.height, vertex, DYNAMIC_SPRITE, 1.0, 1.0, BOUNCE, false);
        this.image = game.assets[img.url];
        this.position = {
          x: x,
          y: y
        };
        this.addEventListener("enterframe", this.update);
        return game.rootScene.addChild(this);
      },
      update: function() {
        if (game_is_over) {
          this.clearEventListener();
          return;
        }
        if (this.y > GAME_HEIGHT) {
          return game_over();
        }
      }
    });
    Sun = enchant.Class.create(enchant.Sprite, {
      initialize: function() {
        enchant.Sprite.call(this, 100, 100);
        this.x = GAME_WIDTH - 130;
        this.y = -40;
        this.image = game.assets['img/sun.png'];
        this.addEventListener("enterframe", function() {
          return this.rotate(0.4);
        });
        return game.rootScene.addChild(this);
      }
    });
    Cloud = enchant.Class.create(enchant.Sprite, {
      initialize: function() {
        enchant.Sprite.call(this, 120, 100);
        this.x = GAME_WIDTH;
        this.y = 0;
        this.image = game.assets['img/cloud.png'];
        this.addEventListener("enterframe", function() {
          this.x -= 0.15;
          if (this.x < -this.width) {
            return this.x = GAME_WIDTH;
          }
        });
        return game.rootScene.addChild(this);
      }
    });
    Floor = enchant.Class.create(PhyBoxSprite, {
      initialize: function() {
        var cover;
        PhyBoxSprite.call(this, GAME_WIDTH - 20, 20, STATIC_SPRITE, 1.0, 1.0, 0.0, true);
        this.x = 10;
        this.y = GAME_HEIGHT - this.height;
        this.backgroundColor = "#00FF00";
        game.rootScene.addChild(this);
        cover = new Sprite(this.width, this.height);
        cover.x = this.x;
        cover.y = this.y;
        cover.backgroundColor = "green";
        return game.rootScene.addChild(cover);
      }
    });
    Score = enchant.Class.create(enchant.Label, {
      initialize: function() {
        enchant.Label.call(this, "0");
        this.num = 0;
        this.x = 30;
        this.y = 10;
        return game.rootScene.addChild(this);
      },
      gain: function() {
        this.num++;
        return this.text = "" + this.num;
      }
    });
    game = new Game(GAME_WIDTH, GAME_HEIGHT);
    game.fps = 60;
    game.rootScene.backgroundColor = "#00F1FF";
    for (_i = 0, _len = lio_imgs.length; _i < _len; _i++) {
      img = lio_imgs[_i];
      game.preload(img.url);
    }
    game.preload("img/sun.png");
    game.preload("img/cloud.png");
    game_over = function() {
      game_is_over = true;
      game.rootScene.clearEventListener();
      return game.end(score.num, "" + score.num + " 匹積みました");
    };
    game.onload = function() {
      var world;
      world = new PhysicsWorld(0.0, GRAVITY);
      new Sun;
      new Cloud;
      new Floor;
      score = new Score;
      setTimeout(function() {
        return lio = new Lio;
      }, 200);
      game.rootScene.addEventListener('touchstart', function(e) {
        if (lio == null) {
          return;
        }
        return lio.position = {
          x: e.x,
          y: LIO_DEFAULT_Y
        };
      });
      game.rootScene.addEventListener('touchmove', function(e) {
        if (lio == null) {
          return;
        }
        return lio.position = {
          x: e.x,
          y: LIO_DEFAULT_Y
        };
      });
      game.rootScene.addEventListener('touchend', function() {
        if (lio == null) {
          return;
        }
        lio.setAwake(true);
        lio = null;
        score.gain();
        return setTimeout(function() {
          return lio = new Lio;
        }, 2000);
      });
      return game.rootScene.onenterframe = function(e) {
        return world.step(game.fps);
      };
    };
    return game.start();
  };

}).call(this);
