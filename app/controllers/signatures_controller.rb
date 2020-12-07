class SignaturesController < ApplicationController
  def index
    @templates = Template.where(category: "signature")
  end
end
