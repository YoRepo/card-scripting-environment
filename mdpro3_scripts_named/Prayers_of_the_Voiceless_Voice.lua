--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 肃声之祈祷  (ID: 52472775)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 422
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的光属性怪兽解放，从手卡把1只光属性仪式怪兽仪式召唤。
-- ②：自己场上的表侧表示的光属性仪式怪兽因对方的效果从场上离开的场合，把墓地的这张卡除外才能发动。从手卡·卡组把「古圣戴 始龙」「龙姬神 萨菲拉」「肃声之守护者
-- 法理守护者」的其中1只无视召唤条件特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--粛声なる祈り
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,4810828,56350972,10774240)
	--Activate
	aux.AddRitualProcGreater2(c,s.spfilter,nil,nil,s.mfilter)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.spcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.spfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function s.mfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT)
end
function s.plcfilter(c,tp)
	return c:IsType(TYPE_RITUAL) and c:IsPreviousControler(tp)
		and c:IsAttribute(ATTRIBUTE_LIGHT) and c:GetPreviousAttributeOnField()&ATTRIBUTE_LIGHT>0
		and c:IsPreviousPosition(POS_FACEUP) and c:GetReasonPlayer()==1-tp
		and c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.plcfilter,1,nil,tp)
end
function s.filter(c,e,tp)
	return c:IsCode(4810828,56350972,10774240) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
