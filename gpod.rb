require 'rubygems'
require 'ffi'
#require 'method_lister'

module GPod
  class GList < ::FFI::Struct
    layout(:data, :pointer,
           :next, :pointer,
           :prev, :pointer
           )
  end
end

module GPod
  class Itdb_iTunesDB < ::FFI::Struct
    layout(
           :tracks, :pointer,
           :playlists, :pointer,
           :filename, :string,
           :device, :pointer,
           :version, :uint32,
           :id, :uint64,
           :reserved_int1, :int32,
           :reserved_int2, :int32,
           :reserved1, :pointer,
           :reserved2, :pointer,
           :usertype, :uint64,
           :userdata, :pointer,
           :userdata_duplicate, :pointer,
           :userdata_destroy, :pointer
           )
  end
end

module GPod
  class Itdb_Track < ::FFI::Struct
    layout(
           :itdb, :pointer,
           :title, :pointer,
           :ipod_path, :string,
           :album, :pointer,
           :artist, :pointer,
           :genre, :string,
           :filetype, :string,
           :comment, :string,
           :category, :string,
           :composer, :string,
           :grouping, :string,
           :description, :string,
           :podcasturl, :string,
           :podcastrss, :string,
           :chapterdata, :pointer,
           :subtitle, :string,
           :tvshow, :string,
           :tvepisode, :string,
           :tvnetwork, :string,
           :albumartist, :string,
           :keywords, :string,
           :sort_artist, :string,
           :sort_title, :string,
           :sort_album, :string,
           :sort_albumartist, :string,
           :sort_composer, :string,
           :sort_tvshow, :string,
           :id, :uint32,
           :size, :int32,
           :tracklen, :int32,
           :cd_nr, :int32,
           :cds, :int32,
           :track_nr, :int32,
           :tracks, :int32,
           :bitrate, :int32,
           :samplerate, :uint16,
           :samplerate_low, :uint16,
           :year, :int32,
           :volume, :int32,
           :soundcheck, :uint32,
           :time_added, :long,
           :time_modified, :long,
           :time_played, :long,
           :bookmark_time, :uint32,
           :rating, :uint32,
           :playcount, :uint32,
           :playcount2, :uint32,
           :recent_playcount, :uint32,
           :transferred, :int,
           :BPM, :uint16,
           :app_rating, :uint8,
           :type1, :uint8,
           :type2, :uint8,
           :compilation, :uint8,
           :starttime, :uint32,
           :stoptime, :uint32,
           :checked, :uint8,
           :dbid, :uint64,
           :drm_userid, :uint32,
           :visible, :uint32,
           :filetype_marker, :uint32,
           :artwork_count, :uint16,
           :artwork_size, :uint32,
           :samplerate2, :float,
           :unk126, :uint16,
           :unk132, :uint32,
           :time_released, :long,
           :unk144, :uint16,
           :explicit_flag, :uint16,
           :unk148, :uint32,
           :unk152, :uint32,
           :skipcount, :uint32,
           :recent_skipcount, :uint32,
           :last_skipped, :uint32,
           :has_artwork, :uint8,
           :skip_when_shuffling, :uint8,
           :remember_playback_position, :uint8,
           :flag4, :uint8,
           :dbid2, :uint64,
           :lyrics_flag, :uint8,
           :movie_flag, :uint8,
           :mark_unplayed, :uint8,
           :unk179, :uint8,
           :unk180, :uint32,
           :pregap, :uint32,
           :samplecount, :uint64,
           :unk196, :uint32,
           :postgap, :uint32,
           :unk204, :uint32,
           :mediatype, :uint32,
           :season_nr, :uint32,
           :episode_nr, :uint32,
           :unk220, :uint32,
           :unk224, :uint32,
           :unk228, :uint32,
           :unk232, :uint32,
           :unk236, :uint32,
           :unk240, :uint32,
           :unk244, :uint32,
           :gapless_data, :uint32,
           :unk252, :uint32,
           :gapless_track_flag, :uint16,
           :gapless_album_flag, :uint16,
           :album_id, :uint16,
           :artwork, :pointer,
           :mhii_link, :uint32,
           :reserved_int1, :int32,
           :reserved_int2, :int32,
           :reserved_int3, :int32,
           :reserved_int4, :int32,
           :reserved_int5, :int32,
           :reserved_int6, :int32,
           :reserved1, :pointer,
           :reserved2, :pointer,
           :reserved3, :pointer,
           :reserved4, :pointer,
           :reserved5, :pointer,
           :reserved6, :pointer,
           :usertype, :uint64,
           :userdata, :pointer,
           :userdata_duplicate, :pointer,
           :userdata_destroy, :pointer
           )

    [:title, :album, :artist].each do |field|
      eval "def #{field}=(s); self[:#{field}] = FFI::MemoryPointer.from_string(s); end"
    end

    def thumbnail=(path)
      GPod.itdb_track_set_thumbnails(self, FFI::MemoryPointer.from_string(path)) 
    end
  end
end

module GPod
  class Itdb_Playlist < ::FFI::Struct
    layout(
      :itdb, :pointer,
      :name, :pointer,
      :type, :uint8,
      :flag1, :uint8,
      :flag2, :uint8,
      :flag3, :uint8,
      :num, :int,
      :members, :pointer,
      :is_spl, :int,
      :timestamp, :time_t,
      :id, :uint64,
      :sortorder, :uint32,
      :podcastflag, :uint32,
      :splpref, :pointer,
      :splrules, :pointer,
      :reserved100, :pointer,
      :reserved101, :pointer,
      :reserved_int1, :int32,
      :reserved_int2, :int32,
      :reserved1, :pointer,
      :reserved2, :pointer,
      :usertype, :uint64,
      :userdata, :pointer,
      :userdata_duplicate, :pointer,
      :userdata_destroy, :pointer
    )
  end
end

module GPod
  extend FFI::Library
  ffi_lib 'gpod'

  attach_function :itdb_parse, [:string, :pointer], :pointer
  attach_function :itdb_tracks_number, [:pointer], :uint32
  attach_function :itdb_cp_track_to_ipod, [:pointer, :pointer, :pointer], :int
  attach_function :itdb_write, [:pointer, :pointer], :int
  attach_function :itdb_playlist_mpl, [:pointer], :pointer
  attach_function :itdb_playlist_add_track, [:pointer, :pointer, :int], :void
  attach_function :itdb_track_add, [:pointer, :pointer, :int], :void
  attach_function :itdb_track_new, [], :pointer
  attach_function :itdb_track_set_thumbnails, [:pointer, :pointer], :int
end

=begin
itdb = GPod::Itdb_iTunesDB.new( GPod.itdb_parse("/mnt", nil) )
tracks_root = GPod::GList.new(itdb[:tracks])
t = tracks_root
i = 0

while t.to_ptr.null? != true do
  i += 1
  track = GPod::Itdb_Track.new(t[:data])
  puts "title: #{track[:title]}"
  puts "ipod path: #{track[:ipod_path]}"
  puts "album: #{track[:album]}"
  puts

  t = GPod::GList.new(t[:next])
end

puts "iterated over #{i} elements"
puts "itdb_tracks_number says there are #{GPod::itdb_tracks_number(itdb)} elements"
=end
