--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 严格的老魔术师  (ID: 87557188)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1500 | DEF 1200
-- Setcode: 152
--
-- Effect Text:
-- ①：这张卡反转的场合发动。场上盖放的卡全部确认。
--[[ __CARD_HEADER_END__ ]]

--厳格な老魔術師
function c87557188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c87557188.target)
	e1:SetOperation(c87557188.activate)
	c:RegisterEffect(e1)
end
function c87557188.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c87557188.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
	end
end
