# How to Seed Data

This project is using the [seed migration gem](https://github.com/harrystech/seed_migration) to seed data in a controlled manner. The gem allows us to write data migrations that look and act very similar to database migrations. This means that we can run one at a time, we can run them always in the same order and best of all we can **revert** them when necessary! Check out their blog post for more info: http://engineering.harrys.com/2014/06/09/seed-migrations.html

## How Do I Make a Seed Migration?

### Step 1: Create a new Seed Migration
```bash
bundle exec rails g seed_migration AddFoo
```
This will create a new file
```
db/data/20140407162007_add_foo.rb
```

### Step 2: Fill out the Migration
The generated migration file will look like this:
```ruby
class AddFoo < SeedMigration::Migration
  def up
  end

  def down
  end
end
```

In the `up` method, you should write whatever code you want for actually adding the data you are trying to seed.
The `down` method is used for rolling back changes, therefore, you should fill this method with whatever code is necessary to remove the data that was seeded from the `up` method.

This can be tricky, however, because you don't know *when* the rollback could happen. Additional data could have been added to the table in the time between migrating the data and deciding to roll it back. Therefore, you should be very careful with what you put in the down method.

The following is a simple example of a filled out migration:
```ruby
class AddFoo < SeedMigration::Migration
  def up
    Interest.create(name: "Foo")
  end

  def down
    Interest.find_by_name("Foo").destroy
  end
end
```

### Step 3: Run the Migration

The nice thing about this gem is that it keeps track of which migrations have been run and which ones have not. So, in general, just running
```bash
$ bundle exec rake seed:migrate
== Loading migration class at 'db/data/20140407162007_add_foo.rb'
== AddFoo: migrating ==============================================
== AddFoo: migrated (0.28s) =======================================
```
should only run the new one you have just created.

If you want to make sure that you are only running the new one you can run the following:
```bash
$ bundle exec rake seed:migrate MIGRATION=db/data/20140407162007_add_foo.rb
== Loading migration class at 'db/data/20140407162007_add_foo.rb'
== AddFoo: migrating ==============================================
== AddFoo: migrated (0.28s) =======================================
```

### How Do I Rollback a Migration?
Rollback the last migration:
```bash
$ bundle exec rake seed:rollback
== Loading migration class at 'db/data/20140407162007_add_foo.rb'
== AddFoo: reverting ==============================================
== AddFoo: reverted (0.17s) =======================================
```

Or rollback a specific migration:
```bash
$ bundle exec rake seed:rollback MIGRATION=db/data/20140407162007_add_foo.rb
== Loading migration class at 'db/data/20140407162007_add_foo.rb'
== AddFoo: reverting ==============================================
== AddFoo: reverted (0.17s) =======================================
```
