require 'rails_helper'

RSpec.describe Todo, type: :request do

  let!(:todos) { create_list(:todo, 10) }

  describe 'GET /todos' do

    before { get '/todos' }

    it { expect(json).not_to be_empty }
    it { expect(json.size).to eq(10) }

    it { expect(response).to have_http_status(200) }

  end

  describe 'POST /create' do

    context 'with valid attributes' do

      before { post '/todos', params: { todo: attributes_for(:todo) } }

      it { expect(response).to have_http_status(201) }

    end

    context 'with invalid attributes' do

      before { post '/todos', params: { todo: attributes_for(:todo, :invalid) } }

      it { expect(response).to have_http_status(422) }

      it { expect(response.body).to match(/Validation failed: Title can't be blank/) }

    end

  end

  describe 'GET /show/:id' do

    before { get "/todos/#{todos.first.id}" }

    it { expect(response).to have_http_status(200) }

  end

  describe 'PUT /todos/:id' do

    context 'with valid attributes' do
      before { put "/todos/#{todos.first.id}", params: { todo: attributes_for(:todo) } }

      it { expect(response).to have_http_status(204) }
    end

    context 'with invalid attributes' do
      before { put "/todos/#{todos.first.id}", params: { todo: attributes_for(:todo, :invalid) } }

      it { expect(response.body).to match(/Validation failed: Title can't be blank/) }
    end

  end

  describe 'DELETE /todos/:id' do

    context 'when id is present' do
      before { delete "/todos/#{todos.first.id}" }

      it { expect(response).to have_http_status(204) }
    end

    context 'when id is not present' do
      before { delete "/todos/0" }

      it { expect(response).to have_http_status(404) }
    end

  end

end
