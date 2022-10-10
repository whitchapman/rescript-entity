// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Uuid = require("uuid");
var Curry = require("rescript/lib/js/curry.js");
var Entity = require("./Entity.bs.js");

function id(t) {
  return t.id;
}

var CarData = {
  id: id
};

var Car = Entity.MakeEntity(CarData);

var cars = Car.$$Map.empty;

var id$1 = Uuid.v4();

var car = Curry._1(Car.make, {
      id: id$1,
      make: "BMW",
      year: 2020
    });

var cars$1 = Curry._2(Car.$$Map.add, cars, car);

var id$2 = car.id;

console.log("car -> id=" + Curry._1(Car.Id.toString, id$2) + " make=" + car.data.make + " year=" + String(car.data.year));

var car1 = Curry._2(Car.$$Map.get, cars$1, car.id);

console.log(Curry._1(Car.$$Map.size, cars$1));

var cars$2 = Curry._2(Car.$$Map.remove, cars$1, car.id);

console.log(Curry._1(Car.$$Map.size, cars$2));

var cars$3 = Curry._2(Car.$$Map.remove, cars$2, car.id);

console.log(Curry._1(Car.$$Map.size, cars$3));

exports.CarData = CarData;
exports.Car = Car;
exports.car = car;
exports.id = id$2;
exports.car1 = car1;
exports.cars = cars$3;
/* Car Not a pure module */
