angular.module('uinApp').factory 'reviewService', [
  '$http'
  '$stateParams'
  ($http, $stateParams) ->
    { fetch: (obj) ->
      $http.post('/activities/'+ $stateParams.activityId + '/reviews', review: obj)
    }
]

angular.module('uinApp').controller 'overviewsCtrl', [
  '$scope'
  '$http'
  '$stateParams'
  'reviewService'
  ($scope, $http, $stateParams, reviewService) ->
    $http.get('activities/'+$stateParams.activityId + '.json').success (res) ->
      $scope.promotionhash = res
      return

    $scope.submit = ->
      arr = angular.element(document.getElementsByName('id')[0]).val()
      obj = 
        content: $scope.reviewForm.content
        rating: $scope.reviewForm.rating
        user_id: arr
      localStorage.setItem("search", JSON.stringify(obj))
      reviewService.fetch(obj).success (res, status) ->
        $("#myModal").hide()
        $('.modal-backdrop').removeClass 'modal-backdrop'
        $scope.promotionhash.reviews = res
        return

    $scope.rate = [1, 2, 3, 4, 5]
]


angular.element(document).ready ->
  $('.rslides').responsiveSlides()
  console.log 'slide1'
  return