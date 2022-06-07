open Belt

module CarData = {
  type t = {
    id: string,
    make: string,
    year: int
  }
  let id = t => t.id
}
module Car = Entity.MakeEntity(CarData)

let cars = Car.Map.empty
let id = Uuid.v4() //string
let car = Car.make({id, make: "BMW", year: 2020})
let cars = cars->Car.Map.add(car)
let id = car.id //Car.Id.t
Js.Console.log("car -> id=" ++ id->Car.Id.toString ++ " make=" ++ car.data.make ++ " year=" ++ car.data.year->Int.toString)
let car1 = cars->Car.Map.get(car.id)
Js.Console.log(cars->Car.Map.size)
//let car2 = cars->Car.Map.get("random") //error
let cars = cars->Car.Map.remove(car.id)
Js.Console.log(cars->Car.Map.size)
let cars = cars->Car.Map.remove(car.id) //removing twice is not an error
Js.Console.log(cars->Car.Map.size)
