module AdUserServices
  class UserHolderRequestProcessor
    
    attr_accessor :session_id, :response_data, :action

    def initialize(session_id)
      @session_id = session_id
      @session_id = User.authenticate_new.session_id if @session_id.nil?
    end

    public

    def process(request)
      @action = request[:action]
      data = request[:data]
      self.__send__(@action, data)
    end

    private

    def select(data)
      clear
      if data.length > 0
        UserHolder.transaction do
          data.each { |entry| UserHolder.create(user_id: @session_id, objectguid: entry) }
        end
      end
      content
      "OK"
    end

    def add(data)
      data = filter_unique(data)
      if data.length > 0
        UserHolder.transaction do
          data.each { |entry| UserHolder.create(user_id: @session_id, objectguid: entry) }
        end
      end
      content
      "OK"
    end

    def delete(data)
      UserHolder.transaction do
        data.each { |entry| UserHolder.where(user_id: @session_id, objectguid: entry).destroy_all }
      end
      content
      "OK"
    end

    def clear(data=nil)
      UserHolder.where(user_id: @session_id).destroy_all
      content
      "OK"
    end

    def content(data=nil)
      @response_data = UserHolder.where(user_id: @session_id).pluck(:objectguid)
      "OK"
    end

    def filter_unique(data)
      selected = UserHolder.where(user_id: @session_id).pluck(:objectguid)
      unique_data = data.filter { |u| !selected.include?(u) }
    end

  end
end