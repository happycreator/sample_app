class Form::AttendanceCollection < Form::Base
  DEFAULT_ITEM_COUNT = 31
  attr_accessor :attendances

  def initialize(attributes = {})
    super attributes
    self.attendances = DEFAULT_ITEM_COUNT.times.map { Form::Attendance.new } unless attendances.present?
  end

  def attendances_attributes=(attributes)
    self.attendances = attributes.map do |_, attendance_attributes|
      Form::Attendance.new(attendance_attributes).tap { |v| v.availability = false }
    end
  end

  def valid?
    valid_attendances = target_attendances.map(&:valid?).all?
    super && valid_attendances
  end

  def save
    return false unless valid?
    Attendance.transaction { target_attendances.each(&:save!) }
    true
  end

  def target_attendances
    self.attendances.select { |v| value_to_boolean(v.register) }
  end
end