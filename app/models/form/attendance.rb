class Form::Attendance < Attendance
  REGISTRABLE_ATTRIBUTES = %i(arriving_at leaving_at note)
end