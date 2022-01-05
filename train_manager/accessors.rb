# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |name|
      # создать массив значений для каждой переменной
      var_name = "@#{name}".to_sym
      history_name = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        if instance_variable_get(history_name).nil?
          instance_variable_set(history_name, [])
        end
        instance_variable_set(var_name, value)
        instance_variable_get("#{history_name}") << value
      end
      def_name = "#{name}_history".to_sym
      define_method(def_name) { instance_variable_get(history_name) }

    end
  end

  # strong_attr_accessor c проверкой типа

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if value.is_a? type
        instance_variable_set(var_name, value)
      else
        puts 'Тип присваемого значения не совпадает с указанным'
        raise RuntimeError
      end
    end
  end
end
