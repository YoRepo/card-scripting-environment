--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 书灵师介入  (ID: 44889144)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 380
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方把魔法·陷阱·怪兽的效果发动时，以自己场上1只「书灵师」仪式怪兽为对象才能发动。那只怪兽回到持有者手卡，那个发动的效果无效。那之后，可以从自己的手卡·墓地选1只「书灵师」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リブロマンサー・インターフェア
local s,id,o=GetID()
function s.initial_effect(c)
	--return from field to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DISABLE+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.f2hcon)
	e1:SetTarget(s.f2htg)
	e1:SetOperation(s.f2hop)
	c:RegisterEffect(e1)
end
function s.f2hcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.IsChainDisablable(ev)
end
function s.f2hfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x17c) and c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.f2htg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.f2hfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.f2hfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,s.f2hfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x17c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.f2hop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0
		and tc:IsLocation(LOCATION_HAND) and Duel.NegateEffect(ev)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
		if #sg>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
