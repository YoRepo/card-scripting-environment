--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 显现的纹章  (ID: 84482694)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 146
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把自己场上1只怪兽解放才能发动。从卡组把2只「纹章兽」怪兽守备表示特殊召唤。这张卡的发动后，直到回合结束时自己不是念动力族怪兽以及机械族怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--顕現する紋章
function c84482694.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,84482694+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c84482694.cost)
	e1:SetTarget(c84482694.target)
	e1:SetOperation(c84482694.activate)
	c:RegisterEffect(e1)
end
function c84482694.costfilter(c,tp)
	return Duel.GetMZoneCount(tp,c)>1
end
function c84482694.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c84482694.costfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c84482694.costfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c84482694.spfilter(c,e,tp)
	return c:IsSetCard(0x76) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c84482694.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=e:GetLabel()==1 or Duel.GetLocationCount(tp,LOCATION_MZONE)>1
	if chk==0 then
		e:SetLabel(0)
		return res and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.IsExistingMatchingCard(c84482694.spfilter,tp,LOCATION_DECK,0,2,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c84482694.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerAffectedByEffect(tp,59822133) and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c84482694.spfilter,tp,LOCATION_DECK,0,2,2,nil,e,tp)
		if g:GetCount()==2 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c84482694.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c84482694.splimit(e,c)
	return not c:IsRace(RACE_PSYCHO+RACE_MACHINE) and c:IsLocation(LOCATION_EXTRA)
end
