myApp.controller 'ExploreCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', 'ExploreFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, ExploreFctry) ->
  $scope.genreList = []
  $scope.songbookOption = 
    pageSize: 10
    page: 1
    sort: 'Title:1'
    genre: undefined
    title: undefined
    artist: undefined
  $scope.songs = 
    list: []
    total: []
    pagesNum: 0

  $scope.pageSizesList = [10, 20, 50, 100]
  $scope.pagesList = [1..5]

  if $state.current.name.search('pop') >= 0
    $rootScope.product = 
      name: 'pop'
    $scope.mainTitle = 'Vōchie Pop Song Book'
    $scope.description = 
      text: 'more country songs'
      link: "country.songbook"
    $rootScope.title = 'Vōchie Pop - Song Book'
  else if $state.current.name.search('country') >= 0
    $rootScope.product =
      name: 'country'
    $scope.mainTitle = 'Vōchie Country Song Book'
    $scope.description = 
      text: 'more pop songs'
      link: "pop.songbook"
    $rootScope.title = 'Vōchie Country - Song Book'

  initializeSongbookList = (product) ->
    ExploreFctry.getGenreList product
    .then (successRes) ->
      $scope.genreList = successRes
    ExploreFctry.getMedia product, $scope.songbookOption.pageSize, $scope.songbookOption.page - 1
    .then (successRes) ->
      console.log successRes
      if successRes.msg is 'query success'
        $scope.songs.list = successRes.data.rows
        $scope.songs.total = successRes.data.total
        $scope.songs.pagesNum = Math.ceil $scope.songs.total / $scope.songbookOption.pageSize
        $scope.pagesList = [1..$scope.songs.pagesNum]
      console.log $scope.songs

  $scope.jumpToPage = (pageNum) ->
    $scope.songbookOption.page = pageNum

  $scope.changePage = (num) ->
    $scope.songbookOption.page += num

  $scope.changeRecSort = ->
    if $scope.songbookOption.sort isnt 'CoverCount:-1'
      $scope.songbookOption.sort = 'CoverCount:-1'
    else
      $scope.songbookOption.sort = 'Title:1'
  
  $scope.resetOptions = ->
    $scope.songbookOption = 
      pageSize: 10
      page: 1
      sort: 'Title:1'
      genre: undefined
      title: undefined
      artist: undefined

  $scope.searchMedia = (pageSize, page, genre, title, artist, sort) ->
    if !title and !artist and !genre
      ExploreFctry.getMedia $rootScope.product.name, pageSize, page, genre, title, artist, sort
      .then (successRes) ->
        console.log successRes
        if successRes.msg is 'query success'
          $scope.songs.list = successRes.data.rows
          $scope.songs.total = successRes.data.total
          $scope.songs.pagesNum = Math.ceil $scope.songs.total / $scope.songbookOption.pageSize
          $scope.pagesList = [1..$scope.songs.pagesNum]
        console.log $scope.songs
    else 
      ExploreFctry.getMediaSearch $rootScope.product.name, pageSize, page, genre, title, artist, sort
      .then (successRes) ->
        console.log successRes
        if successRes.msg is 'query success'
          $scope.songs.list = successRes.data.rows
          $scope.songs.total = successRes.data.total
          $scope.songs.pagesNum = Math.ceil $scope.songs.total / $scope.songbookOption.pageSize
          $scope.pagesList = [1..$scope.songs.pagesNum]
        console.log $scope.songs

  # use watch array to reduce code size
  timer = undefined
  $scope.$watch '[ songbookOption.pageSize, songbookOption.page, songbookOption.sort, songbookOption.genre, songbookOption.title, songbookOption.artist ]', (newVal, oldVal) ->

    # In order to reduce requests, function will not work until newVal unequal to pageSize
    if newVal isnt oldVal
      # update value
      $scope.songbookOption.pageSize = newVal[0]
      $scope.songbookOption.sort = newVal[2]
      $scope.songbookOption.genre = newVal[3]
      $scope.songbookOption.title = newVal[4]
      $scope.songbookOption.artist = newVal[5]

      # when genre is changed, sets page and inputPage as 1.
      if newVal[3] isnt oldVal[3] or newVal[0] isnt oldVal[0]
        $scope.songbookOption.page = 1
      else
        $scope.songbookOption.page = newVal[1]

      # when filterTitle or filterArtist is changed, sets page as 1.
      for index in [4...6]
        if newVal[index] isnt oldVal[index]
          $scope.songbookOption.page = 1

      # check
      if $scope.songbookOption.page > $scope.songs.pagesNum
        $scope.songbookOption.page = $scope.songs.pagesNum

      if $scope.songbookOption.page < 0
        $scope.songbookOption.page = 0


      $timeout.cancel timer
      timer = $timeout ->
        $scope.searchMedia $scope.songbookOption.pageSize, $scope.songbookOption.page - 1, $scope.songbookOption.genre, $scope.songbookOption.title, $scope.songbookOption.artist, $scope.songbookOption.sort
      , 300

  , true

  initializeSongbookList $rootScope.product.name
]