--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 同调超越  (ID: 57246528)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 23
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以对方场上1只同调怪兽为对象才能发动。把持有比那只怪兽高1星的等级的1只同调怪兽从额外卡组特殊召唤。这个效果特殊召唤的怪兽在这个回合不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--シンクロ・トランセンド
function c57246528.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,57246528+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c57246528.target)
	e1:SetOperation(c57246528.activate)
	c:RegisterEffect(e1)
end
function c57246528.opfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and Duel.IsExistingMatchingCard(c57246528.tpfilter,tp,LOCATION_EXTRA,0,1,nil,c:GetLevel(),e,tp)
end
function c57246528.tpfilter(c,lv,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsLevel(lv+1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c57246528.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c57246528.opfilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c57246528.opfilter,tp,0,LOCATION_MZONE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c57246528.opfilter,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c57246528.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c57246528.tpfilter,tp,LOCATION_EXTRA,0,1,1,nil,tc:GetLevel(),e,tp):GetFirst()
	if sg and Duel.SpecialSummonStep(sg,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(57246528,0))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		sg:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
