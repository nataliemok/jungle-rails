class Admin::AdminController < ApplicationController
  http_basic_authenticate_with name: 'nataliemok', password: '123123'
end