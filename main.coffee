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

    lio_vertex = [
        [
            {x:20.281690140845086, y:15.774647887323965},
            {x:-4.507042253521121, y:22.535211267605632},
            {x:-36.05633802816901, y:-2.253521126760546},
            {x:-31.549295774647874, y:-20.281690140845058},
            {x:4.507042253521149, y:-20.281690140845058},
            {x:20.281690140845086, y:-11.267605633802816},
        ]
    ]

    Lio = enchant.Class.create PhyPolygonSprite,
        initialize: (x = GAME_WIDTH / 2, y = GAME_HEIGHT / 2) ->
            lio_num = 0
            img = lio_imgs[lio_num]
            vertex = []
            for v in lio_vertex[lio_num]
                vertex.push new b2Vec2 v.x, v.y

            # vertex = lio_vertex[lio_num]
            PhyPolygonSprite.call this, img.width , img.height, vertex, DYNAMIC_SPRITE, 1.0, 1.0, BOUNCE, no

            this.image = game.assets[img.url]

            this.position =
                x: x
                y: y

            game.rootScene.addChild this

        update: ->


    Floor = enchant.Class.create PhyBoxSprite,
        initialize: ->
            PhyBoxSprite.call this, GAME_WIDTH - 20, 20, STATIC_SPRITE, 1.0, 1.0, 0.0, true

            this.x = 10
            this.y = GAME_HEIGHT - this.height
            this.backgroundColor = "green"
            game.rootScene.addChild this


    # game のセットアップ
    game = enchant.Core GAME_WIDTH, GAME_HEIGHT
    game.fps = 60
    game.rootScene.backgroundColor = "aqua"
    # 画像のロード
    for img in lio_imgs
        game.preload img.url,

    game.onload = ->
        world = new PhysicsWorld 0.0, GRAVITY
        new Floor

        # 多角験テスト
        vertexCount = 6
        radius = 20
        vertexs = new Array()
        for i in [0...vertexCount]
            vertexs[i] = new b2Vec2(radius * Math.cos(2 * Math.PI / vertexCount * i), radius * Math.sin(2 * Math.PI / vertexCount * i))

        phyPolygonSprite = new PhyPolygonSprite(radius * 2, radius * 2, vertexs, DYNAMIC_SPRITE, 1.0, 0.1, 0.2, true)
        phyPolygonSprite.position = { x: game.width / 3, y: 0 }
        game.rootScene.addChild(phyPolygonSprite) # シーンに追加

        new Lio

        game.rootScene.addEventListener 'touchstart', (e) ->
            exports.lio = new Lio e.x, LIO_DEFAULT_Y

        game.rootScene.addEventListener 'touchmove', (e) ->
            if not exports.lio? then return
            exports.lio.position =
                x: e.x
                y: LIO_DEFAULT_Y

        game.rootScene.addEventListener 'touchend', ->
            if not exports.lio? then return
            exports.lio.setAwake true
            # exports.lio = null


        game.rootScene.onenterframe = (e) ->
            # 物理世界の時間を進める
            world.step game.fps

    game.start()
