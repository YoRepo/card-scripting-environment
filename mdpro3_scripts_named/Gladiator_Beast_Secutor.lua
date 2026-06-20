--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 剑斗兽 追斗  (ID: 77642288)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Reptile
-- Level 4
-- ATK 400 | DEF 300
-- Setcode: 4121
--
-- Effect Text:
-- 这张卡用名字带有「剑斗兽」的怪兽的效果特殊召唤成功的场合，这张卡进行战斗的战斗阶段结束时，从卡组把「剑斗兽 追斗」以外的2只名字带有「剑斗兽」的怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣セクトル
function c77642288.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77642288,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c77642288.spcon)
	e1:SetTarget(c77642288.sptg)
	e1:SetOperation(c77642288.spop)
	c:RegisterEffect(e1)
end
function c77642288.spcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.gbspcon(e,tp,eg,ep,ev,re,r,rp)
		and e:GetHandler():GetBattledGroupCount()>0
end
function c77642288.filter(c,e,tp)
	return not c:IsCode(77642288) and c:IsSetCard(0x1019) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c77642288.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c77642288.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if not Duel.IsExistingMatchingCard(c77642288.filter,tp,LOCATION_DECK,0,2,nil,e,tp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c77642288.filter,tp,LOCATION_DECK,0,2,2,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
