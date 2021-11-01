# AppCentral Status 

A status page for a fake website called AppCentral

## Features

- Index page with most recent status followed by a list with the previous five.

- Form to update status prefilled with latest status values

- Styled with Bootstrap CSS

## Running tests

- Run migrations

```bash
bundle exec rails db:migrate RAILS_ENV=test
`````

- Running tests

```bash
bundle exec rails t
`````

## Starting server

- Run migrations

```bash
bundle exec rails db:migrate
```

- Start Rails server

```bash
bundle exec rails s
```

## Next steps

- Add authentication and authorization for the editing page
- Use FactoryGirl, or other gem, instead of fixtures for better control of test objects creation
	- For example, in some tests I clear all status messages to test how the page handles that. It would be better to not create the objects in the first place.
