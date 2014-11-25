angular.module('projects.controllers')
.controller('ProjectsController', function($http, projectStatuses, dialogService, $scope, Project){
  $scope.projects = Project.query();
  // get status labels
  $scope.statuses = {};
  angular.forEach(projectStatuses, function(value, key) {
    this[value.value] = value.name;
  }, $scope.statuses);
  // delete handler
  $scope.deleteProject = function(project){
    dialogService.show('Delete this project ?', function() {
      project.$delete(function(){
        $scope.projects = Project.query();
      });
    });
  }
}).controller('ProjectsNewController', function(projectStatuses, $location, $scope, Project){
  $scope.project = new Project();
  $scope.statuses = projectStatuses;
  $scope.project.status = projectStatuses[0]['value'];
  $scope.addProject = function(isValid){
    if(isValid){
      Project.save($scope.project, function(response) {
        if (response && response.errors == undefined) {
          $location.path('/projects');
        } else {
          $scope.errors = response.errors;
        }
      });
    }
  }
}).controller('ProjectsEditController', function(projectStatuses, $location, $scope, Project, $routeParams){
  $scope.project = Project.get({id: $routeParams.id});
  $scope.statuses = projectStatuses;
  $scope.editProject = function(isValid){
    if(isValid){
      // this will not reset project data
      Project.update({id: $scope.project.id}, $scope.project, function(response) {
        if (response && response.errors == undefined) {
          $location.path('/projects');
        } else {
          $scope.errors = response.errors;
        }
      });
    }
  }
});
