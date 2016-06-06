module ContentHelper

  class Client
    attr_reader :namespace, :server_host, :containers
    def initialize(namespace, server_host)
      @namespace = namespace
      @server_host = server_host
      @containers = []
    end

    def create_container(name, url)
      # we decided that containers are instantiated with only a name, but in the client methods we have it instantiated with a url
      temp = Container.new(name, url)
      @containers << temp
      p @containers
    end

    def locate_container(container_url)
      @containers.each do |container|

      end
    end

  end

  class Container
    attr_reader :name, :url, :objects
    def initialize(name, url)
      @name = name
      @url = url
      @objects = []
      # @client_id = nil
    end

    def new_object(name, type, url)
  end
    class Object
      def initialize(name, type, url)
        @name = name
        @type = type
        @url = url
      end

end
