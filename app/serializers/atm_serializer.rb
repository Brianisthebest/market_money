class AtmSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :lat, :lon, :distance, :id
  set_id :id
end
