require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:user){User.create!(name: "user", email: "user@user.user", password: "useruser")}
  let(:wiki) {Wiki.create!(title: "my wiki", body: "my wiki text", private: false, user: user)}


  context "guest doing CRUG on wiki" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns [wiki] to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end


    describe "GET show" do
      it "returns http success" do
        get :show, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the show view" do
        get :show, {id: wiki.id}
        expect(response).to render_template :show
      end
      it "assigns [wiki] to @wiki" do
        get :show, {id: wiki.id}
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, wiki: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, id: wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = RandomData.random_sentence
        new_body = RandomData.random_paragraph

        put :update, id: wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: wiki.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "member doing CRUD on wiki" do
    before do
      sign_in user
    end
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns [wiki] to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end


    describe "GET show" do
      it "returns http success" do
        get :show, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the show view" do
        get :show, {id: wiki.id}
        expect(response).to render_template :show
      end
      it "assigns [wiki] to @wiki" do
        get :show, {id: wiki.id}
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
      it "renders the new view" do
        get :new
        expect(response).to render_template :new
      end
      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "GET #create" do
      it "increases the number of Wikis by one" do
        expect{post :create, wiki:{title:RandomData.random_sentence, body:RandomData.random_paragraph}}.to change(Wiki,:count).by(1)
      end
      it "assigns the new wiki to @wiki" do
        post :create, wiki:{title:RandomData.random_sentence, body:RandomData.random_paragraph}
        expect(assigns(:wiki)).to eq Wiki.last
      end
      it "redirects to the new wiki" do
        post :create, wiki:{title:RandomData.random_sentence, body:RandomData.random_paragraph}
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #update" do

    end

    describe "GET #destroy" do

    end
  end
end
