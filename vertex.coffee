enchant()
exports = this
window.onload = ->
    # 定数定義
    GAME_WIDTH  = 320
    GAME_HEIGHT = 320
    GRAVITY = 20 # 重力
    BOUNCE = 0.30 # 跳ね返り係数
    LIO_DEFAULT_Y = 20 # 最初のy座標
    lio = null # 操作対象のlio


    lio_imgs = [
        width: 80
        height: 50
        url: "img/lio00.png"
    ,]

    vertex = []

    Lio = enchant.Class.create PhyBoxSprite,
        initialize: (x = GAME_WIDTH / 2, y = GAME_HEIGHT / 2) ->
            img_num = 0
            img = lio_imgs[img_num]
            PhyBoxSprite.call this,img.width , img.height, STATIC_SPRITE, 1.0, 1.0, BOUNCE, no

            # this.image = img.url
            this.image = game.assets[img.url]

            this.position =
                x: x
                y: y

            this.center = new Sprite(2, 2)
            this.center.backgroundColor = "blue"
            this.center.x = this.x + this.width/2
            this.center.y = this.y + this.height/2

            this.addEventListener 'touchstart', (e) ->
                new Vertex e.x, e.y
                vertex.push {x:e.x, y:e.y}

            game.rootScene.addChild this
            game.rootScene.addChild this.center

        update: ->


    Floor = enchant.Class.create PhyBoxSprite,
        initialize: ->
            PhyBoxSprite.call this, GAME_WIDTH - 20, 20, STATIC_SPRITE, 1.0, 1.0, 0.0, true

            this.x = 10;
            this.y = GAME_HEIGHT - this.height
            this.backgroundColor = "green"
            game.rootScene.addChild this

    Vertex = enchant.Class.create enchant.Sprite,
        initialize: (x, y) ->
            enchant.Sprite.call this, 2, 2
            this.x = x - 1
            this.y = y - 1
            this.backgroundColor = "red"
            game.rootScene.addChild this

    # game のセットアップ
    game = enchant.Core GAME_WIDTH, GAME_HEIGHT
    game.fps = 60
    game.rootScene.backgroundColor = "aqua"
    # 画像のロード
    for img in lio_imgs
        game.preload img.url,

    # 角度を計る関数
    exports.radian = (v)->
        x = v.x - lio.position.x
        y = v.y - lio.position.y
        if x is 0
            if y >= 0
                return Math.PI
            else
                return 3 * Math.PI
        else
            theta = Math.atan(y/x)
            if y < 0
                if x < 0 then theta += Math.PI
                else theta += 2 * Math.PI
            else if x < 0
                theta += Math.PI
        return theta

    game.onload = ->
        world = new PhysicsWorld 0.0, GRAVITY
        new Floor
        lio = new Lio GAME_WIDTH/2, GAME_HEIGHT/2

        button = new Sprite 20, 20
        button.x = 10
        button.y = 10
        button.backgroundColor = "red"
        game.rootScene.addChild button
        # vertexをoutput
        button.addEventListener 'touchstart', ->
            vertex.sort (a, b) ->
                if radian(a) < radian(b)
                    -1
                else
                    1
            s = ""
            for v in vertex
                s += "#{radian v}\n"
            console.log s

            s = "[\n"
            for v in vertex
                x = v.x - lio.position.x
                y = v.y - lio.position.y
                s += "    {x:#{x}, y:#{y}},\n"
            s += "]"
            console.log s



        # game.rootScene.addEventListener 'touchmove', (e) ->
        #     if not exports.lio? then return
        #     exports.lio.position =
        #         x: e.x
        #         y: LIO_DEFAULT_Y

        # game.rootScene.addEventListener 'touchend', ->
        #     if not exports.lio? then return
        #     exports.lio.setAwake true
        #     # exports.lio = null


        game.rootScene.onenterframe = (e) ->
            # 物理世界の時間を進める
            world.step game.fps

    game.start()
