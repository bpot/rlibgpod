require 'ffi'

module GPod
  class GList < ::FFI::Struct
    layout :data, :pointer, :next, :pointer, :prev, :pointer
  end

  class Itdb_iTunesDB < ::FFI::Struct
    layout(
           :tracks, :pointer,
           :playlists, :pointer,
           :filename, :pointer,
           :device, :pointer,
           :version, :int32,
           :id, :int64,
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
  extend FFI::Library
  ffi_lib 'gpod'

  attach_function :itdb_parse, [:string, :pointer], :pointer
  attach_function :itdb_tracks_number, [:pointer], :uint32
end

db = GPod.itdb_parse("ipod/", nil)
puts GPod.itdb_tracks_number(db)
