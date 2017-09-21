# OrderDecorator
class OrderDecorator < Draper::Decorator
  delegate_all

  def date_Y_m_d
    created_at.strftime('%Y-%m-%d')
  end

  def status_name
    order_status.name
  end
end
