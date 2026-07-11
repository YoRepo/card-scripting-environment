--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Pilgrim of the Ice Barrier  (ID: 20700531)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 4
-- ATK 1500 | DEF 1000
-- Setcode: 0x2f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be destroyed by battle with a monster that has 1900 or more ATK.
--[[ __CARD_HEADER_END__ ]]

--氷結界の修験者
function c20700531.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c20700531.indes)
	c:RegisterEffect(e1)
end
function c20700531.indes(e,c)
	if c:IsDefensePos() and Duel.GetAttacker()==c then
		return c:IsDefenseAbove(1900)
	else
		return c:IsAttackAbove(1900)
	end
end
