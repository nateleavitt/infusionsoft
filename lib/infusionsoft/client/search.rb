module Infusionsoft
  class Client
    # The SearchService allows you to retrieve the results of saved searches and reports that 
    # have been saved within Infusionsoft. Saved searches/reports are tied to the User that 
    # created them. This service also allows you to utilize the quick search function found in 
    # the upper right hand corner of your Infusionsoft application.

    # @note In order to retrieve the id number for saved searches you will need to utilize 
    # the data_query method and query the table called SavedFilter based on the user_id 
    # you are looking for the saved search Id for. Also note that UserId field on the 
    # SavedFilter table can contain multiple userId’s separated by a comma, so if you are 
    # querying for a report created by userId 6, I recommend appending the wildcard to the 
    # end of the userId. Something like $query = array( ‘UserId’ => ’6%’ );
    module Search
      # Gets all possible fields/columns available for return on a saved search/report.
      #
      # @param [Integer] saved_search_id
      # @param [Integer] user_id the user id who the saved search is assigned to
      # @return [Hash]
      def search_get_all_report_columns(saved_search_id, user_id)
        response = get('SearchService.getAllReportColumns', saved_search_id, user_id)
      end

      # Runs a saved search/report and returns all possible fields.
      #
      # @param [Integer] saved_search_id
      # @param [Integer] user_id the user id who the saved search is assigned to
      # @param [Integer] page_number
      # @return [Hash]
      def search_get_saved_search_results(saved_search_id, user_id, page_number)
        response = get('SearchService.getSavedSearchResultsAllFields', saved_search_id,
                       user_id, page_number)
      end

      # This is used to find what possible quick searches the given user has access to.
      #
      # @param [Integer] user_id
      # @return [Array] 
      def search_get_available_quick_searches(user_id)
        response = get('SearchService.getAvailableQuickSearches', user_id)
      end

      # This allows you to run a quick search via the API. The quick search is the 
      # search bar in the upper right hand corner of the Infusionsoft application
      #
      # @param [String] search_type the type of search (Person, Order, Opportunity, Company, Task,
      #   Subscription, or Affiliate)
      # @param [Integer] user_id
      # @param [String] search_data
      # @param [Integer] page
      # @param [Integer] limit max is 1000
      # @return [Array<Hash>]
      def search_quick_search(search_type, user_id, search_data, page, limit)
        response = get('SearchService.quickSearch', search_type, user_id, search_data, page, limit)
      end

      # Retrieves the quick search type that the given users has set as their default.
      #
      # @param [Integer] user_id
      # @return [String] the quick search type that the given user selected as their default
      def search_get_default_search_type(user_id)
        response = get('SearchService.getDefaultQuickSearch', user_id)
      end
    end
  end
end
