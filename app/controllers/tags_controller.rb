class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @taggings = Tagging.scoped_by_tag_id(@tag.id).scoped_by_taggable_type('Notification').paginate :page => params[:page], :per_page => 10
  end
end
