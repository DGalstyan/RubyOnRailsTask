Timezone::Lookup.config(:google) do |c|
  c.api_key = ENV['GMAP_API_KEY']
end
