var should = require('should');
var user = require('../lib/users');

describe("test save and function in user", function(){
  it("Saves the user", function(){
    user.save('Grégory',function(user){
      user = {
        name : user
      }
      user.should.have.property('name', 'Grégory');
    });
  });
  it("Get the user by id", function(){
    user.get(11,function(user){
      var response = {
        info : "C'est le user",
        user : user
      }
      user.should.have.property('id', 11);
  });
});
});
