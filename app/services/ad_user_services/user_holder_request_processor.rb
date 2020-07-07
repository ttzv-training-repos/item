module AdUserServices
  class UserHolderRequestProcessor
    
    attr_accessor :session_id

    def initialize(session_id)
      @session_id = session_id
      @session_id = next_id if @session_id.nil?
    end

    public

    def process(request)
      action = request[:action]
      data = request[:data]
      self.__send__(action, data)
    end

    def next_id
      first = UserHolder.order(user_id: :desc).first
      if first.nil? 
        next_id = 1
      else
        next_id = first.user_id + 1
      end
      next_id
    end

    private

    def select(data)
      data = filter_unique(data)
      if data.length > 0
        clear
        UserHolder.transaction do
          data.each { |entry| UserHolder.create(user_id: @session_id, objectguid: entry) }
        end
      end
    end

    def add(data)
      data = filter_unique(data)
      if data.length > 0
        UserHolder.transaction do
          data.each { |entry| UserHolder.create(user_id: @session_id, objectguid: entry) }
        end
      end
    end

    def delete(data)
      UserHolder.transaction do
        data.each { |entry| UserHolder.where(user_id: @session_id, objectguid: entry).destroy_all }
      end
    end

    def clear(data=nil)
      UserHolder.where(user_id: @session_id).destroy_all
    end

    def content(data=nil)
      UserHolder.where(user_id: @session_id)
    end

    def filter_unique(data)
      selected = UserHolder.where(user_id: @session_id).pluck(:objectguid)
      unique_data = data.filter { |u| !selected.include?(u) }
    end

  end
end