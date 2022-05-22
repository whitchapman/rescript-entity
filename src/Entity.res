open Belt

module type EntityData = {
  type t
  let id : t => int
}

module type MakeEntity = (Data: EntityData) => {

  module type Id = {
    type t
    let make : int => t
    let fromString : string => option<t>
    let toString : t => string
  }
  module Id: Id

  type t = {
    id: Id.t,
    data: Data.t
  }
  let make : Data.t => t
  type entity = t //alias needed for use within Map module

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t //replaces if exists
  }
  module Map: Map
}

module MakeEntity: MakeEntity = (Data: EntityData) => {

  module type Id = {
    type t
    let make : int => t
    let fromString : string => option<t>
    let toString : t => string
  }
  module Id = {
    type t = int
    let make = x => x
    let getValue = t => t
    let fromString = s => Int.fromString(s)
    let toString = t => Int.toString(t)
  }

  //NB: it would be nice if there was a way to manipulate Data.t to include Id.t so everything is top level
  type t = {
    id: Id.t,
    data: Data.t
  }
  let make = (data: Data.t): t => {
    let id = data->Data.id->Id.make
    {id, data}
  }
  type entity = t //alias needed for use within Map module

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t
  }
  module Map = {
    type t = Map.Int.t<entity>
    let empty = Map.Int.empty

    let get = (t, id) => {
      t->Map.Int.get(Id.getValue(id))
    }

    //replaces if exists
    let add = (t, entity) => {
      t->Map.Int.set(Id.getValue(entity.id), entity)
    }
  }
}
