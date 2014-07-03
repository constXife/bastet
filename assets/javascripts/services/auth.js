'use strict';

angular.module('elf')
    .factory('Auth', function($http, localStorageService){

        var accessLevels = routingConfig.accessLevels
            , userRoles = routingConfig.userRoles
            , currentUser = localStorageService.get('user') || { username: '', role: userRoles.public, token: '' };

        function changeUser(user) {
            angular.extend(currentUser, user);
        }

        return {
            authorize: function(accessLevel, role) {
                if(role === undefined) {
                    role = currentUser.role;
                }

                return accessLevel.bitMask & role.bitMask;
            },
            isLoggedIn: function(user) {
                if(user === undefined) {
                    user = currentUser;
                }
                return user.role.title === userRoles.user.title || user.role.title === userRoles.admin.title;
            },
            login: function(user, success, error) {
                $http.post('/api/v1/token.json', {user: user}).success(function(data){
                    var user = data['user'];
                    localStorageService.set('user', user);
                    changeUser(user);
                    success(user);
                }).error(error);
            },
            logout: function(success, error) {
                $http.delete('/api/v1/token.json').success(function(){
                    localStorageService.remove('user');
                    success();
                }).error(error);
            },
            accessLevels: accessLevels,
            userRoles: userRoles,
            user: currentUser
        };
    });