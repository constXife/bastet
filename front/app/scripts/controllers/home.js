'use strict';

/**
 * @ngdoc function
 * @name frontApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the frontApp
 */
angular.module('frontApp')
  .controller('HomeCtrl', function ($scope, $rootScope, $i18next) {
    $scope.setLang = function(lang) {
      $i18next.options.postProcess = '';
      $i18next.options.lng = lang;
    };
  });
