--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: cards.cdb
-- Card: Flame Ruler  (ID: 41089128)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 4
-- ATK 1500 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be treated as 2 Tributes for the Tribute Summon of a FIRE monster.
--[[ __CARD_HEADER_END__ ]]

--炎を支配する者
function c41089128.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c41089128.condition)
	c:RegisterEffect(e1)
end
function c41089128.condition(e,c)
	local ec=e:GetHandler()
	return c:IsAttribute(ATTRIBUTE_FIRE) and (ec:IsFaceup() or c:GetControler()==ec:GetControler())
end
