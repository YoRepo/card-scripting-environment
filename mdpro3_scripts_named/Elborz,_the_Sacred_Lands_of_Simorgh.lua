--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 神鸟的灵峰 厄尔布尔士山  (ID: 92223430)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 301
--
-- Effect Text:
-- 这个卡名的②③的效果1回合各能使用1次。
-- ①：场上的鸟兽族·风属性怪兽的攻击力·守备力上升300。
-- ②：把手卡的5星以上的鸟兽族·风属性怪兽给对方观看才能发动。这个回合，自己可以把鸟兽族怪兽召唤的场合需要的解放减少1只。
-- ③：自己场上有鸟兽族·风属性怪兽存在的场合才能发动。把1只鸟兽族怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--神鳥の霊峰エルブルズ
function c92223430.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c92223430.atktg)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	local e5=e2:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
	--decrease tribute
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92223430,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1,92223430)
	e3:SetCost(c92223430.trcost)
	e3:SetOperation(c92223430.trop)
	c:RegisterEffect(e3)
	--summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(92223430,1))
	e4:SetCategory(CATEGORY_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,92223431)
	e4:SetCondition(c92223430.sumcon)
	e4:SetTarget(c92223430.sumtg)
	e4:SetOperation(c92223430.sumop)
	c:RegisterEffect(e4)
end
function c92223430.atktg(e,c)
	return c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c92223430.costfilter(c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WIND) and not c:IsPublic()
end
function c92223430.trcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92223430.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c92223430.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c92223430.trop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DECREASE_TRIBUTE)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WINDBEAST))
	e1:SetValue(0x1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c92223430.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c92223430.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c92223430.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c92223430.sumfilter(c)
	return c:IsRace(RACE_WINDBEAST) and c:IsSummonable(true,nil)
end
function c92223430.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92223430.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c92223430.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,c92223430.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
