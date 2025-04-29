require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    # 正常にレスポンスを返すこと
    it 'returns a successful response' do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
