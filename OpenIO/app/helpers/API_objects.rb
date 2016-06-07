# This is an early draft of a potential Ruby API to connect with the OpenIO storage platform. As it is, it still does not successfully interface with OpenIO, rather it is an early version of what the data structure may look like if implemented in Ruby. Each class and method has comments to ensure the work can be continued Open Source.

# The documents primarily referenced for this are
# -- https://github.com/open-io/oio-sds/wiki/Write-your-own-client,
# -- https://github.com/open-io/oio-sds/wiki/Write-your-own-client#prepare
# -- https://github.com/open-io/oio-sds/wiki/OpenIO-Object-Names
# -- https://github.com/open-io/oio-api-java

# There were a few conflicts between these docs, which lead to some confusion. In those cases, Object oriented programming and DRY standards were maintained as closely as possible.



class Client
  # Client is the largest of the russian nesting-doll naming conventions.  It holds the namespace (in the docs this is often "OPENIO"), and the server host  (a proxyd service url eg. "http://127.0.0.1:6002").
  attr_reader :namespace, :server_host
  def initialize(namespace, server_host)
    @namespace = namespace
    @server_host = server_host
    @containers = {}
  end


  def create_container(account, container_name)
    #Creates container, and adds the container to its client's @containers hash.
    temp = Container.new(account, container_name)
    url = temp.container_url
    @containers[url] = temp
  end

  def locate_container(container_url)
    #finds a container from the @containers hash
    if @containers[container_url]
      return @containers[container_url]
    else
      raise "That container is not in this client"
    end
  end

  def list_all_containers
    #Lists each key value pair from the @containers hash.
    @containers.each{|key, value| puts "#{key} => #{value}"}
  end

  def delete_container(container_url)
    #finds and deletes a container from the @containers hash.
    if @containers[container_url]
      @containers[container_url] = nil
    else
      raise "that container is not in this client"
  end
end

class Container
  #A container is the second level, and middle of this naming convention.  It inherits the namespace and server host from its client.  It has an @objects hash which does exactly the same thing as the @containers hash in the Client.
  attr_reader  :container_url, :objects
  def initialize(account, container_name)
    @account = account
    @container_name = container_name
    @container_url = create_container_url
    @objects = {}
  end

  def create_container_url
    #!!This is somewhere the documentation needs to be fixed!! The API docs suggest this part is called the container name (https://github.com/open-io/oio-api-java), where the naming docs say this is called the User (https://github.com/open-io/oio-sds/wiki/OpenIO-Object-Names) Is this referencing something else? If so what?
    @container_url = "#{@namespace}/#{@account}/#{@container_name}"
  end

  def new_object(object_name)
    #creates a new object and puts it in its container's @objects hash. The key is it's unique object url.
    temp = Object.new(@container_url, object_name)
    url = temp.object_url
    @objects[url] = temp
  end

  def list_objects
    #Lists all objects in the client's @objects hash
    @objects.each {|key, value| puts "#{key} => #{value}"}
  end

  def delete_object(object_url)
    #deletes an object from the @objects hash
    if @objects[object_url]
      @objects[object_url] = nil
    else
      raise "that object is not in this container"
    end
  end
end

class Object
  # This must be more completely fleshed out.  It is still unclear from the docs. How the data should be prepared and uploaded. The data preparation docs are still not clear.
  attr_reader :object_url
  def initialize(container_url, object_name)
    @object_name = object_name
    @container_url = container_url
    @object_url = create_object_url
  end

  def create_object_url
    #Creates the objects url by passing in a specified container's url and adding the object_name to end of the string.
    @object_url = "#{@container_url}/#{@object_name}"
  end
end


