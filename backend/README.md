# Getaways GraphQL API

## Installation

1. Install Elixir dependencies:

    ```sh
    mix deps.get
    ```

2. Create the database, run all the migrations, and load the sample data:

    ```sh
    mix ecto.setup
    ```

3. Make sure all the tests pass:

    ```sh
    mix test
    ```

4. Fire up the Phoenix endpoint:

    ```sh
    mix phx.server
    ```

5. Visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) to explore the GraphQL API using the GraphiQL user interface.

## Example Queries, Mutations, and Subscriptions

### Get All Places

```graphql
query {
  places {
    id
    slug
    name
    location
    description
    image
    imageThumbnail
    pricePerNight
    maxGuests
    petFriendly
    pool
    wifi
  }
}
```

### Get Places Filtered by Name, Description, or Location

```graphql 
query {
  places(filter: {matching: "lake"}) {
    name
    location
    description
  }
}
```

### Get Places Filtered by Guest Count

```graphql 
query {
  places(filter: {guestCount: 6}) {
    name
    maxGuests
  }
}
```

### Get Places Filtered by Features

```graphql 
query {
  places(filter: {petFriendly: true, pool: false, wifi: true}) {
    name
    petFriendly
    pool
    wifi
  }
}
```

### Get Places Available From a Start Date to an End Date

```graphql 
query {
  places(filter: {
    availableBetween: {startDate: "2019-02-01", endDate:"2019-02-10"}
  }) {
    name
    slug
  }
}
```

### Get a Specific Place By Its Id

```graphql
query {
  place(id: 8) {
    id
    name
    slug
  }
}
```

### Get a Specific Place By Its Slug

```graphql
query {
  place(slug: "mountain-chalet") {
    id
    name
    slug
  }
}
```

### Get a Specific Place and Its Bookings

```graphql
query {
  place(slug: "sand-castle") {
    id
    bookings {
      id
      startDate
      endDate
      state
      totalPrice
    }
  }
}
```

### Get a Specific Place and Its Reviews

```graphql
query {
  place(slug: "sand-castle") {
    id
    reviews {
      id
      rating
      comment
      user {
        username
      }
    }
  }
}
```

### Sign Up

```graphql
mutation {
  signup(username: "guest", email: "guest@example.com", password: "secret") {
    token
    user {
      id
      username
      email
    }
  }
}
```

### Sign In

```graphql
mutation {
  signin(username: "mike", password: "secret") {
    token
    user {
      id
      username
      email
    }
  }
}
```

### Get the Currently Signed-in User

```graphql
query {
  me {
    username
    email
  }
}
```

### Get the Current User's Bookings

```graphql
query {
  me {
    bookings {
      id
      startDate
      endDate
      state
      totalPrice
    }
  }
}
```

### Create a Booking for the Current User and a Place

```graphql
mutation {
  createBooking(placeId: 1, startDate: "2019-03-01", endDate: "2019-03-05") {
    id
    startDate
    endDate
    state
    totalPrice
  } 
}
```

### Cancel a Booking for the Current User

```graphql
mutation {
  cancelBooking(bookingId: 4) {
    id
    state
  }
}
```

### Subscribe to Booking Changes for a Specific Place

```graphql
subscription {
  bookingChange(placeId: 1) {
    id
    startDate
    endDate
    totalPrice
    state
  }
}
```

### Create a Review by the Current User for a Specific Place

```graphql
mutation {
  createReview(placeId: 1, comment: "Love!", rating: 5) {
    id
    rating
    comment
    insertedAt
    user {
      username
    }
  } 
}
```

### Introspecting the Schema

```graphql
{
  __type(name: "Place") {
    fields {
      name
      type {
        kind
        name
      }
    }
  }
}
```

## Full Introspection Query

Credit: <https://gist.github.com/franzejr/d0a178286d0e23d3ed50999288806068>

```graphql
query IntrospectionQuery {
  __schema {
    queryType { name }
    mutationType { name }
    subscriptionType { name }
    types {
      ...FullType
    }
    directives {
      name
      description
      args {
        ...InputValue
      }
    }
  }
}

fragment FullType on __Type {
  kind
  name
  description
  fields(includeDeprecated: true) {
    name
    description
    args {
      ...InputValue
    }
    type {
      ...TypeRef
    }
    isDeprecated
    deprecationReason
  }
  inputFields {
    ...InputValue
  }
  interfaces {
    ...TypeRef
  }
  enumValues(includeDeprecated: true) {
    name
    description
    isDeprecated
    deprecationReason
  }
  possibleTypes {
    ...TypeRef
  }
}

fragment InputValue on __InputValue {
  name
  description
  type { ...TypeRef }
  defaultValue
}

fragment TypeRef on __Type {
  kind
  name
  ofType {
    kind
    name
    ofType {
      kind
      name
      ofType {
        kind
        name
      }
    }
  }
}
```

## App Generation

This app was generated using:

~~~sh
mix phx.new getaways --no-html
~~~
