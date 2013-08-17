angular.module('quizApp')

  .controller 'LogInCtrl', ($scope, $location, AuthService, Flash, LoginValidator) ->
    onError = (error) ->
      Flash.now.error(error)

    $scope.login = ->
      Flash.now.reset()
      if LoginValidator.validate($scope, onError)
        $scope.processing = true

        success = ->
          Flash.future.success("Welcome!")
          $location.path('/')

        error = (error) ->
          Flash.now.error(error.message || error)
          $scope.processing = false

        AuthService.login($scope.email, $scope.password).then(success, error)