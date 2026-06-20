--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 漆黑之魔王 LV8  (ID: 58206034)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 8
-- ATK 2800 | DEF 900
-- Setcode: 65
--
-- Effect Text:
-- 用「漆黑之魔王 LV6」的效果特殊召唤的场合，这张卡战斗破坏的对方怪兽的效果无效化，并且从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--漆黒の魔王 LV8
function c58206034.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c58206034.discon)
	e1:SetOperation(c58206034.disop)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e2:SetCondition(c58206034.discon)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
end
c58206034.lvup={12817939}
c58206034.lvdn={85313220,12817939}
function c58206034.discon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_LV
end
function c58206034.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttackTarget()
	if d==c then d=Duel.GetAttacker() end
	if d and d:IsStatus(STATUS_BATTLE_DESTROYED) and d:IsType(TYPE_EFFECT) and not c:IsStatus(STATUS_BATTLE_DESTROYED) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		d:RegisterEffect(e1)
	end
end
