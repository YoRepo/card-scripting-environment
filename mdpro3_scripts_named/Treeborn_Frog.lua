--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 黄泉青蛙  (ID: 12538374)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 18
--
-- Effect Text:
-- ①：这张卡在墓地存在，自己场上没有「黄泉青蛙」存在的场合，自己准备阶段才能发动。这张卡特殊召唤。这个效果在自己场上没有魔法·陷阱卡存在的场合才能发动和处理。
--[[ __CARD_HEADER_END__ ]]

--黄泉ガエル
function c12538374.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12538374,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCondition(c12538374.condition)
	e1:SetTarget(c12538374.target)
	e1:SetOperation(c12538374.operation)
	c:RegisterEffect(e1)
end
function c12538374.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) or (c:IsCode(12538374) and c:IsFaceup())
end
function c12538374.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and not Duel.IsExistingMatchingCard(c12538374.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c12538374.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c12538374.filter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c12538374.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and not Duel.IsExistingMatchingCard(c12538374.filter2,tp,LOCATION_ONFIELD,0,1,nil) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
