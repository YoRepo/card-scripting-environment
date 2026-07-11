--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Sonic Chick  (ID: 36472900)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Winged Beast
-- Level: 1
-- ATK 300 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be destroyed by battle with a monster that has 1900 or more ATK.
--[[ __CARD_HEADER_END__ ]]

--ロードランナー
function c36472900.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c36472900.indes)
	c:RegisterEffect(e1)
end
function c36472900.indes(e,c)
	if c:IsDefensePos() and Duel.GetAttacker()==c then
		return c:IsDefenseAbove(1900)
	else
		return c:IsAttackAbove(1900)
	end
end
