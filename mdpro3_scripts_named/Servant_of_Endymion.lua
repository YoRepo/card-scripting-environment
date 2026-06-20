--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 恩底弥翁的仆从  (ID: 92559258)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Spellcaster
-- Level 3
-- Pendulum Scales: L2 / R2
-- ATK 900 | DEF 1500
-- Setcode: 298
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：每次自己或者对方把魔法卡发动，给这张卡放置1个魔力指示物。
-- ②：把这张卡3个魔力指示物取除才能发动。卡组1只可以放置魔力指示物的攻击力1000以上的怪兽和灵摆区域的这张卡特殊召唤，给那2只各放置1个魔力指示物。
-- 【怪兽效果】
-- 自己对「恩底弥翁的仆从」1回合只能有1次特殊召唤。
-- ①：有魔力指示物放置的这张卡可以直接攻击。
-- ②：对方回合1次，丢弃1张手卡才能发动。给这张卡以及自己场上的可以放置魔力指示物的卡全部各放置1个魔力指示物。
-- ③：怪兽区域的这张卡被破坏的场合才能发动。这张卡在自己的灵摆区域放置。那之后，这张卡放置过的数量的魔力指示物给这张卡放置。
--[[ __CARD_HEADER_END__ ]]

--サーヴァント・オブ・エンディミオン
function c92559258.initial_effect(c)
	--Pendulum Summon
	c:EnableCounterPermit(0x1,LOCATION_PZONE+LOCATION_MZONE)
	aux.EnablePendulumAttribute(c)
	c:SetSPSummonOnce(92559258)
	--Add Counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetOperation(aux.chainreg)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetOperation(c92559258.counterop)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92559258,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCost(c92559258.spcost)
	e3:SetTarget(c92559258.sptg)
	e3:SetOperation(c92559258.spop)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c92559258.dacon)
	c:RegisterEffect(e4)
	--add counter
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(92559258,1))
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetHintTiming(0,TIMING_END_PHASE)
	e5:SetCondition(c92559258.countercon2)
	e5:SetCost(c92559258.countercost2)
	e5:SetTarget(c92559258.countertg2)
	e5:SetOperation(c92559258.counterop2)
	c:RegisterEffect(e5)
	--pendulum set
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(92559258,2))
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCode(EVENT_DESTROYED)
	e6:SetCondition(c92559258.pencon)
	e6:SetTarget(c92559258.pentg)
	e6:SetOperation(c92559258.penop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_LEAVE_FIELD_P)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetOperation(c92559258.regop)
	e7:SetLabelObject(e6)
	c:RegisterEffect(e7)
end
function c92559258.counterop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0 then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c92559258.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x1,3,REASON_COST)
end
function c92559258.spfilter(c,e,tp)
	return c:IsAttackAbove(1000) and c:IsCanHaveCounter(0x1) and Duel.IsCanAddCounter(tp,0x1,1,c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92559258.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsCanAddCounter(tp,0x1,1,c)
		and Duel.IsExistingMatchingCard(c92559258.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,2,tp,LOCATION_DECK)
end
function c92559258.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c92559258.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		g:AddCard(c)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		for tc in aux.Next(g) do
			tc:AddCounter(0x1,1)
		end
	end
end
function c92559258.dacon(e)
	return e:GetHandler():GetCounter(0x1)>0
end
function c92559258.countercon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function c92559258.countercost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c92559258.countertg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanAddCounter(0x1,1) end
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,LOCATION_ONFIELD,0,c,0x1,1)
	g:AddCard(c)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,g,#g,0,0)
end
function c92559258.counterop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,LOCATION_ONFIELD,0,c,0x1,1)
	if c:IsRelateToEffect(e) then g:AddCard(c) end
	for tc in aux.Next(g) do
		if tc:IsCanAddCounter(0x1,1) then
			tc:AddCounter(0x1,1)
		end
	end
end
function c92559258.pencon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceup()
end
function c92559258.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function c92559258.penop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=e:GetLabel()
	if c:IsRelateToEffect(e) and Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true)
		and ct>0 then
		c:AddCounter(0x1,ct)
	end
end
function c92559258.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(e:GetHandler():GetCounter(0x1))
end
