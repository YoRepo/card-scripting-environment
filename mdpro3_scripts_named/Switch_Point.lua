--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Switch Point  (ID: 47961342)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Choose 1 monster your opponent controls, and your opponent sends either of the following to the GY.
-- ● The chosen monster.
-- ● The other monsters they control.
-- Your opponent must control 3 or more monsters for you to activate and resolve this effect.
--[[ __CARD_HEADER_END__ ]]

--転轍地点
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>2 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_MZONE)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)<3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.HintSelection(g)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	local opt=Duel.SelectOption(1-tp,aux.Stringid(id,1),aux.Stringid(id,2))
	if opt==0 then
		Duel.SendtoGrave(g,REASON_RULE,1-tp)
	else
		local g2=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,g)
		Duel.SendtoGrave(g2,REASON_RULE,1-tp)
	end
end
