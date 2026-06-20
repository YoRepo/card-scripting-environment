--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 遗式的写魂镜  (ID: 9236985)
-- Type: Spell / Ritual
-- ATK 0 | DEF 0
-- Setcode: 58
--
-- Effect Text:
-- 名字带有「遗式」的仪式怪兽的降临必需。必须支付仪式召唤的怪兽等级×500基本分。
--[[ __CARD_HEADER_END__ ]]

--リチュアの写魂鏡
function c9236985.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9236985.target)
	e1:SetOperation(c9236985.activate)
	c:RegisterEffect(e1)
end
function c9236985.filter(c,e,tp,lp)
	if bit.band(c:GetType(),0x81)~=0x81 or not c:IsSetCard(0x3a)
		or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false) then return false end
	return lp>c:GetLevel()*500
end
function c9236985.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local lp=Duel.GetLP(tp)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c9236985.filter,tp,LOCATION_HAND,0,1,nil,e,tp,lp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c9236985.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local lp=Duel.GetLP(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c9236985.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,lp)
	local tc=tg:GetFirst()
	if tc then
		Duel.PayLPCost(tp,tc:GetLevel()*500)
		tc:SetMaterial(nil)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
