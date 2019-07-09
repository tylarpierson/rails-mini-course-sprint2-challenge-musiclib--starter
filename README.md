# Rails Mini Course - Sprint 2 Challenge - MusicLib

## Intro

The musiclib app is a partially completed API that will power client apps similar to something like Spotify. Your job is to continue adding functionality, specifically to add the concept of playlists for users.

### Data Model

Here is a breakdown of the existing data model for the application:

**`User`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| email      | string   |
| api_key    | string   |
| created_at | datetime |
| updated_at | datetime |

**`Artist`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| name       | string   |
| created_at | datetime |
| updated_at | datetime |

**`Album`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| name       | string   |
| available  | boolean  |
| artist_id  | integer  |
| created_at | datetime |
| updated_at | datetime |

**`Song`**

| attribute      | type     |
| -------------- | -------- |
| id             | integer  |
| title          | string   |
| track_number   | integer  |
| length_seconds | integer  |
| album_id       | integer  |
| created_at     | datetime |
| updated_at     | datetime |

### Resources

Here is a breakdown of the existing resource API for the application:

| verb | resource | route                             | controller#action    | note                                            |
| ---- | -------- | --------------------------------- | -------------------- | ----------------------------------------------- |
| GET  | album    | /api/v1/albums                    | api/v1/albums#index  | list all available albums                       |
| GET  | album    | /api/v1/artists/:artist_id/albums | api/v1/albums#index  | list all available albums for a specific artist |
| GET  | album    | /api/v1/albums/:id                | api/v1/albums#show   | get a specific album                            |
| GET  | artist   | /api/v1/artists                   | api/v1/artists#index | list all artists                                |
| GET  | artist   | /api/v1/artists/:id               | api/v1/artists#show  | get a specific artist                           |
| GET  | song     | /api/v1/songs                     | api/v1/songs#index   | list all songs                                  |
| GET  | song     | /api/v1/albums/:album_id/songs    | api/v1/songs#index   | list all songs for a specific album             |
| GET  | song     | /api/v1/songs/:id                 | api/v1/songs#show    | get a specific song                             |
| GET  | user     | /api/v1/users                     | api/v1/users#index   | list all users                                  |
| POST | user     | /api/v1/users                     | api/v1/users#create  | create a new user                               |
| GET  | user     | /api/v1/users/:id                 | api/v1/users#show    | get a specific user                             |

## Get Started

Clone the app and run bundle install. Then, create, migrate, and seed the database.

### Run rails server and test endpoints

Start up the rails server and test out some of the endpoints:

- list albums
- list an artist's albums
- get an album
- list artists
- get an artist
- list songs
- list an album's songs
- get a song

## Step One - Add Playlist Routes and Controller

### Playlist Routes

The client dev team has requested the following routes be made available for playlists and playlist songs. Add these routes to the musiclib application.

| verb | resource | route                               | controller#action      | note                                   |
| ---- | -------- | ----------------------------------- | ---------------------- | -------------------------------------- |
| GET  | playlist | /api/v1/playlists/:id               | api/v1/playlists#show  | get a specific playlist                |
| GET  | playlist | /api/v1/user/:user_id/playlists     | api/v1/playlists#index | list all playlists for a specific user |
| POST | playlist | /api/v1/user/:user_id/playlists     | api/v1/playlist#create | create a playlist for a specific user  |
| GET  | song     | /api/v1/playlist/:playlist_id/songs | api/v1/songs#index     | list all songs                         |
| POST | song     | /api/v1/playlist/:playlist_id/songs | api/v1/songs#create    | add a song to a playlist               |

1. Add the playlist route to show a specific playlist.
2. Nested within the user resource, add the playlist routes to list and create playlists.
3. Nested within the playlist resource, add the song routes to list and create songs.
4. Limit routes to only the ones expected by the client app team.

### Playlist Controller

Create playlist controller and implement the `index`, `create` and `show` actions to respond to the routes you created.

1. `index` should only work if nested under user.
2. `show` should only work without nesting.
3. `create` should only work if nested under a user.

## Step Two - Add Playlist and PlaylistSong Models

**`Playlist`**

| attribute  | type     |
| ---------- | -------- |
| id         | integer  |
| name       | string   |
| user_id    | integer  |
| created_at | datetime |
| updated_at | datetime |

**`PlaylistSong`**

| attribute   | type     |
| ----------- | -------- |
| id          | integer  |
| playlist_id | integer  |
| song_id     | integer  |
| created_at  | datetime |
| updated_at  | datetime |

### Playlist Migration and Model

We need to add a playlist model to the app so that users can create playlists and add songs to them.

1. Add a Playlist ActiveRecord model to the app.
2. Create and run a migration to set the attributes of the playlist model in the database to match the table above.
3. Add a validation to the model that ensures playlists always have names.

### PlaylistSong Migration and Model

We need a way to associate songs and playlists but we can't do it directly because songs can belong to many playlists and playlists can have many songs. So we'll use an intermediary model to represent the concept of a 'playlist song' to capture the relationship and store it in the database.

1. Add a PlaylistSong ActiveRecord model to the app
2. Create and run a migration to set the attributes of the playlist model in the database to match the table above

### Playlist Associations

Now, we need to set up the various active record associations in the model files to let rails now how our playlist and playlist songs related to themselves and other models.

1. Add an association to user represting that it can have many associated playlists
2. Add an association to playlist represting that it can have many associated playlist_songs
3. Add an association to playlist represting that it can have many songs via the playlist_songs association
4. Add associations to playlist_song represting that a playlist_song belongs to both a playlist and a song
5. Add associations to song represting that they can have many playlist_songs and have_many playlists via playlist_songs

## Step Three - Refactor and Improve Implementation

### Move album length_seconds to model

The `length_seconds` value in the Albums controller is calculated directly in the controller and is unavailable to the rest of the application. Writing code like this inside the controller makes it impossible to reuse and is generally considered a bad practice. Since it works based on an instance of a model, let's convert the functionality to an instance method on the Album model.

1. Add a `length_seconds` method to the model and convert the call in the controller.

The starting code:

```ruby
album.songs.reduce(0) { |length, song| length + song.length_seconds }
```

The ending code:

```ruby
album.length_seconds
```

The method should total up all of the songs' `length_seconds` on an album.

### Extract song sorting into a service object

Like the `length_seconds` value, the sorting of songs is done in the song controller. This behavior is not reusable by the rest of the system.  Because sorting is done against the list of songs, and not an individual song, it doesn't make sense to move into the model. Let's extract a service object called `SongSorter`.  It should be placed in the `app/services` directory and should be initialized with two arguments: 1) *the list of songs* and 2) *the sort value*. It should have one method named `sort` which returns the sorted songs.

1. Create `SongSorter` in `app/services`.
2. Instantiate and call `sort` on `SongSorter` in the SongsController instead of the current conditional block.
3. The sorting should work regardless of whether you are listing by album, playlist, or all songs.

### Convert Query to Scope and Improve Performance

The album#index controller action has two queries that order by the album name and searches for only albums that are available. This common query should be converted into a scope on album named `available` that lists only available albums ordered by name.

1. Convert album query to scope named `available`.
2. Use `available` scope instead of the `where` and `order` queries for both albums and artist's albums.

The query also results in an n+1 query because each album's songs are loaded after querying for the list of albums. Prevent this n+1 query in the controller by including the songs in the query.

1. Solve inefficient n+1 query by including songs


## Step Four - Write Specs for Album

### Write model specs for Album

The `spec/models/album_spec.rb` file has 5 tests that need to be written.

1. Test that an album can be valid when properly set up
2. Test that an album is invalid without a name
3. Test that an album has exactly the expected attributes
4. Test that the available scope returns expected results from the database
5. Test that the length_seconds method returns expected length

### Write request spec for showing an album

The `spec/requests/api/v1/albums/get_album_spec.rb` needs to be completed by testing that the expected album is successfully returned from the endpoint.

### Uncomment the routes spec and run the full spec suite

Uncomment the file located `spec/routing/api/v1/api_routes_spec.rb` and run the full spec suite. This file tests the routes that are defined in `config/routes.rb` and ensures they go to the appropriate controller. If all of the routes for playlist and songs were properly added, this spec should pass.
