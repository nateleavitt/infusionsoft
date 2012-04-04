module Infusionsoft
  class Client
    module Ticket
      # add move notes to existing tickets
      def ticket_add_move_notes(ticket_list, move_notes, 
                                move_to_stage_id, notify_ids)
        response = get('ServiceCallService.addMoveNotes', ticket_list, 
                       move_notes, move_to_stage_id, notify_ids)
      end

      # add move notes to existing tickets
      def ticket_move_stage(ticket_id, ticket_stage, move_notes, notify_ids)
        response = get('ServiceCallService.moveTicketStage', 
                       ticket_id, ticket_stage, move_notes, notify_ids)
      end
    end
  end
end
