module LinksHelper
  def valid_url?(uri)
  	!!URI.parse(uri)
	rescue URI::InvalidURIError
  	false
	end
end