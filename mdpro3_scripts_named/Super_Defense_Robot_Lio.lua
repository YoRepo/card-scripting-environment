--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 超级防卫机器人·狮斗士  (ID: 8091563)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1600
-- Setcode: 133
--
-- Effect Text:
-- 这张卡召唤成功时，可以从手卡把1只名字带有「超级防卫机器人」的怪兽或者「轨道 7」特殊召唤。此外，1回合1次，从自己墓地有名字带有「超级防卫机器人」的怪兽或者「轨道
-- 7」1只加入自己手卡时，可以把那只怪兽从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--SDロボ・ライオ
function c8091563.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(8091563,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c8091563.sumtg)
	e1:SetOperation(c8091563.sumop)
	c:RegisterEffect(e1)
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(8091563,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetCountLimit(1)
	e2:SetCondition(c8091563.spcon)
	e2:SetTarget(c8091563.sptg)
	e2:SetOperation(c8091563.spop)
	c:RegisterEffect(e2)
end
function c8091563.filter(c,e,tp)
	return (c:IsSetCard(0x85) or c:IsCode(71071546)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c8091563.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c8091563.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c8091563.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c8091563.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c8091563.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and (tc:IsSetCard(0x85) or tc:IsCode(71071546))
		and tc:IsControler(tp) and tc:IsPreviousControler(tp) and tc:IsPreviousLocation(LOCATION_GRAVE)
end
function c8091563.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:GetFirst():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,eg,1,0,0)
end
function c8091563.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
