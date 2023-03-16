
class InvoiceLists::VereinMembershipFeeRecipientFinder
  def self.find_recipient(verein_group)
  end

  def self.find_verein(recipient_id)
    # TODO Add Rechnungskontakt

    recipient_role = Group::VereinVorstand::Kassier.find_by(person_id: recipient_id) ||
      Group::VereinVorstand::Praesident.find_by(person_id: recipient_id) ||
      Group::Verein::Admin.find_by(person_id: recipient_id)

    recipient_role.group.layer_group
  end
end
