class DocumentsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  def index
    render json: Document.all
  end

  def show
    document = Document.find(params[:id])
    file = File.open(document.file.current_path, "rb")
    contents = file.read
    file.close
    document.text = contents
    puts contents
    render json: document
  end

  def create
    document = Document.new(document_params)
    document.topic = Topic.find(params[:data][:relationships][:topic][:data][:id])
    document.user = current_user
    if document.save
      render json: document, status: :created, location: document
    else
      render json: document.errors, status: :unprocessable_entity
    end 
  end

  def update
    document = Document.find(params[:id])
    file = File.open(document.file.current_path, "wb")
    file.puts params[:data][:attributes][:text]
    file.close
    if document.update(document_params)
      render json: document
    else
      render json: document.errors, status: :unprocessable_entity
    end
  end

  def destroy
    document = Document.find(params[:id])
    if document.destroy
      FileUtils.rm_rf("public/uploads/document/#{document.id}")
      render json: document
    else
      render json: document.errors, status: :unprocessable_entity
    end
  end

  def upload
    document = Document.find(params[:id])
    if params[:file]
      document.file = params[:file]
      file = File.open(document.file.current_path, "rb")
      contents = file.read
      file.close
      document.text = contents
    else
      Dir.chdir("public/uploads/tmp") {
        f = File.new("#{params[:name]}.md", "wb+")
        document.file = f
        f.close
        FileUtils.rm("#{params[:name]}.md")
        Dir.chdir("../../..")
      }
    end
    if document.save
      render json: document
    else
      render json: document.errors, status: :unprocessable_entity
    end
  end

  def css_upload
    document = Document.find(params[:id])
    document.css = params[:css]
    if document.save
      render json: { css: document.css_identifier }
    else
      render json: document.errors, status: :unprocessable_entity
    end 
  end

  def file_request
    document = Document.find(params[:id])
    file = File.open(document.file.current_path, "rb")
    contents = file.read
    file.close
    Dir.chdir("public/uploads/document/#{document.id}") {
      f = File.open("#{document.title}.#{params[:type]}", "wb+")
      case params[:type]
        when "html"
          if document.css   
            f.puts(PandocRuby.new(contents, :standalone, :no_wrap, css: "http://#{request.host_with_port}#{document.css.url}").to_html5)
          else
            f.puts(PandocRuby.new(contents, :standalone, :no_wrap).to_html5)
          end
        when "pdf"
          `pandoc #{document.file_identifier} -o #{document.title}.#{params[:type]}`
          # converter = PandocRuby.new(contents, :from => :markdown, :to => :beamer)
          # f.puts(`#{cmd}`)
          # f.puts converter.convert
        when "latex"
          f.puts(PandocRuby.new(contents, :standalone).to_latex)
        when "docx"
          f.puts(PandocRuby.new(contents, :standalone).to_docx)
        when "rtf"
          f.puts(PandocRuby.new(contents, :standalone).to_rtf)
        when "odc"
          f.puts(PandocRuby.new(contents, :standalone).to_opendocument)
      end
      f.close
    }
    render json: {
      link: "uploads/document/#{document.id}/#{document.title}.#{params[:type]}",
      name: "#{document.title}.#{params[:type]}"
    }
  end

  private

  def document_params
    params.require(:data)
          .require(:attributes).permit(:title, :link, :description, :text, :css)  
  end
end
