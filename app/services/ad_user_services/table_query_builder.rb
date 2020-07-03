module AdUserServices
  class TableQueryBuilder
    
    def initialize(columns_and_tables_hash)
      @tables_columns_hash = columns_and_tables_hash
      database_tables = ActiveRecord::Base.connection.tables
      @tables_columns_hash.keys.each do |table| 
        raise Exception.new "Table #{table} does not exist" unless database_tables.include?(table.to_s)
        all_given_columns_exist_in_table?(table)
      end
      @localized = Hash.new
    end
    
    public

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

    def localized_hash(lang)
      if lang == :en
        @tables_columns_hash.keys.each do |table|
          headers_model = "#{ActiveSupport::Inflector.singularize(table)}_headers".classify.constantize
          @localized = find_translations_for_headers(headers_model, table)
        end
      end
      @localized
    end
    
    private

    def build_with_alias(table, column)
      col_alias = create_alias(table, column)
      @headers << col_alias
      @alias_hash.merge!( {table => {col_alias => column}} )
      "#{table}.#{column} as #{col_alias}"
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
      columns = @tables_columns_hash[table] - ActiveRecord::Base.connection.columns(table).collect {|c| c.name}
      unless columns.empty?
        raise Exception.new "Columns #{columns} are not present in table #{table}"
      end
    end
    
    def find_translations_for_headers(headers_model, fallback_table)
      found_translations = []
      @headers.each do |entry|
        translation = headers_model.find_by(name: entry)
        if translation.nil?  
          translation = headers_model.find_by(name: @alias_hash[fallback_table][entry]) unless @alias_hash[fallback_table].nil?
        end
        unless translation.nil?
          @localized.merge!({ entry => translation.name_en }) 
          found_translations << entry
        end
      end
      @headers -= found_translations
      @localized
    end

  end
end