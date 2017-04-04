# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # Test suite for GET /
  describe 'GET /' do
    # make HTTP get request before each example
    before { get '/todos' }

    it 'returns todos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /:id
  describe 'GET /:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # Test suite for POST /
  describe 'POST /' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', completed: false } }

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/todos', params: { invalid_param: 'Foobar' } }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PATCH /:id
  describe 'PATCH /:id' do
    let(:valid_attributes) { { title: 'Shopping', order: 2, completed: true } }

    context 'when the record exists' do
      before { patch "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
        expect(json['title']).to eq('Shopping')
        expect(json['order']).to eq(2)
        expect(json['completed']).to eq(true)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /:id
  describe 'DELETE /:id' do
    before { delete "/todos/#{todo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # Test suite for DELETE /
  describe 'DELETE /' do
    before { delete '/todos' }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
