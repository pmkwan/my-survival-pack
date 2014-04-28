require 'grape'
require 'backpack'

module Workr
  module V1
    class SurvivalPack < Grape::API
      version 'v1', :using => :path, :vendor => 'Workr'
      format :json

      resources :survival_pack do
        post do
          begin
            output_items = Services::Backpack.new(params).pick_best_items

            { best_items: output_items }
          rescue Exception => e
            error! e, 422
          end
        end
      end

    end
  end
end