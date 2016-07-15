require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:user){User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "useruser", role: 1)}
  let(:second_user){User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "useruser", role: 0)}
  let(:wiki) {Wiki.create!(id: 1,title: "my wiki", body: "my wiki text", private: false, user: user)}
  let(:private_wiki){Wiki.create!(id: 2, title: "private wiki", body: "private wiki text", private: true, user: user)}

  context "guest doing CRUD on wiki" do
    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns [wiki] to @wikis" do
        wiki
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
        wiki
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
      it "renders edit view" do
        get :edit, id:wiki.id
        expect(response).to render_template :edit
      end
      it "assigns wiki to be updated to @wiki" do
        get :edit, id:wiki.id
        wiki_inst = assigns(:wiki)
        expect(wiki_inst.id).to eq wiki.id
        expect(wiki_inst.title).to eq wiki.title
        expect(wiki_inst.body).to eq wiki.body
      end
    end

    describe "Put update" do
      it "returns http redirect" do
        new_title = RandomData.random_name
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki:{title:new_title, body:new_body}
        expect(response).to redirect_to(wiki)
      end
      it "updates wiki inforamtion" do
        new_title = RandomData.random_name
        new_body = RandomData.random_paragraph
        put :update, id: wiki.id, wiki:{title:new_title, body:new_body}
        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to_not eq wiki.title
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to_not eq wiki.body
        expect(updated_wiki.body).to eq new_body
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, id:wiki.id
        count = Wiki.where({id:wiki.id}).size
        expect(count).to eq 0
      end
      it "redirects to wiki index" do
        delete :destroy, id:wiki.id
        expect(response).to redirect_to(wikis_path)
      end
    end
  end
  context "premium member modifying collaborators" do
    before :each do
      sign_in user
    end
    describe "add collaborator" do
      it "adds second user as collaborator to private wiki" do
        post :add_collaborator, wiki_id:private_wiki.id, user_id:second_user.id, id: 2
        w = Wiki.find_by(id: private_wiki.id)
        expect(w.user).to eq user
        expect(w.collaborators.count).to eq 1
      end
    end
    describe "remove collaborator" do
      it "removes user as collaborator to private wiki" do
        private_wiki.collaborators  << second_user
        post :remove_collaborator,wiki_id:private_wiki.id, wiki:private_wiki, user_id:second_user.id
        w = Wiki.find_by(id:2)
        expect(w.collaborators.count).to eq 0
      end
    end
  end
end
