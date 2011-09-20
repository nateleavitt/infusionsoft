module TicketService

  ########################  
  ###  Ticket Service  ###
  ########################

  def api_ticket_add_move_notes(ticket_list, move_notes, move_to_stage_id, notify_ids)
    # add move notes to existing tickets
    Thread.current[:api_conn].api_perform('ServiceCallService', 'addMoveNotes', ticket_list, move_notes, move_to_stage_id, notify_ids)
  end

  def api_ticket_move_stage(ticket_id, ticket_stage, move_notes, notify_ids)
    # add move notes to existing tickets
    Thread.current[:api_conn].api_perform('ServiceCallService', 'moveTicketStage', ticket_id, ticket_stage, move_notes, notify_ids)
  end
end
