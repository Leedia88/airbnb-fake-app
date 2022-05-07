class Reservation < ApplicationRecord

  belongs_to :guest, class_name: "User"
  belongs_to :housing
  validates_presence_of :start_date, :end_date
  validate :start_date_must_be_before_end_date
  validate :no_overlaping_reservation

  def no_overlaping_reservation
    #Cas où la start date tombe pendant une réservation déjà existante
    #Cas où la end date tombe pendant une réservation déjà existante
    #Cas où la réservation englobe une réservation existante
    Reservation.where(housing: self.housing).each do |book|
      if(book.start_date.to_i <= self.end_date.to_i && book.end_date.to_i >= self.end_date.to_i)
          errors.add(:end_date, "is included in existing reservation for this housing")
      end
      if(book.start_date.to_i >= self.start_date.to_i && book.end_date.to_i <= self.end_date.to_i)
          errors.add(:start_date, "Another reservation already exists for this period")
      end
      if (book.start_date.to_i <= self.start_date.to_i && book.end_date.to_i >= self.start_date.to_i)
          errors.add(:start_date, "is not available, already existing reservation at this period")
      end
    end
  end

  def start_date_must_be_before_end_date
    #la start date doit être inférieur à la end date
    valid = self.start_date.to_i && self.end_date.to_i && self.start_date.to_i < self.end_date.to_i
    errors.add(:start_date, "start date must be before than end date") unless valid
  end

  def reservation_duration
    # on veut le nombre de jours de la réservation
    (self.end_date - self.start_date)/1.day.to_i
  end

end
