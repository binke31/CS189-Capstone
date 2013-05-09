# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130508074609) do

  create_table "maintenance_requests", :force => true do |t|
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "permissionToEnter"
    t.datetime "maintenanceRequestDate"
    t.string   "writtenRequest"
    t.string   "userFirstName"
    t.string   "userLastName"
  end

  create_table "notification_settings", :force => true do |t|
    t.integer  "userID"
    t.string   "phoneNumber"
    t.string   "textMessages"
    t.string   "emails"
    t.string   "rentOneDay"
    t.string   "rentOneWeek"
    t.string   "general"
    t.string   "maintenanceUpdates"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.datetime "sendNextRentAt"
    t.string   "rentInterval"
  end

  create_table "notifications", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rent_payments", :force => true do |t|
    t.string   "paymentAmount"
    t.integer  "routingNumber"
    t.integer  "accountNumber"
    t.datetime "paymentDate"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "accountType"
    t.string   "savePayment"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "rentDueDate"
    t.integer  "rentDueDay"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
