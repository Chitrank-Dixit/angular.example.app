angular.module('routes')
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {redirectTo: '/login' })
      .when('/projects',{
        templateUrl: 'html/projects/projects.html',
        controller: 'ProjectsController'
      })
      .when('/projects/new',{
        templateUrl: 'html/projects/new.html',
        controller: 'ProjectsNewController'
      })
      .when('/projects/edit/:id',{
        templateUrl: 'html/projects/edit.html',
        controller: 'ProjectsEditController'
      })
      .when('/login',{
        templateUrl: 'html/login.html',
        controller: 'LoginController'
      })
      .when('/logout',{
        template: ' ',
        controller: 'LogoutController'
      })
      .when('/register',{
        templateUrl: 'html/register.html',
        controller: 'RegisterController'
      })
      .otherwise({
        template: "This doesn't exist!"
      });
  });
  