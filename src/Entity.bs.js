// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Curry = require("rescript/lib/js/curry.js");
var Belt_MapString = require("rescript/lib/js/belt_MapString.js");
var Belt_SetString = require("rescript/lib/js/belt_SetString.js");

function MakeEntity(Model) {
  var make = function (s) {
    return s;
  };
  var toString = function (t) {
    return t;
  };
  var add = Belt_SetString.add;
  var remove = Belt_SetString.remove;
  var toArray = Belt_SetString.toArray;
  var size = Belt_SetString.size;
  var $$Set = {
    empty: undefined,
    add: add,
    remove: remove,
    toArray: toArray,
    size: size
  };
  var Id = {
    make: make,
    toString: toString,
    $$Set: $$Set
  };
  var make$1 = function (model) {
    var id = Curry._1(Model.id, model);
    return {
            id: id,
            model: model
          };
  };
  var get = Belt_MapString.get;
  var add$1 = function (t, entity) {
    return Belt_MapString.set(t, entity.id, entity);
  };
  var remove$1 = Belt_MapString.remove;
  var size$1 = Belt_MapString.size;
  var has = Belt_MapString.has;
  var $$Map = {
    empty: undefined,
    get: get,
    add: add$1,
    remove: remove$1,
    size: size$1,
    has: has
  };
  return {
          Id: Id,
          make: make$1,
          $$Map: $$Map
        };
}

exports.MakeEntity = MakeEntity;
/* No side effect */
