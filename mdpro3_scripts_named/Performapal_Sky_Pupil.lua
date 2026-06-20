--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 娱乐伙伴 天空徒弟  (ID: 122520)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 800 | DEF 800
-- Setcode: 159
--
-- Effect Text:
-- 「娱乐伙伴 天空徒弟」的①的效果1回合只能使用1次。
-- ①：让自己场上1只5星以上的「娱乐伙伴」怪兽回到持有者手卡才能发动。这张卡从手卡特殊召唤。这个效果在对方回合也能发动。
-- ②：这张卡和对方怪兽进行战斗的场合，直到伤害步骤结束时那只怪兽的效果无效化。
-- ③：自己场上有其他的「娱乐伙伴」怪兽存在的场合，这张卡向对方怪兽攻击的伤害计算前才能发动。那只对方怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--EMスカイ・ピューピル
function c122520.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(122520,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,122520)
	e1:SetCost(c122520.spcost)
	e1:SetTarget(c122520.sptg)
	e1:SetOperation(c122520.spop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c122520.distg)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(122520,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetCondition(c122520.descon)
	e3:SetTarget(c122520.destg)
	e3:SetOperation(c122520.desop)
	c:RegisterEffect(e3)
end
function c122520.spcfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c:IsLevelAbove(5) and c:IsAbleToHandAsCost()
end
function c122520.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c122520.spcfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,c122520.spcfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoHand(g,nil,REASON_COST)
end
function c122520.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c122520.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c122520.distg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c122520.descfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c122520.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c122520.descfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c122520.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local t=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetAttacker()==e:GetHandler() and t~=nil end
	Duel.SetTargetCard(t)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,t,1,0,0)
end
function c122520.desop(e,tp,eg,ep,ev,re,r,rp)
	local t=Duel.GetFirstTarget()
	if t:IsRelateToBattle() then
		Duel.Destroy(t,REASON_EFFECT)
	end
end
