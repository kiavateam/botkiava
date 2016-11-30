--Begin msg_checks.lua
--Begin pre_process function
local function pre_process(msg)
-- Begin 'RondoMsgChecks' text checks by @rondoozle
if is_chat_msg(msg) or is_super_group(msg) then
	if msg and not is_momod(msg) and not is_whitelisted(msg.from.id) then --if regular user
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("‮", "") -- get rid of rtl in names
	local name_log = print_name:gsub("_", " ") -- name for log
	local to_chat = msg.to.type == 'chat'
	if data[tostring(msg.to.id)] and data[tostring(msg.to.id)]['settings'] then
		settings = data[tostring(msg.to.id)]['settings']
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = 'no'
	end
      if settings.mute_forward then
		mute_forward = settings.mute_forward
	else
		mute_forward = 'no'
	end
      if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = 'no'
	end
       if settings.lock_badword then
		lock_badword = settings.lock_badword
	else
		lock_badword = 'no'
	end
	if settings.lock_rtl then
		lock_rtl = settings.lock_rtl
	else
		lock_rtl = 'no'
	end
    if settings.lock_operator then
		lock_operator = settings.lock_operator
	else
		lock_operator = 'no'
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = 'no'
	end
     if settings.lock_username then
		lock_username = settings.lock_username
	else
		lock_username = 'no'
	end
	if settings.lock_member then
		lock_member = settings.lock_member
	else
		lock_member = 'no'
	end
	if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = 'no'
	end
	if settings.lock_sticker then
		lock_sticker = settings.lock_sticker
	else
		lock_sticker = 'no'
	end
	if settings.lock_contact then
		lock_contact = settings.lock_contact
	else
		lock_contact = 'no'
	end
	if settings.strict then
		strict = settings.strict
	else
		strict = 'no'
	end
		if msg and not msg.service and is_muted(msg.to.id, 'All: yes') or is_muted_user(msg.to.id, msg.from.id) and not msg.service then
			delete_msg(msg.id, ok_cb, false)
			if to_chat then
			--	kick_user(msg.from.id, msg.to.id)
			end
		end
		if msg.text then -- msg.text checks
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			if lock_spam == "yes" and string.len(msg.text) > 2049 or ctrl_chars > 40 or real_digits > 2000 then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					delete_msg(msg.id, ok_cb, false)
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.text:match("[Hh][Tt][Tt][Pp][Ss]") or msg.text:match("[Hh][Tt][Tt][Pp]")
			local is_bot = msg.text:match("?[Ss][Tt][Aa][Rr][Tt]=")
			if is_link_msg and lock_link == "yes" and not is_bot then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
             local is_badword_msg = msg.text:match("[Kk][Ii][Rr]") or msg.text:match("[Kk][Oo][Ss]") or msg.text:match("[Kk][Oo][Ss][Dd][Ee]") or msg.text:match("[Kk][Oo][Oo][Nn][Ii]") or msg.text:match("[Jj][Ee][Nn][Dd][Ee]") or msg.text:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.text:match("[Kk][Oo][Oo][Nn]") or msg.text:match("کیر") or msg.text:match("کسکش") or msg.text:match("کونی") or msg.text:match("جنده") or msg.text:match("حشری") or msg.text:match("عوضی") or msg.text:match("اشغال") or msg.text:match("کس") or msg.text:match("دودول") or msg.text:match("حروم زاده") or msg.text:match("کسکش") or msg.text:match("سیکتیر") or msg.text:match("سیک") or msg.text:match("ننه") or msg.text:match("فاک") or msg.text:match("خفه") or msg.text:match("[Ff][Uu][Cc][Kk]") or msg.text:match("[Nn][Aa][Nn][Ee]") or msg.text:match("خوار") or msg.text:match("کسه") or msg.text:match("[Kk][Hh][Aa][Rr][Kk][Oo][Ss][Ee]") or msg.text:match("لاشی")
   if is_badword_msg and lock_badword == "yes" then
    delete_msg(msg.id, ok_cb, false)
    if strict == "yes" or to_chat then
     kick_user(msg.from.id, msg.to.id)
    end
   end
              local is_username_msg = msg.text:match("@")
       if is_username_msg and lock_username == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
          local is_operator_msg = msg.text:match("شارژ") or msg.text:match("[Ss][Hh][Aa][Jj]") or msg.text:match("بسته") or msg.text:match("اینترنت") or msg.text:match("[Ii][Rr][Aa][Cc][Ee][Ll][Ll") or msg.text:match("رایتل") or msg.text:match("همراه اول") or msg.text:match("ایرانسل") 
			if is_operator_msg and lock_operator == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
            local is_fwd_msg = 'mate:'..msg.to.id
             if is_fwd_msg and mute_forward == "yes" and msg.fwd_from and not is_momod(msg)  then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
            local is_tag_msg = msg.text:match("#")
       if is_tag_msg and lock_tag == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_squig_msg = msg.text:match("[\216-\219][\128-\191]")
			if is_squig_msg and lock_arabic == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local print_name = msg.from.print_name
			local is_rtl = print_name:match("‮") or msg.text:match("‮")
			if is_rtl and lock_rtl == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, "Text: yes") and msg.text and not msg.media and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
		if msg.media then -- msg.media checks
			if msg.media.title then
				local is_link_title = msg.media.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.title:match("[Hh][Tt][Tt][Pp][Ss]") or msg.media.title:match("[Hh][Tt][Tt][Pp]")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
                 local is_badword_title = msg.media.title:match("[Kk][Ii][Rr]") or msg.media.title:match("[Kk][Oo][Ss]") or msg.media.title:match("[Kk][Oo][Ss][Dd][Ee]") or msg.media.title:match("[Kk][Oo][Oo][Nn][Ii]") or msg.media.title:match("[Jj][Ee][Nn][Dd][Ee]") or msg.media.title:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.media.title:match("[Kk][Oo][Oo][Nn]") or msg.media.title:match("کیر") or msg.media.title:match("کسکش") or msg.media.title:match("کونی") or msg.media.title:match("جنده") or msg.media.title:match("حشری") or msg.media.title:match("عوضی") or msg.media.title:match("اشغال") or msg.media.title:match("کس") or msg.media.title:match("دودول") or msg.media.title:match("حروم زاده") or msg.media.title:match("کسکش") or msg.media.title:match("سیکتیر") or msg.media.title:match("سیک") or msg.media.title:match("ننه") or msg.media.title:match("فاک") or msg.media.title:match("خفه") or msg.media.title:match("[Ff][Uu][Cc][Kk]") or msg.media.title:match("[Nn][Aa][Nn][Ee]") or msg.media.title:match("خوار") or msg.media.title:match("کسه") or msg.media.title:match("[Kk][Hh][Aa][Rr][Kk][Oo][Ss][Ee]") or msg.media.title:match("لاشی") 
   if is_badword_title and lock_badword == "yes" then
    delete_msg(msg.id, ok_cb, false)
    if strict == "yes" or to_chat then
     kick_user(msg.from.id, msg.to.id)
    end
   end
                 local is_username_title = msg.media.title:match("@")
       if is_username_title and lock_username == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
          local is_operator_title = msg.media.title:match("شارژ") or msg.media.title:match("[Ss][Hh][Aa][Jj]") or msg.media.title:match("بسته") or msg.media.title:match("اینترنت") or msg.media.title:match("[Ii][Rr][Aa][Cc][Ee][Ll][Ll") or msg.media.title:match("رایتل") or msg.media.title:match("همراه اول") or msg.media.title:match("ایرانسل") 
			if is_operator_title and lock_operator == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
           local is_fwd_title = 'mate:'..msg.to.id
             if is_fwd_title and mute_forward == "yes" and msg.fwd_from and not is_momod(msg)  then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
             local is_tag_title = msg.media.title:match("#")
       if is_tag_title and lock_tag == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_squig_title = msg.media.title:match("[\216-\219][\128-\191]")
				if is_squig_title and lock_arabic == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.description then
				local is_link_desc = msg.media.description:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.description:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.description:match("[Hh][Tt][Tt][Pp][Ss]") or msg.media.description:match("[Hh][Tt][Tt][Pp]")
				if is_link_desc and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
                      local is_badword_desc = msg.media.description:match("[Kk][Ii][Rr]") or msg.media.description:match("[Kk][Oo][Ss]") or msg.media.description:match("[Kk][Oo][Ss][Dd][Ee]") or msg.media.description:match("[Kk][Oo][Oo][Nn][Ii]") or msg.media.description:match("[Jj][Ee][Nn][Dd][Ee]") or msg.media.description:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.media.description:match("[Kk][Oo][Oo][Nn]") or msg.media.description:match("کیر") or msg.media.description:match("کسکش") or msg.media.description:match("کونی") or msg.media.description:match("جنده") or msg.media.description:match("حشری") or msg.media.description:match("عوضی") or msg.media.description:match("اشغال") or msg.media.description:match("کس") or msg.media.description:match("دودول") or msg.media.description:match("حروم زاده") or msg.media.description:match("کسکش") or msg.media.description:match("سیکتیر") or msg.media.description:match("سیک") or msg.media.description:match("ننه") or msg.media.description:match("فاک") or msg.media.description:match("خفه") or msg.media.description:match("[Ff][Uu][Cc][Kk]") or msg.media.description:match("[Nn][Aa][Nn][Ee]") or msg.media.description:match("خوار") or msg.media.description:match("کسه") or msg.media.description:match("[Kk][Hh][Aa][Rr][Kk][Oo][Ss][Ee]") or msg.media.description:match("لاشی")
   if is_badword_desc and lock_badword == "yes" then
    delete_msg(msg.id, ok_cb, false)
    if strict == "yes" or to_chat then
     kick_user(msg.from.id, msg.to.id)
    end
   end
                 local is_username_desc = msg.media.description:match("@")
       if is_username_desc and lock_username == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
             local is_operator_desc = msg.media.description:match("شارژ") or msg.media.description:match("[Ss][Hh][Aa][Jj]") or msg.media.description:match("بسته") or msg.media.description:match("اینترنت") or msg.media.description:match("[Ii][Rr][Aa][Cc][Ee][Ll][Ll") or msg.media.description:match("رایتل") or msg.media.description:match("همراه اول") or msg.media.description:match("ایرانسل") 
			if is_operator_desc and lock_operator == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
             local is_fwd_desc = 'mate:'..msg.to.id
             if is_fwd_desc and mute_forward == "yes" and msg.fwd_from and not is_momod(msg)  then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
               local is_tag_desc = msg.media.description:match("#")
       if is_tag_desc and lock_tag == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_squig_desc = msg.media.description:match("[\216-\219][\128-\191]")
				if is_squig_desc and lock_arabic == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.caption then -- msg.media.caption checks
				local is_link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.caption:match("[Hh][Tt][Tt][Pp][Ss]") or msg.media.caption:match("[Hh][Tt][Tt][Pp]")
				if is_link_caption and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
                local is_username_caption = msg.media.caption:match("@")
       if is_username_caption and lock_username == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
                  local is_badword_caption = msg.media.caption:match("[Kk][Ii][Rr]") or msg.media.caption:match("[Kk][Oo][Ss]") or msg.media.caption:match("[Kk][Oo][Ss][Dd][Ee]") or msg.media.caption:match("[Kk][Oo][Oo][Nn][Ii]") or msg.media.caption:match("[Jj][Ee][Nn][Dd][Ee]") or msg.media.caption:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.media.caption:match("[Kk][Oo][Oo][Nn]") or msg.media.caption:match("کیر") or msg.media.caption:match("کسکش") or msg.media.caption:match("کونی") or msg.media.caption:match("جنده") or msg.media.caption:match("حشری") or msg.media.caption:match("عوضی") or msg.media.caption:match("اشغال") or msg.media.caption:match("کس") or msg.media.caption:match("دودول") or msg.media.caption:match("حروم زاده") or msg.media.caption:match("کسکش") or msg.media.caption:match("سیکتیر") or msg.media.caption:match("سیک") or msg.media.caption:match("ننه") or msg.media.caption:match("فاک") or msg.media.caption:match("خفه") or msg.media.caption:match("[Ff][Uu][Cc][Kk]") or msg.media.caption:match("[Nn][Aa][Nn][Ee]") or msg.media.caption:match("خوار") or msg.media.caption:match("کسه") or msg.media.caption:match("[Kk][Hh][Aa][Rr][Kk][Oo][Ss][Ee]") or msg.media.caption:match("لاشی")
   if is_badword_caption and lock_badword == "yes" then
    delete_msg(msg.id, ok_cb, false)
    if strict == "yes" or to_chat then
     kick_user(msg.from.id, msg.to.id)
    end
   end
         local is_operator_caption = msg.media.caption:match("شارژ") or msg.media.caption:match("[Ss][Hh][Aa][Jj]") or msg.media.caption:match("بسته") or msg.media.caption:match("اینترنت") or msg.media.caption:match("[Ii][Rr][Aa][Cc][Ee][Ll][Ll") or msg.media.caption:match("رایتل") or msg.media.caption:match("همراه اول") or msg.media.caption:match("ایرانسل") 
			if is_operator_caption and lock_operator == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
               local is_fwd_caption = 'mate:'..msg.to.id
             if is_fwd_caption and mute_forward == "yes" and msg.fwd_from and not is_momod(msg)  then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
                local is_tag_caption = msg.media.caption:match("#")
       if is_tag_caption and lock_tag == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_squig_caption = msg.media.caption:match("[\216-\219][\128-\191]")
					if is_squig_caption and lock_arabic == "yes" then
						delete_msg(msg.id, ok_cb, false)
						if strict == "yes" or to_chat then
							kick_user(msg.from.id, msg.to.id)
						end
					end
				local is_username_caption = msg.media.caption:match("^@[%a%d]")
				if is_username_caption and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				if lock_sticker == "yes" and msg.media.caption:match("sticker.webp") then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
			if msg.media.type:match("contact") and lock_contact == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_photo_caption =  msg.media.caption and msg.media.caption:match("photo")--".jpg",
			if is_muted(msg.to.id, 'Photo: yes') and msg.media.type:match("photo") or is_photo_caption and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					--	kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_gif_caption =  msg.media.caption and msg.media.caption:match(".mp4")
			if is_muted(msg.to.id, 'Gifs: yes') and is_gif_caption and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					--	kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, 'Audio: yes') and msg.media.type:match("audio") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_video_caption = msg.media.caption and msg.media.caption:lower(".mp4","video")
			if  is_muted(msg.to.id, 'Video: yes') and msg.media.type:match("video") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, 'Documents: yes') and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
		if msg.fwd_from then
			if msg.fwd_from.title then
				local is_link_title = msg.fwd_from.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.fwd_from.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.fwd_from.title:match("[Hh][Tt][Tt][Pp][Ss]") or msg.fwd_from.title:match("[Hh][Tt][Tt][Pp]")
				if is_link_title and lock_link == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
                local is_operator_title = msg.fwd_from.title:match("شارژ") or msg.fwd_from.title:match("[Ss][Hh][Aa][Jj]") or msg.fwd_from.title:match("بسته") or msg.fwd_from.title:match("اینترنت") or msg.fwd_from.title:match("[Ii][Rr][Aa][Cc][Ee][Ll][Ll") or msg.fwd_from.title:match("رایتل") or msg.fwd_from.title:match("همراه اول") or msg.fwd_from.title:match("ایرانسل") 
			if is_operator_title and lock_operator == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
                  local is_username_title = msg.fwd_from.title:match("@")
       if is_username_title and lock_username == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
             local is_fwd_title = 'mate:'..msg.to.id
             if is_fwd_title and mute_forward == "yes" and msg.fwd_from and not is_momod(msg)  then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
              local is_tag_title = msg.fwd_from.title:match("#")
       if is_tag_title and lock_tag == "yes" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "yes" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_squig_title = msg.fwd_from.title:match("[\216-\219][\128-\191]")
				if is_squig_title and lock_arabic == "yes" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
			end
            	if msg.text:match("%[(contact)%]") then
            if lock_contact == "yes" then
		        if msg.to.type == channel then
                    if lock_strict == "no" then
				        delete_msg(msg.id, ok_cb, true)
				    elseif lock_strict == "yes" then
						delete_msg(msg.id, ok_cb, true)
			            kick_user(msg.from.id, msg.to.id)
				    end
		        end
            end
		end
			if is_muted_user(msg.to.id, msg.fwd_from.peer_id) then
				delete_msg(msg.id, ok_cb, false)
			end
		end
		if msg.service then -- msg.service checks
		local action = msg.action.type
			if action == 'chat_add_user_link' then
				local user_id = msg.from.id
				local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
				if string.len(msg.from.print_name) > 70 or ctrl_chars > 40 and lock_group_spam == 'yes' then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] joined and Service Msg deleted (#spam name)")
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						savelog(msg.to.id, name_log.." ["..msg.from.id.."] joined and kicked (#spam name)")
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local print_name = msg.from.print_name
				local is_rtl_name = print_name:match("‮")
				if is_rtl_name and lock_rtl == "yes" then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] joined and kicked (#RTL char in name)")
					kick_user(user_id, msg.to.id)
				end
				if lock_member == 'yes' then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] joined and kicked (#lockmember)")
					kick_user(user_id, msg.to.id)
					delete_msg(msg.id, ok_cb, false)
				end
			end
			if action == 'chat_add_user' and not is_momod2(msg.from.id, msg.to.id) then
				local user_id = msg.action.user.id
				if string.len(msg.action.user.print_name) > 70 and lock_group_spam == 'yes' then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."]: Service Msg deleted (#spam name)")
					delete_msg(msg.id, ok_cb, false)
					if strict == "yes" or to_chat then
						savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."]: added user kicked (#spam name) ")
						delete_msg(msg.id, ok_cb, false)
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local print_name = msg.action.user.print_name
				local is_rtl_name = print_name:match("‮")
				if is_rtl_name and lock_rtl == "yes" then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] added ["..user_id.."]: added user kicked (#RTL char in name)")
					kick_user(user_id, msg.to.id)
				end
				if msg.to.type == 'channel' and lock_member == 'yes' then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] added ["..user_id.."]: added user kicked  (#lockmember)")
					kick_user(user_id, msg.to.id)
					delete_msg(msg.id, ok_cb, false)
				end
			end
		end
	end
end
-- End 'RondoMsgChecks' text checks by @Rondoozle
	return msg
end
--End pre_process function
return {
	patterns = {},
	pre_process = pre_process
}
--End msg_checks.lua
--By @Rondoozle
