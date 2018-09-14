class BookController < Sinatra::Base

set :root, File.join(File.dirname(__FILE__), "..")
set :view, Proc.new { File.join(root, "views") }


configure :development do
  register Sinatra::Reloader
end

$books = [
  {
    id:0,
    title: "book zero",
    body: "body of book0"
  },
  {
    id:1,
    title: "book one",
    body: "body of book1"
  },
  {
    id:2,
    title: "book two",
    body: "body of book2"
  },
  {
    id:3,
    title: "book three",
    body: "body of book3"
  },
  {
    id:4,
    title: "book four",
    body: "body of book4"
  }
]

  get "/" do
    @books = $books
    erb :"books/index"
  end

  get "/new" do
    @book = {
      id: "",
      title: "",
      body: ""
    }
    erb :"books/new"
  end

  get "/:id" do
    id = params[:id].to_i
    @book = $books[id]
    erb :"books/book"
  end

  get "/:id/edit" do
    id = params[:id].to_i
    @book = $books[id]
    erb :"books/edit"
  end

  post "/" do
    new_book = {
      id: $books.length,
      title: params[:title],
      body: params[:body]
    }
    $books.push new_book
    redirect "/"
  end

  put "/:id" do
    id = params[:id].to_i
    book = $books[id]
    book[:title] = params[:title]
    book[:body] = params[:body]
    redirect "/"
  end

  delete "/:id" do
    id = params[:id].to_i
    $books.delete_at id
    redirect "/"
  end

end
