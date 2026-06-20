--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 异虫呼唤  (ID: 28506708)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 62
--
-- Effect Text:
-- 对方场上有怪兽存在，自己场上没有怪兽存在的场合，可以从手卡把1只名字带有「异虫」的爬虫类族怪兽里侧守备表示特殊召唤。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ワーム・コール
function c28506708.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28506708,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c28506708.condition)
	e1:SetTarget(c28506708.target)
	e1:SetOperation(c28506708.operation)
	c:RegisterEffect(e1)
end
function c28506708.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
end
function c28506708.filter(c,e,sp)
	return c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE) and c:IsCanBeSpecialSummoned(e,0,sp,false,false,POS_FACEDOWN_DEFENSE)
end
function c28506708.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c28506708.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c28506708.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		or Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c28506708.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(1-tp,g)
	end
end
