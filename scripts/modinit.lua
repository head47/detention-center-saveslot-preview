local populateSaveSlotsOld

local function init( modApi )
    modApi.requirements = {"Sim Constructor", "More Save Slots"}
end

local function load( modApi, options )
    local saveslotsDialog = include( "fe/saveslots-dialog" )
    populateSaveSlotsOld = populateSaveSlotsOld or saveslotsDialog.populateSaveSlots

    function saveslotsDialog:populateSaveSlots()
        populateSaveSlotsOld(self)

        local listbox = self._screen.binder.listbox
        local user = savefiles.getCurrentGame()
        for i,campaign in pairs(user.data.saveSlots) do
            if campaign then    -- not needed?
                local widget = listbox:getItem( i ).widget
                local situations_number = 0
                for _,situation in pairs(campaign.situations) do
                    if situation.name == "detention_centre" then
                        situations_number = situations_number + 1
                    end
                end
                if situations_number > 0 then
                    oldtxt = widget.binder.txt:getText()
                    widget.binder.txt:setText( oldtxt .. string.format("<font1_16_sb>, <c:f4ff78>%s DCs available</></>", situations_number) )
                end
            end
        end
    end
end

return {
    init = init,
    load = load,
}
