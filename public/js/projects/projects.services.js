angular.module('projects.services')
  .factory('Project', function($resource) {
    return $resource('/rest/projects/:id', { id: '@_id' }, {
        update: {
          method: 'PUT',
          params: {
            id: '@id'
          }
        },
        delete:{
          method: 'DELETE',
          params:{
            id: '@id'
          }
        }
      }, { stripTrailingSlashes: true }
    );
  });
  