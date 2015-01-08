myApp.directive 'checkHide', ['$rootScope', '$timeout', 'CoverFctry', 
($rootScope, $timeout, CoverFctry) ->
  (scope, el, attrs) ->
    coverId = attrs.coverId
    if $rootScope.user._id
      el.on 'click', 'a.hide-cover', (e) ->
        CoverFctry.setStatus coverId, 0
        .then (successRes) ->
          if successRes.msg is 'updated success'
            scope.initializeUserCovers()

      el.on 'click', 'a.show-cover', (e) ->
        CoverFctry.setStatus coverId, 1
        .then (successRes) ->
          if successRes.msg is 'updated success'
            scope.initializeUserCovers()
]

myApp.directive 'checkLike', ['$rootScope', '$timeout', 'LikeFctry', 
($rootScope, $timeout, LikeFctry) ->
  (scope, el, attrs) ->
    coverId = attrs.coverId
    check = ->
      $timeout ->
        if $.inArray(coverId, $rootScope.user.likesList) > 0
          $(el).children('a.like-cover').hide()
          $(el).children('a.dislike-cover').show().css('display','inline-block').removeClass('disabled')
        else
          $(el).children('a.like-cover').show().css('display','inline-block').removeClass('disabled')
          $(el).children('a.dislike-cover').hide()
      , 0

    likeCover = ->
      LikeFctry.like coverId
      .then (successRes) ->
        check()

    if $rootScope.user._id
      el.on 'click', 'a.like-cover', ->
        likeCover()
        $rootScope.user.likesList.push coverId
      el.on 'click', 'a.dislike-cover', ->
        likeCover()
        $rootScope.user.likesList.splice $.inArray(coverId, $rootScope.user.likesList), 1
      check()
]