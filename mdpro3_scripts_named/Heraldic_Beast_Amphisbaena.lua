--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 纹章兽 双头蛇  (ID: 87255382)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 4
-- ATK 1700 | DEF 1100
-- Setcode: 118
--
-- Effect Text:
-- 自己的主要阶段时，从手卡把这张卡以外的1只名字带有「纹章兽」的怪兽丢弃才能发动。这张卡从手卡特殊召唤。此外，1回合1次，从手卡丢弃1只名字带有「纹章兽」的怪兽才能发动。这张卡的攻击力直到结束阶段时上升
-- 800。
--[[ __CARD_HEADER_END__ ]]

--紋章獣アンフィスバエナ
function c87255382.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87255382,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c87255382.cost)
	e1:SetTarget(c87255382.sptg)
	e1:SetOperation(c87255382.spop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87255382,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c87255382.cost)
	e2:SetOperation(c87255382.atkop)
	c:RegisterEffect(e2)
end
function c87255382.cfilter(c)
	return c:IsSetCard(0x76) and c:IsDiscardable()
end
function c87255382.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c87255382.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c87255382.cfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c87255382.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c87255382.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c87255382.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		c:RegisterEffect(e1)
	end
end
