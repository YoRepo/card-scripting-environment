--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 投送燕  (ID: 10505300)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 1
-- ATK 100 | DEF 100
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：场上有相同等级的怪兽2只以上存在的场合，这张卡可以从手卡特殊召唤。
-- ②：把这张卡解放才能发动。下次的自己抽卡阶段的通常抽卡变成2张。
--[[ __CARD_HEADER_END__ ]]

--スロワースワロー
function c10505300.initial_effect(c)
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCountLimit(1,10505300+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c10505300.spcon)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10505300,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c10505300.cost)
	e2:SetOperation(c10505300.operation)
	c:RegisterEffect(e2)
end
function c10505300.spfilter1(c)
	return c:IsFaceup() and c:IsLevelAbove(0)
		and Duel.IsExistingMatchingCard(c10505300.spfilter2,0,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetLevel())
end
function c10505300.spfilter2(c,lv)
	return c:IsFaceup() and c:IsLevel(lv)
end
function c10505300.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c10505300.spfilter1,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c10505300.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c10505300.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	e1:SetValue(2)
	Duel.RegisterEffect(e1,tp)
end
