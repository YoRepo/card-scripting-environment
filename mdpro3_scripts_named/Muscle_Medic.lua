--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Muscle Medic  (ID: 4848423)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 4
-- ATK 2200 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a player would take damage from a battle involving this card, they gain that much LP, instead.
--[[ __CARD_HEADER_END__ ]]

--衛生兵マッスラー
function c4848423.initial_effect(c)
	--damage conversion
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(c4848423.rev)
	c:RegisterEffect(e1)
end
function c4848423.rev(e,re,r,rp,rc)
	local c=e:GetHandler()
	return bit.band(r,REASON_BATTLE)~=0
		and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
end
