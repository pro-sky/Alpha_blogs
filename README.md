# README
#Software required
 * Ruby - 2.3.8
 * Rails - 5.1.7
 * Postgress

# Features

- User authentication and authorization
- Create, edit, delete, and view blog posts
- Create comment on post and add like on comment and post.
- Responsive design using Bootstrap 4
- PostgreSQL database for storing blog posts and user information

# Checkout the repository by running command on terminal

```sh
$ git clone https://github.com/pro-sky/Alpha_blogs.git
```
# Run the below Tasks under project directory on terminal

##Change directory
```sh
$ cd Alpha_blogs
```

##Installing Dependencies
```sh
$ bundle install
```

#configuration settings for accessing database
 * Open database.yml file (in config folder)
 # Update following points:
  * database (Database name)
  * username (Database username)
  * password (Database password)
  * host (default value - localhost)
  * port (default value - 5432)

##add .env file to project directory and update with below environment variables.

    DATABASE_URL

##Creating database, running seed and migrating tables.

```sh
$ rake db:create
```

```sh
$ rake db:migrate
```
