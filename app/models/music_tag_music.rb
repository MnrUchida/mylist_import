# == Schema Information
#
# Table name: music_tag_musics
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  music_id     :integer
#  music_tag_id :integer
#
# Indexes
#
#  index_music_tag_musics_on_music_id      (music_id)
#  index_music_tag_musics_on_music_tag_id  (music_tag_id)
#
class MusicTagMusic < ApplicationRecord
  belongs_to :music
  belongs_to :music_tag
end
