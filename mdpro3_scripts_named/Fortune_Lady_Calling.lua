--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 命运女郎呼召  (ID: 27895597)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 49
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「命运女郎」怪兽存在的场合才能发动。同名卡不在自己场上存在的1只「命运女郎」怪兽从卡组特殊召唤。这张卡的发动后，直到回合结束时自己不是同调怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--フォーチュンレディ・コーリング
function c27895597.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,27895597+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c27895597.spcon)
	e1:SetTarget(c27895597.sptg)
	e1:SetOperation(c27895597.spop)
	c:RegisterEffect(e1)
end
function c27895597.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x31)
end
function c27895597.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c27895597.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c27895597.tfilter(c,e,tp)
	return c:IsSetCard(0x31) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not Duel.IsExistingMatchingCard(c27895597.bfilter,tp,LOCATION_ONFIELD,0,1,nil,c)
end
function c27895597.bfilter(c,tc)
	return tc:IsCode(c:GetCode()) and c:IsFaceup()
end
function c27895597.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c27895597.tfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c27895597.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c27895597.tfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c27895597.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c27895597.splimit(e,c)
	return not c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_EXTRA)
end
