require 'ffi'
require 'method_lister'

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
           :title, :string,
           :ipod_path, :string,
           :album, :string,
           :artist, :string,
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
  end
end

module GPod
  extend FFI::Library
  ffi_lib 'gpod'

  attach_function :itdb_parse, [:string, :pointer], :pointer
  attach_function :itdb_tracks_number, [:pointer], :uint32
end
db = GPod.itdb_parse("ipod/", nil)

itdb = GPod::Itdb_iTunesDB.new(db)
tracks = GPod::GList.new(itdb[:tracks])
track = GPod::Itdb_Track.new(tracks[:data])
puts "title: #{track[:title]}"
puts "ipod path: #{track[:ipod_path]}"
puts "album: #{track[:album]}"

#puts strptr.read_string(12)

#tracks = db[:tracks]
#ptr = GPod::Itdb_Track.new(tracks[:data])
#str = ptr[:title].read_pointer
#put str.read_string

#puts t1[:artist]
#puts GPod.itdb_tracks_number(db)
