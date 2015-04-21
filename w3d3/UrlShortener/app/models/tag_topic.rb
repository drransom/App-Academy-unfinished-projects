class TagTopic < ActiveRecord::Base
  has_many(
    :taggings,
    class_name: 'Tagging',
    primary_key: :id,
    foreign_key: :tag_topic_id
  )

  has_many(
    :shortened_urls,
    through: :taggings,
    source: :shortened_url
  )

  def most_popular_links(n = 1)
    ShortenedUrl
      .select("shortened_urls.*")
      .joins(:taggings)
      .select("taggings.*, count(shortened_urls.id) as scount")
      .where("taggings.tag_topic_id = ?", id)
      .group("shortened_urls.id")
      .order("scount DESC")
      .limit(n)
  end
end
