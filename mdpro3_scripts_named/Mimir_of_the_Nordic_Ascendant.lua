--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 极星天 密弥尔  (ID: 76348260)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fairy
-- Level 2
-- ATK 600 | DEF 0
-- Setcode: 12354
--
-- Effect Text:
-- 自己场上有名字带有「极星」的怪兽表侧表示存在的场合，自己的准备阶段开始时只有1次，从手卡把1张魔法卡送去墓地才能发动。墓地存在的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--極星天ミーミル
function c76348260.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76348260,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCondition(c76348260.condition)
	e1:SetCost(c76348260.cost)
	e1:SetTarget(c76348260.target)
	e1:SetOperation(c76348260.operation)
	c:RegisterEffect(e1)
end
function c76348260.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x42)
end
function c76348260.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and not Duel.CheckPhaseActivity()
		and Duel.IsExistingMatchingCard(c76348260.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c76348260.costfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c76348260.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c76348260.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c76348260.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c76348260.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c76348260.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
