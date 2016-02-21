class ReadOnlyController < ApplicationController
 before_filter :authenticate_user!, except: [ :index, :show ]

  # have other controllers inherit from this one to control auth, so if we di dexcept: [ :index, :show]
  # then blogscontroller if inheriting this one woudl only allow logged in users to access actions
  # other than index and show. so unreg users would have read access


end