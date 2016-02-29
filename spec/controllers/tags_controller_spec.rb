# require 'spec_helper'
#
# describe Api::TagsController, type: :controller do
#   describe "index" do
#     context "on success" do
#       before(:each) do
#         ['waacking', 'watersports', 'painting'].each do |tag|
#           ActsAsTaggableOn::Tag.new(name: tag).save
#         end
#         get :index, term: "wa"
#       end
#
#       it "returns 200" do
#         expect(response.status).to eq 200
#       end
#
#       it "returns the matching tags" do
#         parsed_response = JSON(response.body)
#         expect(parsed_response).to match_array ["waacking", "watersports"]
#       end
#     end
#   end
# end
