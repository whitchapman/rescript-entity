open Belt

module type EntityData = {
  type t
  let id : t => string
}

module type MakeEntity = (Data: EntityData) => {

  module type Id = {
    type t
    let make : string => t
    let toString : t => string
  }
  module Id: Id

  //--------------------

  module type SetId = {
    type t
    let empty : t
    let add: (t, Id.t) => t //adds element to set; if element exists in set, value is unchanged
    let remove: (t, Id.t) => t //removes element from set; if element not in set, value is unchanged
    let toArray: t => array<Id.t>
    let size: t => int
  }
  module SetId: SetId

  //--------------------

  type t = {
    id: Id.t,
    data: Data.t
  }
  let make : Data.t => t
  type entity = t //alias needed for use within Map module

  //--------------------

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t //performs `Map.set` using `entity.id` as key
    let remove: (t, Id.t) => t
    let size: t => int
  }
  module Map: Map
}

module MakeEntity: MakeEntity = (Data: EntityData) => {

  module type Id = {
    type t
    let make : string => t
    let toString : t => string
  }

  module Id = {
    type t = string
    let make = (s: string): t => s
    let toString = (t: t): string => t
  }

  //--------------------

  module type SetId = {
    type t
    let empty : t
    let add: (t, Id.t) => t
    let remove: (t, Id.t) => t
    let toArray: t => array<Id.t>
    let size: t => int
  }

  module SetId = {
    type t = Set.String.t
    let empty: t = Set.String.empty
    let add = (t, id): t => t->Set.String.add(id)
    let remove = (t, id): t => t->Set.String.remove(id)
    let toArray = (t: t): array<Id.t> => t->Set.String.toArray
    let size = (t: t): int => t->Set.String.size
  }

  //--------------------

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

  //--------------------

  module type Map = {
    type t
    let empty: t
    let get: (t, Id.t) => option<entity>
    let add: (t, entity) => t
    let remove: (t, Id.t) => t
    let size: t => int
  }

  module Map = {
    type t = Map.String.t<entity>
    let empty: t = Map.String.empty

    let get = (t: t, id: Id.t): option<entity> => {
      t->Map.String.get(id)
    }

    //replaces if exists
    let add = (t: t, entity: entity): t => {
      t->Map.String.set(entity.id, entity)
    }

    let remove = (t: t, id: Id.t): t => {
      t->Map.String.remove(id)
    }

    let size = (t: t): int => {
      t->Map.String.size
    }
  }
}
