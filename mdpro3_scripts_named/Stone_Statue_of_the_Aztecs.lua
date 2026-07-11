--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Stone Statue of the Aztecs  (ID: 31812496)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 300 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Double any battle damage your opponent takes when they attack this monster.
--[[ __CARD_HEADER_END__ ]]

--アステカの石像
function c31812496.initial_effect(c)
	--deepen damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e1:SetCondition(c31812496.dcon)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e1)
end
function c31812496.dcon(e)
	local c=e:GetHandler()
	return Duel.GetAttackTarget()==c
end
