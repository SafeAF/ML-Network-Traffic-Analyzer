class FilesController < ApplicationController
  def index
  end

  def download

    send_file("#{Rails.root}/files/clients/#{foo.id}.pdf",
      filename: "#{foo.name}.pdf",
      type: "application/pdf")
  end

  def upload
  end
end
