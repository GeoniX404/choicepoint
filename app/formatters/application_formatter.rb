class ApplicationFormatter
  def initialize(helper_proxy)
    @helper_proxy = helper_proxy
  end

  private

  def h
    @helper_proxy
  end
end
