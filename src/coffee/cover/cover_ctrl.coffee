myApp.controller 'CoverCtrl', ['$scope', '$rootScope', '$timeout', '$q', '$state', '$stateParams', 'CoverFctry',
($scope, $rootScope, $timeout, $q, $state, $stateParams, CoverFctry) ->
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
    playCount: 0
    setImage: ->
      this.userImage = "https://do4n1cuexrn6s.cloudfront.net/user/#{this.userId}_medium.png"
      this.coverImage = "https://do4n1cuexrn6s.cloudfront.net/cover/#{this._id}_medium.png"


  console.log $state
  if $state.current.name.search('pop') >= 0
    $rootScope.product = 
      name: 'pop'
  else if $state.current.name.search('country') >= 0
    $rootScope.product =
      name: 'country'

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
        $scope.coverInfo.setImage()
      $rootScope.title += "- #{$scope.coverInfo.title}"
      console.log $scope.coverInfo

  initializeCoverInfo $stateParams.id, $rootScope.product.name
]