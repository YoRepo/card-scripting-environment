--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 究极传导恐兽  (ID: 18940556)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Dinosaur
-- Level 10
-- ATK 3500 | DEF 3200
--
-- Effect Text:
-- 这张卡不能通常召唤。从自己墓地把2只恐龙族怪兽除外的场合可以特殊召唤。
-- ①：1回合1次，自己·对方的主要阶段才能发动。选自己的手卡·场上1只怪兽破坏，对方场上的表侧表示怪兽全部变成里侧守备表示。
-- ②：这张卡可以向对方怪兽全部各作1次攻击。
-- ③：这张卡向守备表示怪兽攻击的伤害步骤开始时才能发动。给与对方1000伤害，那只守备表示怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--究極伝導恐獣
function c18940556.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c18940556.sprcon)
	e1:SetTarget(c18940556.sprtg)
	e1:SetOperation(c18940556.sprop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18940556,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCondition(c18940556.descon)
	e2:SetTarget(c18940556.destg)
	e2:SetOperation(c18940556.desop)
	c:RegisterEffect(e2)
	--attack all
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--to grave
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(18940556,1))
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_TOGRAVE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLE_START)
	e4:SetTarget(c18940556.tgtg)
	e4:SetOperation(c18940556.tgop)
	c:RegisterEffect(e4)
end
function c18940556.sprfilter(c)
	return c:IsRace(RACE_DINOSAUR) and c:IsAbleToRemoveAsCost()
end
function c18940556.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c18940556.sprfilter,tp,LOCATION_GRAVE,0,2,nil)
end
function c18940556.sprtg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c18940556.sprfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=g:CancelableSelect(tp,2,2,nil)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c18940556.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c18940556.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c18940556.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c18940556.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,TYPE_MONSTER)
		and Duel.IsExistingMatchingCard(c18940556.posfilter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c18940556.posfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_HAND+LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c18940556.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,TYPE_MONSTER)
	if g1:GetCount()>0 and Duel.Destroy(g1,REASON_EFFECT)~=0 then
		local g2=Duel.GetMatchingGroup(c18940556.posfilter,tp,0,LOCATION_MZONE,nil)
		if g2:GetCount()>0 then
			Duel.ChangePosition(g2,POS_FACEDOWN_DEFENSE)
		end
	end
end
function c18940556.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler() and d and d:IsDefensePos() end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,d,1,0,0)
end
function c18940556.tgop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Damage(1-tp,1000,REASON_EFFECT)~=0 then
		local d=Duel.GetAttackTarget()
		if d:IsRelateToBattle() and d:IsDefensePos() then
			Duel.SendtoGrave(d,REASON_EFFECT)
		end
	end
end
