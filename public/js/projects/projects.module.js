angular.module('projects',[
  'projects.services',
  'projects.controllers'
]).value('projectStatuses',[
  { name: 'ToDo', value: 'todo'},
  { name: 'In Progress', value: 'progress'},
  { name: 'Failed', value: 'failed'},
  { name: 'Done', value: 'done'}
]);


angular.module('projects.controllers',[]);
angular.module('projects.services',['ngResource']);