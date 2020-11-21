module NameCompany
  attr_accessor :name_company
  @name_company
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end
  end

  module InstanceMethods

  	@instances ||= 0

    private

    def register_instance
      @instances =+1
    end
  end
end
