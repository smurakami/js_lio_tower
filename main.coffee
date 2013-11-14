enchant()
global = this
window.onload = ->
    # 定数定義
    GAME_WIDTH  = 320
    GAME_HEIGHT = 320
    GRAVITY = 5 # 重力
    BOUNCE = 0.10 # 跳ね返り係数
    LIO_DEFAULT_Y = 30 # 最初のy座標
    MAX_LIO_NUM = 7 # lioちゃんの種類

    # 準グローバル変数
    lio = null # 操作対象のlio
    score = null # score
    game_is_over = false

    lio_imgs = [
        { width: 80, height: 50,  url: "img/lio00.png" },
        { width: 35, height: 50,  url: "img/lio01.png" },
        { width: 52, height: 50,  url: "img/lio02.png" },
        { width: 56, height: 50,  url: "img/lio03.png" },
        { width: 77, height: 50,  url: "img/lio04.png" },
        { width: 56, height: 60,  url: "img/lio05.png" },
        { width: 59, height: 50,  url: "img/lio06.png" },
        { width: 69, height: 60,  url: "img/lio07.png" },
    ]

    lio_vertex = [
        [
            {x:20.281690140845086, y:15.774647887323965},
            {x:-4.507042253521121, y:22.535211267605632},
            {x:-36.05633802816901, y:-2.253521126760546},
            {x:-31.549295774647874, y:-20.281690140845058},
            {x:4.507042253521149, y:-20.281690140845058},
            {x:20.281690140845086, y:-11.267605633802816},
        ],[
            {x:6.956521739130437, y:24.34782608695653},
            {x:-6.956521739130409, y:22.608695652173935},
            {x:-17.391304347826065, y:-10.434782608695627},
            {x:-12.173913043478251, y:-19.13043478260869},
            {x:1.7391304347826235, y:-24.347826086956502},
            {x:13.913043478260875, y:-22.608695652173907},
            {x:15.652173913043498, y:-6.956521739130409},
        ],[
            {x:22.85714285714286, y:5.4421768707483125},
            {x:22.85714285714286, y:14.149659863945573},
            {x:-7.61904761904762, y:22.85714285714286},
            {x:-25.03401360544217, y:-1.0884353741496398},
            {x:-20.680272108843525, y:-20.680272108843525},
            {x:-7.61904761904762, y:-22.85714285714286},
        ],[
            {x:25.034013605442198, y:18.503401360544217},
            {x:-3.265306122448976, y:22.85714285714286},
            {x:-22.85714285714286, y:9.795918367346957},
            {x:-22.85714285714286, y:-3.265306122448976},
            {x:-11.972789115646265, y:-22.85714285714286},
            {x:-5.442176870748284, y:-22.85714285714286},
            {x:18.503401360544217, y:-7.61904761904762},
        ],[
            {x:33.74149659863946, y:9.795918367346957},
            {x:27.210884353741505, y:20.680272108843553},
            {x:3.265306122448976, y:18.503401360544217},
            {x:-29.387755102040813, y:5.4421768707483125},
            {x:-35.918367346938766, y:-3.265306122448976},
            {x:-35.918367346938766, y:-20.680272108843525},
            {x:-3.265306122448976, y:-22.85714285714286},
            {x:29.387755102040813, y:-5.442176870748284},
        ],[
            {x:24.109589041095887, y:13.150684931506845},
            {x:-15.342465753424648, y:28.49315068493152},
            {x:-26.30136986301369, y:8.76712328767124},
            {x:6.575342465753437, y:-26.30136986301369},
            {x:19.72602739726028, y:-28.493150684931493},
            {x:26.30136986301369, y:-15.342465753424648},
        ],[
            {x:-5.442176870748284, y:22.85714285714286},
            {x:-25.03401360544217, y:11.972789115646265},
            {x:-11.972789115646265, y:-16.32653061224488},
            {x:14.149659863945573, y:-22.85714285714286},
            {x:27.210884353741505, y:-18.503401360544217},
            {x:22.85714285714286, y:-1.0884353741496398},
        ],[
            {x:20.680272108843553, y:16.32653061224491},
            {x:-33.74149659863944, y:27.210884353741505},
            {x:-18.503401360544217, y:-16.32653061224488},
            {x:20.680272108843553, y:-27.210884353741477},
            {x:31.56462585034015, y:-16.32653061224488},
        ]
    ]

    # -----------
    # Lioちゃん
    # -----------
    Lio = enchant.Class.create PhyPolygonSprite,
        initialize: (x = GAME_WIDTH / 2, y = LIO_DEFAULT_Y) ->
            lio_num = [0,1,2,4,5,6,7][Math.floor (Math.random() * MAX_LIO_NUM)]
            # lio_num = 5
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

            this.addEventListener "enterframe", this.update
            game.rootScene.addChild this
        update: ->
            if game_is_over
                this.clearEventListener()
                return
            if this.y > GAME_HEIGHT
                game_over()


    # -----------
    # 床
    # -----------
    Floor = enchant.Class.create PhyBoxSprite,
        initialize: ->
            PhyBoxSprite.call this, GAME_WIDTH - 20, 20, STATIC_SPRITE, 1.0, 1.0, 0.0, true

            this.x = 10
            this.y = GAME_HEIGHT - this.height
            this.backgroundColor = "#00FF00"
            game.rootScene.addChild this

            # 草
            cover = new Sprite(this.width, this.height)
            cover.x = this.x
            cover.y = this.y
            cover.backgroundColor = "green"
            game.rootScene.addChild cover

    # -----------
    # スコア
    # -----------

    Score = enchant.Class.create enchant.Label,
        initialize: ->
            enchant.Label.call(this, "0 匹")
            this.num = 0
            this.x = GAME_WIDTH - 50
            this.y = 10
            game.rootScene.addChild(this)
        gain: ->
            this.num++
            this.text = "#{this.num} 匹"

    # game のセットアップ

    game = new Game GAME_WIDTH, GAME_HEIGHT
    game.fps = 60
    game.rootScene.backgroundColor = "#00F1FF"
    # 画像のロード
    for img in lio_imgs
        game.preload img.url,

    game_over = ->
        game_is_over = true
        game.rootScene.clearEventListener()
        game.end score.num, "#{score.num} 匹積みました"

    game.onload = ->
        world = new PhysicsWorld 0.0, GRAVITY
        new Floor
        score = new Score

        setTimeout ->
            lio = new Lio
        , 200
        # ---------------
        # タッチ関連の処理
        # ---------------
        game.rootScene.addEventListener 'touchstart', (e) ->
            if not lio? then return
            lio.position =
                x: e.x
                y: LIO_DEFAULT_Y


        game.rootScene.addEventListener 'touchmove', (e) ->
            if not lio? then return
            lio.position =
                x: e.x
                y: LIO_DEFAULT_Y

        game.rootScene.addEventListener 'touchend', ->
            if not lio? then return
            lio.setAwake true
            lio = null
            score.gain()
            setTimeout ->
                lio = new Lio
            , 2000


        game.rootScene.onenterframe = (e) ->
            # 物理世界の時間を進める
            world.step game.fps

    game.start()
