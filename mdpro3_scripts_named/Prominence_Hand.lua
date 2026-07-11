--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Prominence Hand  (ID: 21414674)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 600 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Magic Hand", "Fire Hand", or "Ice Hand", you can Special Summon this card (from
-- your hand).
--[[ __CARD_HEADER_END__ ]]

--プロミネンス・ハンド
function c21414674.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c21414674.spcon)
	c:RegisterEffect(e1)
end
function c21414674.filter(c)
	return c:IsFaceup() and c:IsCode(22530212,68535320,95929069)
end
function c21414674.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21414674.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
