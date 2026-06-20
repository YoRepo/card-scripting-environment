--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 水精鳞-深渊象鼻鱼兵  (ID: 282886)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1500 | DEF 1500
-- Setcode: 7667828
--
-- Effect Text:
-- 这张卡战斗破坏对方怪兽送去墓地时，把手卡1只水属性怪兽丢弃去墓地才能发动。从卡组把1只名字带有「水精鳞」的怪兽表侧守备表示特殊召唤。「水精鳞-深渊象鼻鱼兵」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--水精鱗－アビスノーズ
function c282886.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(282886,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCountLimit(1,282886)
	e1:SetCondition(aux.bdogcon)
	e1:SetCost(c282886.spcost)
	e1:SetTarget(c282886.sptg)
	e1:SetOperation(c282886.spop)
	c:RegisterEffect(e1)
end
function c282886.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c282886.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c282886.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c282886.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c282886.filter(c,e,tp)
	return c:IsSetCard(0x74) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c282886.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c282886.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c282886.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c282886.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
