require 'will_paginate/array'

class LogsController < ApplicationController
  def index

    if params[:search]
      @logs = Systemlog.search(params[:search]).last(20000).paginate(:page =>
                                                                  params[:page], :per_page => 100).order(DeviceReportedTime: :desc)

    else
   # Logs.order(created_at: :desc)
   # @logs = Logs.all.paginate(:page => params[:page], :per_page => 100)
   @logs = Systemlog.last(10000).paginate(:page => params[:page], :per_page => 100)

 #   Logs.find_each(batch_size: 10000) do |logs|
 #     @batchLogs = logs.paginate(:page => params[:page], :per_page => 100)

 #   end
    @lastLogs = Systemlog.last(10)


     # goes with simple search form partial
   #  @products = Product.search(params[:search]).order(sort_column + ' ' +
   # sort_direction).paginate(:per_page => 5, :page => params[:page])


    end
  end



  def show
    @showlog = Systemlog.find(params[:id])
    @logEntryID = params[:id]
    @showlogPrev = Systemlog.find((params[:id].to_i - 1))


  end

  def search
  end
end
