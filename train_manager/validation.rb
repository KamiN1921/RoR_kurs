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
      if self.instance_variable_get(var) == '' || self.instance_variable_get(var).nil?
        raise RuntimeError, "Имя #{var} не может быть пустой строкой или nil"
      end
    end

    def validate_format(var, format)
      if self.instance_variable_get(var) !~ format
        raise RuntimeError, 'Формат номера задан неверно!'
      end
    end

    def validate_type(var, type)
      if self.instance_variable_get(var).class != type
        raise RuntimeError, 'Класс объекта не соотвествует заданному'
      end
    end

    def validate_positive(var, _)
      if self.instance_variable_get(var) < 0
        raise RuntimeError, 'Должно быть больше 0'
      end
    end

  end
end
