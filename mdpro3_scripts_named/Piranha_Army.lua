--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Piranha Army  (ID: 50823978)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 2
-- ATK 800 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- The Battle Damage this card inflicts by attacking your opponent's Life Points directly is doubled.
--[[ __CARD_HEADER_END__ ]]

--軍隊ピラニア
function c50823978.initial_effect(c)
	--deepen damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetCondition(c50823978.dcon)
	e1:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e1)
end
function c50823978.dcon(e)
	return Duel.GetAttackTarget()==nil
end
