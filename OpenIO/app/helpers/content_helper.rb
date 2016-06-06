module ContentHelper

  class Client
    attr_reader :namespace, :server_host, :containers, :list_all_objects
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
        if container.url == container_url
          return container
        else
          p "That container is not in this client"
        end
      end
    end

    def create_object(container_url, object_name, object_type, object_url)
      target = self.locate_container(container_url)
      target.new_object(object_name, object_type, object_url)
    end

    def list_all_objects
      @list_all_objects = []
      #This is not an efficient way to do this On^2, it can be done better through a sql database, but barring that, this will work.
      @containers.each do |container|
        container.objects.each do |object|
          @list_all_objects << object
        end
        return @list_all_objects
      end
    end

    def get_object_info(object_url)
       @containers.each do |container|
        container.objects.each do |object|
          if object.url == object_url
            return object
          else
            p "That object is not in this client"
          end
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
      temp = Object.new(name, type, url)
      @objects << temp
    end
  end
    class Object
      def initialize(name, type, url)
        @name = name
        @type = type
        @url = url
      end

end
