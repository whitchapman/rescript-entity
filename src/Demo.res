module CarData = {
  type t = {
    id: int,
    make: string,
    year: int
  }
  let id = t => t.id
}
module Car = Entity.MakeEntity(CarData)

let cars = Car.Map.empty
let car = Car.make({id: 1, make: "BMW", year: 2020})
let cars = cars->Car.Map.add(car)
let id = car.id
Js.Console.log("car -> id=" ++ id->Car.Id.toString ++ " make=" ++ car.data.make ++ " year=" ++ car.data.year->Belt.Int.toString)
