# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(var_name, validation_type, params = nil)
      @validations ||= []
      @validations << { var_name: var_name, validation_type: validation_type, params: params }
    end
  end

  module InstanceMethods
    def validate!
      arr = self.class.instance_variable_get(:@validations)
      arr.each do |validation|
        var = validation[:var_name] # (берем из хэша имя переменной)
        send "validate_#{validation[:validation_type]}", validation[:var_name], validation[:params] # параметры из хэша
      end
    end

    def valid?
      validate!
    rescue RuntimeError => e
      puts e.message
      false
      true
    end

    def validate_presence(var, _)
      if var == '' || var.nil?
        raise RuntimeError, "Имя #{var} не может быть пустой строкой или nil"
      end
    end

    def validate_format(var, format)
      if var !~ format
        raise RuntimeError, 'Формат номера задан неверно!'
      end
    end

    def validate_type(_var, type)
      if self.class != type
        raise RuntimeError, 'Классы объектов не совпадают'
      end
    end
  end
end
