myApp.controller 'CoverCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', 'CoverFctry', 'RankFctry', 'CommentFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, CoverFctry, RankFctry, CommentFctry) ->
  $scope.coverInfo = 
    _id: ''
    userId: ''
    username: ''
    title: ''
    artist: ''
    createdAt: ''
    status: 0
    commentCount: 0
    likes: 0
    pinCount: 0
    playCount: 0
    setImage: ->
      this.userImage = "https://do4n1cuexrn6s.cloudfront.net/user/#{this.userId}_medium.png"
      this.coverImage = "https://do4n1cuexrn6s.cloudfront.net/cover/#{this._id}_medium.png"
      $('.lazy').lazyLoadXT({edgeY: '200'})

  $scope.comments = 
    list: []
    total: 0
    page: 0

  $scope.editComment = undefined

  $scope.recommend = 
    list: []
    fullList: []
    moreCovers: ->
      if this.fullList.length isnt 0
        this.list = this.list.concat this.fullList.splice 0, 5
        console.log this.list

  $scope.mostLike = 
    list: []
    fullList: []
    moreCovers: ->
      if this.fullList.length isnt 0
        this.list = this.list.concat this.fullList.splice 0, 5
        console.log this.list

  ### Check Product Type ###
  if $state.current.name.search('pop') >= 0
    $rootScope.product = 
      name: 'pop'
      googlePlay: "https://play.google.com/store/apps/details?id=com.deansoft.singnshare"
      appStore: "https://itunes.apple.com/us/app/sing-n-share/id774502972?ls=1&mt=8"
    $scope.coverLink = 'pop.cover'
  else if $state.current.name.search('country') >= 0
    $rootScope.product =
      name: 'country'
      googlePlay: "https://play.google.com/store/apps/details?id=com.deansoft.singnshare"
      appStore: "https://itunes.apple.com/us/app/sing-n-share/id774502972?ls=1&mt=8"
    $scope.coverLink = 'country.cover'

  initializeCoverInfo = (coverId, product) ->
    CoverFctry.getCover coverId, product
    .then (successRes) ->
      console.log successRes
      if successRes.data
        $scope.coverInfo._id = successRes.data._id
        $scope.coverInfo.userId = successRes.data.user_id
        $scope.coverInfo.username = successRes.data.user_name
        $scope.coverInfo.title = successRes.data.song.Title
        $scope.coverInfo.artist = successRes.data.song.ArtistName
        $scope.coverInfo.createdAt = successRes.data.created_at
        $scope.coverInfo.status = successRes.data.status
        $scope.coverInfo.commentCount = successRes.data.comment_total
        $scope.coverInfo.likes = successRes.data.likes.total
        $scope.coverInfo.pinCount = successRes.data.pins.length
        $scope.coverInfo.playCount = successRes.data.play_count
        $scope.coverInfo.path = successRes.data.path
        $scope.coverInfo.setImage()
      $rootScope.title = "Vōchie Pop - #{$scope.coverInfo.title} by #{$scope.coverInfo.username}"
      console.log $scope.coverInfo
  
  initailizeCommentsList = (coverId, product) ->
    CommentFctry.getCoverComments product, coverId, 5, $scope.comments.page
    .then (successRes) ->
      console.log successRes
      if successRes.data
        $scope.comments.list = successRes.data.rows
        $scope.comments.total = successRes.data.total
        for i in $scope.comments.list
          i.comment = i.comment.replace /\\n/g, "<br>"
      console.log $scope.comments

  initailizeRecommends = (coverId, product) ->
    CoverFctry.getRecommend coverId, product
    .then (successRes) ->
      console.log successRes
      list = []
      angular.forEach successRes.data.rows, (item) ->
        list.push
          coverId: item._id
          userId: item.user_id
          username: item.user_name
          title: item.song.Title
          artist: item.user_name
          status: item.status
          likes: item.likes.total
          playCount: item.play_count
          path: item.path
      $scope.recommend.fullList = list
      $scope.recommend.list = $scope.recommend.fullList.splice 0, 5
      console.log $scope.recommend

  initializeMostLike = ->
    RankFctry.getLikeRank 'month'
    .then (successRes) ->
      console.log successRes
      list = []
      angular.forEach successRes.data.rows, (item) ->
        if item.song.song
          list.push
            coverId: item.song._id
            userId: item.song.user_id
            username: item.song.user_name
            title: item.song.song.Title
            artist: item.song.user_name
            status: item.song.status
            likes: item.song.likes.total
            playCount: item.count
            path: item.song.path
            last: item.last
      $scope.mostLike.fullList = list
      $scope.mostLike.list = $scope.mostLike.fullList.splice 0, 5
      console.log $scope.mostLike

  $scope.transferServerTime = (time) ->
    server_time = new Date(time.replace(/-/g,'/')).getTime()
    date = new Date()
    localOffset = -1 * date.getTimezoneOffset() * 60000
    return Math.round(new Date(server_time + localOffset).getTime())

  $scope.playback = (item) ->
    if myPlaylist.playlist.length is 0
      myPlaylist.setPlaylist [
        coverId: item._id
        userId: item.userId
        username: item.username
        title: item.title
        artist: item.username
        m4a: item.path
        playCount: item.playCount
        likes: item.likes
      ]
    else 
      myPlaylist.add 
        coverId: item._id
        userId: item.userId
        username: item.username
        title: item.title
        artist: item.username
        m4a: item.path
        playCount: item.playCount
        likes: item.likes
    $rootScope.initPlayer = true
    console.log myPlaylist

  $scope.commentFunc = 
    moreComments: ->
      $scope.comments.page++
      CommentFctry.getCoverComments $rootScope.product.name, $stateParams.id, 5, $scope.comments.page
      .then (successRes) ->
        console.log successRes
        if successRes.data
          $scope.comments.list = $scope.comments.list.concat successRes.data.rows
          $scope.comments.total = successRes.data.total
          for i in $scope.comments.list
            i.comment = i.comment.replace /\\n/g, "<br>"
        console.log $scope.comments
    post: ->
      $scope.editComment = $scope.editComment.replace /\n/g, "\\n"
      CommentFctry.postComment $stateParams.id, $scope.editComment
      .then (successRes) ->
        console.log successRes
        $scope.editComment = ''
        initailizeCommentsList $stateParams.id, $rootScope.product.name
    remove: (commentId) ->
      CommentFctry.removeComment $stateParams.id, commentId
      .then (successRes) ->
        console.log successRes

        initailizeCommentsList $stateParams.id, $rootScope.product.name

  initializeCoverInfo $stateParams.id, $rootScope.product.name
  initailizeCommentsList $stateParams.id, $rootScope.product.name
  initailizeRecommends $stateParams.id, $rootScope.product.name
  initializeMostLike()
]