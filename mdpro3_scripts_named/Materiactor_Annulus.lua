--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 原质圆环炉  (ID: 17008760)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 352
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上1个超量素材取除。取除的超量素材被送去自己墓地的场合，可以再把那张卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--原質の円環炉
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON+CATEGORY_SSET+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_EFFECT) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DEATTACHFROM)
	local sg=Duel.SelectMatchingCard(tp,Card.CheckRemoveOverlayCard,tp,LOCATION_MZONE,0,1,1,nil,tp,1,REASON_EFFECT)
	if sg:GetCount()==0 then return end
	if sg:GetFirst():RemoveOverlayCard(tp,1,1,REASON_EFFECT) then
		local tc=Duel.GetOperatedGroup():GetFirst()
		if tc and tc:IsControler(tp) and tc:IsLocation(LOCATION_GRAVE) and aux.NecroValleyFilter()(tc) then
			if tc:IsType(TYPE_MONSTER) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
				and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE)
				and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
				Duel.BreakEffect()
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
				Duel.ConfirmCards(1-tp,tc)
			elseif (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
				and tc:IsSSetable() and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
				Duel.BreakEffect()
				Duel.SSet(tp,tc)
			end
		end
	end
end
