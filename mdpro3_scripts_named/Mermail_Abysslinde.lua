--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 水精鳞-深渊琳德  (ID: 23899727)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1500 | DEF 1200
-- Setcode: 7667828
--
-- Effect Text:
-- 场上的这张卡被破坏送去墓地的场合，可以从卡组把「水精鳞-深渊琳德」以外的1只名字带有「水精鳞」的怪兽特殊召唤。「水精鳞-深渊琳德」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスリンデ
function c23899727.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23899727,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,23899727)
	e1:SetCondition(c23899727.condition)
	e1:SetTarget(c23899727.target)
	e1:SetOperation(c23899727.operation)
	c:RegisterEffect(e1)
end
function c23899727.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c23899727.filter(c,e,tp)
	return c:IsSetCard(0x74) and not c:IsCode(23899727) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23899727.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23899727.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23899727.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23899727.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
