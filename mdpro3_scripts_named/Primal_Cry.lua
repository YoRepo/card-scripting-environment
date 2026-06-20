--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 原初的叫唤  (ID: 47435107)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 「辉神鸟 贝努鸟」的降临必需。
-- ①：从自己的手卡·场上把等级合计直到8以上的怪兽解放，从手卡把「辉神鸟 贝努鸟」仪式召唤。
-- ②：自己结束阶段把墓地的这张卡除外，以这个回合从场上送去墓地的自己墓地1只仪式怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--原初の叫喚
function c47435107.initial_effect(c)
	aux.AddRitualProcGreaterCode(c,10441498)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47435107,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1)
	e1:SetCondition(c47435107.spcon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c47435107.sptg)
	e1:SetOperation(c47435107.spop)
	c:RegisterEffect(e1)
end
function c47435107.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c47435107.spfilter(c,e,tp,turn)
	return c:IsType(TYPE_RITUAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetTurnID()==turn
end
function c47435107.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local turn=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c47435107.spfilter(chkc,e,tp,turn) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c47435107.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,turn) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c47435107.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,turn)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c47435107.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
