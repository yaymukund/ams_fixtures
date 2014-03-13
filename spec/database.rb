require 'active_record'
require 'fabrication'
require 'active_model_serializers'

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |c|
  c.before(:suite) do
    # Create our database.
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => ':memory:'
    )

    ActiveRecord::Schema.define do
      create_table :users do |t|
        t.string :name
        t.string :gender
        t.string :status
        t.string :mood

        t.timestamps
      end

      create_table :dogs do |t|
        t.string :name
        t.references :user
      end
    end

    class User < ActiveRecord::Base
      has_one :dog
    end

    class Dog < ActiveRecord::Base
      belongs_to :user
    end

    Fabricator(:user) do
      name { sequence { |i| "John Doe #{i}" }}
      gender 'other'
      status 'single'
      mood 'grumpy'
    end

    Fabricator(:dog) do
      user
      name { sequence { |i| "Fido #{i}" }}
    end

    class UserSerializer < ActiveModel::Serializer
      attributes :name, :gender, :status, :mood
    end

    class DogSerializer < ActiveModel::Serializer
      attributes :name, :user
    end
  end
end
