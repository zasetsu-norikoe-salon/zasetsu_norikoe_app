class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :userdate do |t|
      t.string     :email,        null:false
      t.string     :password,         null:false
      t.string     :name,      null:false
      t.integer    :gender,       null:false
      t.string     :age
      t.integer    :employment_form,            null:false
      t.string     :prefecture
      t.string     :available_work_time
      t.string     :qualification
      t.string     :hobby
      t.string     :speciall_skill
      t.string     :want_talk
      t.string     :not_want_talk
      t.text       :free_area
      t.integer    :zasetsu_count,            null:false
      t.string     :facebook_url
      t.string     :twitter_url
      t.string     :github_url
      t.string     :port_url
      t.datetime   :deleted_at,            null:false
      t.datetime   :created_at,            null:false
      t.datetime   :updated_at,            null:false
    end
  end
end
