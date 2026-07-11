--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Obnoxious Celtic Guard  (ID: 52077741)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 4
-- ATK 1400 | DEF 1200
-- Setcode: 0xe4
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be destroyed by battle with a monster that has 1900 or more ATK.
--[[ __CARD_HEADER_END__ ]]

--翻弄するエルフの剣士
function c52077741.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c52077741.indes)
	c:RegisterEffect(e1)
end
function c52077741.indes(e,c)
	if c:IsDefensePos() and Duel.GetAttacker()==c then
		return c:IsDefenseAbove(1900)
	else
		return c:IsAttackAbove(1900)
	end
end
