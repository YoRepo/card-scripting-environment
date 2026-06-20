--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 秘仪之力14-节制  (ID: 60953118)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 6
-- ATK 2400 | DEF 2400
-- Setcode: 5
--
-- Effect Text:
-- 可以从手卡把这张卡丢弃，自己受到的战斗伤害只有1次变成0。这张卡召唤·反转召唤·特殊召唤成功时，进行1次投掷硬币得到以下效果。
-- ●表：自己受到的战斗伤害变成一半数值。
-- ●里：对方受到的战斗伤害变成一半数值。
--[[ __CARD_HEADER_END__ ]]

--アルカナフォースⅩⅣ－TEMPERANCE
function c60953118.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60953118,1))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c60953118.damcon)
	e1:SetCost(c60953118.damcost)
	e1:SetOperation(c60953118.damop)
	c:RegisterEffect(e1)
	--coin
	aux.EnableArcanaCoin(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP_SUMMON_SUCCESS,EVENT_SPSUMMON_SUCCESS)
	--coin effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetCondition(c60953118.rdcon1)
	e2:SetValue(HALF_DAMAGE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetTargetRange(0,1)
	e3:SetCondition(c60953118.rdcon2)
	c:RegisterEffect(e3)
end
function c60953118.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c60953118.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c60953118.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	Duel.RegisterEffect(e1,tp)
end
function c60953118.rdcon1(e)
	return e:GetHandler():GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)==1
end
function c60953118.rdcon2(e)
	return e:GetHandler():GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)==0
end
