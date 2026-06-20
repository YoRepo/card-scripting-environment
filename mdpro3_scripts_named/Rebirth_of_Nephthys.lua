--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 奈芙提斯的轮回  (ID: 23459650)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 287
--
-- Effect Text:
-- 「奈芙提斯」仪式怪兽的降临必需。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「奈芙提斯」仪式怪兽仪式召唤。把「奈芙提斯之祭祀者」或者「奈芙提斯之苍凰神」解放作仪式召唤的场合，可以再选场
-- 上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ネフティスの輪廻
function c23459650.initial_effect(c)
	aux.AddCodeList(c,88176533,24175232)
	aux.AddRitualProcGreater2(c,c23459650.filter,LOCATION_HAND,nil,nil,false,c23459650.extraop)
end
function c23459650.filter(c,e,tp)
	return c:IsSetCard(0x11f)
end
function c23459650.mfilter(c)
	if c:IsPreviousLocation(LOCATION_MZONE) then
		local code,code2=c:GetPreviousCodeOnField()
		return code==88176533 or code==24175232 or code2==88176533 or code2==24175232
	end
	return c:IsCode(88176533,24175232)
end
function c23459650.extraop(e,tp,eg,ep,ev,re,r,rp,tc,mat)
	if not tc then return end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if mat:IsExists(c23459650.mfilter,1,nil) and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(23459650,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,1,e:GetHandler())
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
