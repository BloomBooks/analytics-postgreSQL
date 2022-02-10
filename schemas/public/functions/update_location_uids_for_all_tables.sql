
CREATE OR REPLACE FUNCTION public.update_location_uids_for_all_tables(
        should_update_ipv6_only boolean
    )
    RETURNS void
    LANGUAGE plpgsql VOLATILE
    AS $$
DECLARE
BEGIN
    --------
    -- NOTE: Recommend wrapping the call to this function in a transaction (see BEGIN; COMMIT; ROLLBACK;)
    -- The tranasaction will make it all or nothing. If it gets halfway through and then runs into an error, 
    -- the transaction will abort and you can rollback. (/ nothing else can happen)
    -- Estimated to take about 7-8 minutes to run.
    --------

    PERFORM public.update_location_uids('bloomapp.change_content_languages', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.change_page_layout', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.change_picture', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.change_video', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.create_bloom_pack', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.create_book', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.create_new_vernacular_collection', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.created', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.created_new_source_collection', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.delete_page', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.launch', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.print_pdf', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.register', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.upload_book_success', 'ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomapp.users', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.book_detail', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.book_or_shelf_opened', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.comprehension', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.download_book', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.open_collection', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.pages_read', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomlibrary_org.search_failed', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreader.application_installed', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreader.application_opened', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreader.book_or_shelf_opened', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreader.comprehension', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreader.pages_read', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreader.questions_correct', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreaderbeta.application_installed', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreaderbeta.application_opened', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreaderbeta.book_or_shelf_opened', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreaderbeta.comprehension', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreaderbeta.pages_read', 'context_ip', 'location_uid', should_update_ipv6_only);
    PERFORM public.update_location_uids('bloomreaderbeta.questions_correct', 'context_ip', 'location_uid', should_update_ipv6_only);
END;
$$;

ALTER FUNCTION public.update_location_uids_for_all_tables(should_update_ipv6_only boolean) OWNER TO silpgadmin;


