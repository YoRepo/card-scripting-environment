--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 卫生兵 肌肉大汉  (ID: 4848423)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 4
-- ATK 2200 | DEF 100
--
-- Effect Text:
-- ①：这张卡的战斗让自己或者对方受到战斗伤害的场合，作为代替让基本分回复那个数值。
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
