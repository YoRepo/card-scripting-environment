--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 双头地狱犬  (ID: 88132637)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 1000
--
-- Effect Text:
-- 自己的场上有这张卡以外的其他恶魔族怪兽表侧表示存在的场合，这张卡战斗破坏的反转效果怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--ツインヘッド・ケルベロス
function c88132637.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c88132637.discon)
	e1:SetOperation(c88132637.disop)
	c:RegisterEffect(e1)
end
function c88132637.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c88132637.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c88132637.filter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c88132637.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and bc:IsType(TYPE_FLIP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e2)
	end
end
