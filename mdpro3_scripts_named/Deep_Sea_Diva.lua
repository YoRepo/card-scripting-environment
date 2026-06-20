--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 深海歌后  (ID: 78868119)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 2
-- ATK 200 | DEF 400
--
-- Effect Text:
-- ①：这张卡召唤成功时才能发动。从卡组把1只3星以下的海龙族怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--深海のディーヴァ
function c78868119.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78868119,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c78868119.sumtg)
	e1:SetOperation(c78868119.sumop)
	c:RegisterEffect(e1)
end
function c78868119.filter(c,e,sp)
	return c:IsLevelBelow(3) and c:IsRace(RACE_SEASERPENT) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c78868119.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c78868119.filter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c78868119.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c78868119.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
