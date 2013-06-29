class LinkPost < ActiveRecord::Base
  attr_accessible :sub_id, :link_id
  
  belongs_to :sub
  belongs_to :link

  after_destroy :cleanup

  private
  def cleanup
    return unless link_id

    # cleanup a Link when no more LinkPosts
    unless LinkPost.exists?(:link_id => link_id)
      link.destroy
    end
  end
end
