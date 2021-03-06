json.array!(@cal_time_slots) do |time_slot|
  json.extract! time_slot, :id, :title
  json.start time_slot.start_time.strftime("%B %d, %Y %I:%M %p")
  json.end time_slot.end_time.strftime("%B %d, %Y %I:%M %p")
  json.description time_slot.dietitian.email
  json.url time_slot_url(time_slot, format: :json)
end