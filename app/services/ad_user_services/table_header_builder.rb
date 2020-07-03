module AdUserServices
  class TableHeaderBuilder
    #In future this class will allow to customize headers of a table visible in AdUsers index view and optimize SQL used
    #to select data.
    #Additionaly it will provide an easy way to change language of headers to different localization.
    attr_accessor :headers, :alias_hash

    def initialize(columns_and_tables_hash)
      @tables_columns_hash = columns_and_tables_hash
      database_tables = ActiveRecord::Base.connection.tables
      @tables_columns_hash.keys.each do |table| 
        raise Exception.new "Table #{table} does not exist" unless database_tables.include?(table.to_s)
        all_given_columns_exist_in_table?(table)
      end
    end
    
    def selected_data
      @headers = Array.new
      @alias_hash = Hash.new
      selection = Array.new
      @tables_columns_hash.keys.each do |table|
        @tables_columns_hash[table].each do |column|
          if @headers.include?(column)
            selection.push(build_with_alias(table, column))
          else
            selection.push(build_as_is(table, column))
          end
        end
      end
      selection
    end

    def build_with_alias(table, column)
      col_alias = create_alias(table, column)
      @headers << col_alias
      @alias_hash.merge!( {table: table, column: column, alias: col_alias} )
      selection = "#{table}.#{column} as #{col_alias}"
    end

    def build_as_is(table, column)
      @headers << column
      "#{table}.#{column}"
    end

    def create_alias(table_name, column_name) 
      table_name = table_name.to_s
      column_name = column_name.to_s
      "#{table_name}_#{column_name}"
    end

    def all_given_columns_exist_in_table?(table)
      result = @tables_columns_hash[table] - ActiveRecord::Base.connection.columns(table).collect {|c| c.name}
      unless result.empty?
        raise Exception.new "Columns #{result} are not present in table #{table}"
      end
    end

    def localized_hash(lang)
      localized = Hash.new
      if lang == :en
        @tables_columns_hash.keys.each do |table|
          table = ActiveSupport::Inflector.singularize(table)
          headers_model = "#{table}_headers".classify.constantize
          @headers.each do |entry|
            translation = headers_model.find_by(name: entry)
            localized.merge!({ entry => translation.name_en }) unless translation.nil?
          end
        end
      end
      localized
    end

  end
end