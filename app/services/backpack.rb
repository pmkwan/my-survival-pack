module Services
  class Backpack
    attr_accessor :items, :backpack_weight

    def initialize(params)
      # accepts a file as input
      file_data = params[:fileUpload][:tempfile] unless params[:fileUpload].nil?

      if !file_data.nil?
        if file_data.respond_to?(:read)
          file_contents = file_data.readlines
        elsif file_data.respond_to?(:path)
          file_contents = File.readlines(file_data.path)
        end

        @items, @backpack_weight = process_input_file(file_contents)
      else
        # accepts JSON input
        @backpack_weight = params[:max_weight].to_i unless params[:max_weight].nil?

        survival_items = params[:survival_items] unless params[:survival_items].nil?

        @items = process_survival_items(survival_items)
      end

      if items.nil? || backpack_weight.nil?
        raise "Invalid input!"
      end
    end

    def best_items
      output_items, total_output_value = run_knapsack_algorithm(items, backpack_weight)

      output_items.collect do |item|
        name, weight, value = item.split(" ")
        { name: name, weight: weight.to_i, value: value.to_i }
      end
    end


    private
    # process survival_items from JSON input
    def process_survival_items(survival_items)
      return if survival_items.nil?

      [].tap do |items|
        survival_items.each do |item|
          items << item["name"] + " " + item["weight"].to_s + " " + item["value"].to_s
        end
      end
    end

    # proces data from an input file
    def process_input_file(file_contents)
      return if file_contents.nil? || file_contents.empty?

      file_contents.each_with_index do |line, i|
        if line.include?("max weight:")
          s, max_weight_s = line.split(":")
          @backpack_weight = max_weight_s.to_i
        elsif line.split(" ").join(",") == "name,weight,value"
          @data_start_at = i
          break
        end
      end

      @items = file_contents.drop(@data_start_at + 1) unless @data_start_at.nil?

      return @items, @backpack_weight
    end

    # standard 0/1 knapsack alogorithm
    def run_knapsack_algorithm(items, knapsack_weight)
      number_of_items = items.size

      keep = [].tap { |k| (number_of_items+1).times { k << Array.new(knapsack_weight+1) } }
      matrix = [].tap { |m| (number_of_items+1).times { m << Array.new(knapsack_weight+1) } }

      matrix[0].each_with_index { |value, weight| matrix[0][weight] = 0 }

      rows_with_weight_value = items.map { |row| row.split(" ")[1..2].map(&:to_i) }

      (1..number_of_items).each do |i|
        weight, value = rows_with_weight_value[i-1]
        (0..knapsack_weight).each do |w|
          if weight <= w && (matrix[i-1][w-weight] + value > matrix[i-1][w])
            matrix[i][w] = matrix[i-1][w-weight] + value
            keep[i][w] = 1
          else
            matrix[i][w] = matrix[i-1][w]
            keep[i][w] = 0
          end
        end
      end

      output_items = []
      kw = knapsack_weight
      number_of_items.downto(1) do |i|
        if keep[i][kw] == 1
          output_items << items[i-1]
          weight, value = rows_with_weight_value[i-1]
          kw = kw - weight
        end
      end

      total_output_value = matrix[number_of_items][knapsack_weight]

      return output_items, total_output_value
    end

  end
end