# module ContentHelper

  class Client
    # Client is the largest of the
    attr_reader :namespace, :server_host
    def initialize(namespace, server_host)
      @namespace = namespace
      @server_host = server_host
      @containers = {}
    end


    def create_container(account, container_name)
      temp = Container.new(account, container_name)
      url = temp.container_url
      @containers[url] = temp
    end

    def locate_container(container_url)
      if @containers[container_url]
        return @containers[container_url]
      else
        p "That container is not in this client"
      end
    end

    def list_all_containers
      @containers.each{|key, value| puts "#{key} => #{value}"}
    end

    def delete_container(container_url)
      @containers[container_url]= nil
    end
  end

  class Container
    attr_reader  :container_url, :objects
    def initialize(account, container_name)
      @account = account
      @container_name = container_name
      @container_url = create_container_url
      @objects = {}
    end

    def create_container_url
      #The documentation is unclear here. Is the user the container_name?
      @container_url = "#{@namespace}/#{@account}/#{@container_name}"
    end

    def new_object(object_name)
      temp = Object.new(@container_url, object_name)
      url = temp.object_url
      @objects[url] = temp
    end

    def list_objects
      @objects.each {|key, value| puts "#{key} => #{value}"}
    end

    def delete_object(object_url)
      @objects[object_url] = nil
    end
  end

  class Object
    # This must be more completely fleshed out.  It is still unclear from the docs. How the data should be prepared and uploaded.  I have looked at
    attr_reader :object_url
    def initialize(container_url, object_name)
      @object_name = object_name
      @container_url = container_url
      @object_url = create_object_url
    end

    def create_object_url
      @object_url = "#{@container_url}/#{@object_name}"
    end
  end
# end

p test = Client.new("namespace", "IP:ADDRESS")
p "******************************************************"

p test.create_container("account", "container_name")
p "******************************************************"

p second_container = test.create_container("SECONDACCOUNT", "NEXTCONTAINER")
p "******************************************************"

p test.list_all_containers
p "******************************************************"
p first_object = second_container.new_object("object")
p second_container.list_objects
