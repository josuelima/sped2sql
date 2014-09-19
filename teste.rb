class MyClass
  def self.call(env)
    env[:linha] = env[:linha] + 1
    env
  end
end

class Multiply
  def self.call(env)
    env[:linha] = env[:linha] * 10
    env
  end
end

class Pipe

  attr_reader :tasks

  def initialize
    @tasks = []
  end

  def add(task)
    @tasks << task
  end

  def <<(task)
    @tasks << task
  end

  def execute(env)
    @tasks.each do |task|
      env = task.call(env)
    end
    env
  end

end

class Conversor < Pipe

  attr_accessor :linha

  def initialize
    @linha = 1
    super
  end

  def execute
    super({linha: @linha})
  end

end

p = Conversor.new

p.add(MyClass).
  add(MyClass).
  add(MyClass).
  add(Multiply)

puts p.execute