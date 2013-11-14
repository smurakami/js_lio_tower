enchant()
exports = this
window.onload = ->
    # 定数定義
    GAME_WIDTH  = 320
    GAME_HEIGHT = 320
    GRAVITY = 20 # 重力
    BOUNCE = 0.01 # 跳ね返り係数
    LIO_DEFAULT_Y = 20 # 最初のy座標
    lio = null # 操作対象のlio

    lio_imgs = [
        width: 80
        height: 50
        url: "img/lio00.png"
    ,]

    Lio = enchant.Class.create PhyBoxSprite,
        initialize: (x = GAME_WIDTH / 2, y = GAME_HEIGHT / 2) ->
            img_num = 0
            img = lio_imgs[img_num]
            PhyBoxSprite.call this,img.width , img.height, enchant.box2d.DYNAMIC_SPRITE, 1.0, 1.0, BOUNCE, no

            # this.image = img.url
            this.image = game.assets[img.url]

            this.position =
                x: x
                y: y

            game.rootScene.addChild this

        update: ->


    Floor = enchant.Class.create PhyBoxSprite,
        initialize: ->
            PhyBoxSprite.call this, GAME_WIDTH - 20, 20, enchant.box2d.STATIC_SPRITE, 1.0, 1.0, 0.0, true

            this.x = 10;
            this.y = GAME_HEIGHT - this.height
            this.backgroundColor = "green"
            game.rootScene.addChild this


    # game のセットアップ
    game = enchant.Core GAME_WIDTH, GAME_HEIGHT
    game.fps = 30
    game.rootScene.backgroundColor = "aqua"
    # 画像のロード
    for img in lio_imgs
        game.preload img.url,

    game.onload = ->
        world = new PhysicsWorld 0.0, GRAVITY
        new Floor

        game.rootScene.addEventListener 'touchstart', (e) ->
            exports.lio = new Lio e.x, LIO_DEFAULT_Y

        game.rootScene.addEventListener 'touchmove', (e) ->
            if not exports.lio? then return
            exports.lio.position =
                x: e.x
                y: exports.lio_DEFAULT_Y

        game.rootScene.addEventListener 'touchend', ->
            if not exports.lio? then return
            exports.lio.setAwake true
            # exports.lio = null


        game.rootScene.onenterframe = (e) ->
            # 物理世界の時間を進める
            world.step game.fps

    game.start()
