--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ritual Raven  (ID: 34334692)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 1
-- ATK 300 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you Ritual Summon exactly 1 DARK Ritual Monster with a card effect that requires use of monsters,
-- this card can be used as the entire requirement.
--[[ __CARD_HEADER_END__ ]]

--儀式の供物
function c34334692.initial_effect(c)
	--ritual level
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_RITUAL_LEVEL)
	e1:SetValue(c34334692.rlevel)
	c:RegisterEffect(e1)
end
function c34334692.rlevel(e,c)
	local lv=aux.GetCappedLevel(e:GetHandler())
	if c:IsAttribute(ATTRIBUTE_DARK) then
		local clv=c:GetLevel()
		return (lv<<16)+clv
	else return lv end
end
