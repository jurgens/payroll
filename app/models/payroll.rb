class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  PAYMENT_DAYS = [5, 20]

  def self.exists_active_period?
    exists?(['ends_at >= ?', Date.today])
  end

  def self.create_next_period
    starts_at = next_period_starts_at
    ends_at   = next_period_ends_at(starts_at)
    create(starts_at: starts_at, ends_at: ends_at)
  end

  private

  def self.next_period_starts_at
    prev_period_starts_at = maximum(:ends_at)
    return prev_period_starts_at.tomorrow if prev_period_starts_at

    [Date.today, Date.today.at_beginning_of_month.next_month].each do |date|
      PAYMENT_DAYS.each do |payment_day|
        date = date.change(day: payment_day)
        return date if Date.today <= date
      end
    end
  end

  def self.next_period_ends_at(starts_at)
    [starts_at, starts_at.at_beginning_of_month.next_month].each do |date|
      PAYMENT_DAYS.each do |payment_day|
        date = date.change(day: payment_day)
        return date.yesterday if starts_at < date
      end
    end
  end
end
